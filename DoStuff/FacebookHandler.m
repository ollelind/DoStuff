//
//  FacebookHandler.m
//  DoStuff
//
//  Created by Olle Lind on 30/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "FacebookHandler.h"
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"
#import "UserDAO.h"
#import "ParseClient.h"

@implementation FacebookHandler{
    NSArray *permissions;
}

static FacebookHandler *_client = nil;


-(id)init{
    if (self = [super init]) {
        permissions = @[@"public_profile", @"email", @"user_friends",@"user_birthday",@"friends_hometown",
                        @"friends_birthday",@"friends_location"];
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
    return (FBSession.activeSession.state == FBSessionStateOpen || FBSession.activeSession.state == FBSessionStateOpenTokenExtended);
}
-(void)checkIfFacebookIsAuthenticated{
    // Whenever a person opens the app, check for a cached session
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithPermissions:permissions
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:FB_LOGGED_OUT object:nil];
    }
}

-(void)login{
    // If the session state is any of the two "open" states when the button is clicked
    /*if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [self sessionStateChanged:session state:state error:error];
         }];
    }*/
    [[ParseClient client] loginFacebookWithPermissions:permissions];
}


-(void)fetchFriends{
    FBRequest *friendRequest = [FBRequest requestForGraphPath:@"me/friends?fields=name,picture,birthday,location"];
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
}

-(void)askForFacebookPermissions{
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        NSLog(@"permissions::%@",FBSession.activeSession.permissions);
    }];
}

#pragma mark - Facebook helpers and delegate
// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
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
}


@end
