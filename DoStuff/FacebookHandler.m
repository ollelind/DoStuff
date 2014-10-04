//
//  FacebookHandler.m
//  DoStuff
//
//  Created by Olle Lind on 30/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "FacebookHandler.h"
#import "User.h"
#import "UserDAO.h"
#import "ParseClient.h"

@implementation FacebookHandler{
    NSArray *permissions;
}

static FacebookHandler *_client = nil;


-(id)init{
    if (self = [super init]) {
        permissions = @[@"public_profile", @"email", @"user_friends"];
        //permissions = @[@"public_profile"];
    }
    
    return self;
}

+(FacebookHandler *)client{
    static dispatch_once_t onceToken;
    //thread-safe way to create a singleton
    dispatch_once(&onceToken, ^{
        _client = [[FacebookHandler allocWithZone:nil] init];
    });
    return _client;
}

#pragma mark - API
-(BOOL)isAuthenticated{
    return NO;
}
-(void)checkIfFacebookIsAuthenticated{
}

-(void)login{
    [[ParseClient client] loginFacebookWithPermissions:permissions];
}


-(void)fetchFriends{
    /*[[FBSession activeSession] requestNewReadPermissions:@[@"user_friends"] completionHandler:^(FBSession *session, NSError *error) {
        NSArray *current = [FBSession activeSession].permissions;
        NSLog(@"Perm: %@", current);
    }];*/
    
    NSArray *perm = [FBSession activeSession].permissions;
    NSLog(@"current perm: %@", perm);
    
    
    FBRequest *friendRequest = [FBRequest requestForGraphPath:@"me/taggable_friends"];
    [ friendRequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSArray *data = [result objectForKey:@"data"];
        NSMutableArray *friends = [NSMutableArray array];
        UserDAO *userDao = [UserDAO buildDAO];
        for (FBGraphObject<FBGraphUser> *friend in data) {
            User *user = [userDao newUserWithName:friend.name
                                        birthdate:friend.birthday
                                         hometown:friend[@"location"][@"name"]
                                       facebookId:friend.id
                                       identifier:(int)friend.id];
            [friends addObject:user];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:FB_FRIENDS_FETCHED object:friends];
    }];
    
    /*[FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result wifall contain an array with your user's friends in the "data" key
            NSArray *friendObjects = [result objectForKey:@"data"];
            NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
            // Create a list of friends' Facebook IDs
            for (NSDictionary *friendObject in friendObjects) {
                [friendIds addObject:[friendObject objectForKey:@"id"]];
            }
            
            // Construct a PFUser query that will find friends whose facebook ids
            // are contained in the current user's friend list.
            PFQuery *friendQuery = [PFUser query];
            [friendQuery whereKey:@"fbId" containedIn:friendIds];
            
            // findObjects will return a list of PFUsers that are friends
            // with the current user
            NSArray *friendUsers = [friendQuery findObjects];
        }
    }];*/
}

-(void)askForFacebookPermissions{
    /*[FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        NSLog(@"permissions::%@",FBSession.activeSession.permissions);
    }];*/
}

#pragma mark - Facebook helpers and delegate
// This method will handle ALL the session state changes in the app
/*- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 // Parse user data
                 [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_IN object:user];
             }else{
                 [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_OUT object:user];
             }
         }];

    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_OUT object:nil];
    }
    
    // Handle errors
    if (error){
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_OUT object:[FBErrorUtility userMessageForError:error]];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                NSLog(@"Session has expired");
                [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_OUT object:error];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                NSString *string = [NSString stringWithFormat:@"Facebook error with code: %@", [errorInformation objectForKey:@"message"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_OUT object:string];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}*/


@end
