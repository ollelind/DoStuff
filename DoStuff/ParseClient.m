//
//  ParseClient.m
//  DoStuff
//
//  Created by Olle Lind on 30/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ParseClient.h"
#import <Parse/Parse.h>

@implementation ParseClient

static ParseClient *_client;
static NSString *parseAppId = @"crv2qIr7XCKT9lr8Dh0T8bRh7j0GbZ6mavSiMUC5";
static NSString *parseClientKey = @"ejGwbdvrTSvNyPCMSnxEMOlmPQMoFm7QnTkzKYzX";

-(id)init{
    self = [super init];
    if(self){
        [Parse setApplicationId:parseAppId clientKey:parseClientKey];
        [PFFacebookUtils initializeFacebook];
    }
    return self;
}

-(void)trackAppStartWithLaunchOptions:(NSDictionary *)launchOptions{
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

+(ParseClient *)client{
    static dispatch_once_t onceToken;
    //thread-safe way to create a singleton
    dispatch_once(&onceToken, ^{
        _client = [[ParseClient allocWithZone:nil] init];
    });
    return _client;
}



#pragma mark - Social
-(void)loginFacebookWithPermissions:(NSArray *)permissions{
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        NSLog(@"Err: %@", error);
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];

}


@end
