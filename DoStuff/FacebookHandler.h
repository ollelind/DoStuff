//
//  FacebookHandler.h
//  DoStuff
//
//  Created by Olle Lind on 30/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FB_LOGGED_IN @"FB_LOGGED_IN"
#define FB_LOGGED_OUT @"FB_LOGGED_OUT"
#define FB_ERROR @"FB_ERROR"
#define FB_FRIENDS_FETCHED @"FB_FRIENDS_FETCHED"

@interface FacebookHandler : NSObject

+(FacebookHandler *)client;

-(BOOL)isAuthenticated;
-(void)login;
-(void)checkIfFacebookIsAuthenticated;
-(void)askForFacebookPermissions;
-(void)fetchFriends;

//-(void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

@end
