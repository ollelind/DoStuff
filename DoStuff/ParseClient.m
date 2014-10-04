//
//  ParseClient.m
//  DoStuff
//
//  Created by Olle Lind on 30/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ParseClient.h"
#import <Parse/Parse.h>
#import "FacebookHandler.h"
#import "Profile.h"

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

-(void)saveObject:(BaseModel *)model{
    NSDictionary *attributes =  [model properties];
    PFObject *parseObject;
    if([model isKindOfClass:[Profile class]]){
        parseObject = [PFUser currentUser];
    }
    
    for(NSString *key in attributes.allKeys){
        id value = [attributes objectForKey:key];
        if(value){
            [parseObject setObject:value forKey:key];
        }
    }
    [parseObject saveInBackground];
    
}

#pragma mark - Social
-(void)loginFacebookWithPermissions:(NSArray *)permissions{
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user || error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:FB_ERROR object:error userInfo:nil];
            NSLog(@"Err: %@", error);
        }
        else {
           
            [[FBSession activeSession] refreshPermissionsWithCompletionHandler:^(FBSession *session, NSError *error) {
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Store the current user's Facebook ID on the user
                        [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_IN object:result userInfo:nil];
                        NSLog(@"FB_PERM: %@", [FBSession activeSession].declinedPermissions);
                    }
                }];
            }];
            // The login was successfull, now fetch the users data.
            
        }
    }];
}



@end
