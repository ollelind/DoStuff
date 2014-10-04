//
//  GreetingsView.m
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "GreetingsView.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "FacebookHandler.h"
#import "Profile.h"
#import "ProfileDAO.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation GreetingsView

-(void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbLoggedIn:) name:FB_LOGGED_IN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbError:) name:FB_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbFriendsFetched:) name:FB_FRIENDS_FETCHED object:nil];
    
    [self updateFacebookButton];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)fbLoggedIn:(NSNotification *)notification{
    
    // Parse the data
    NSDictionary<FBGraphUser> *user = [notification object];
    NSString *facebookID = [user objectID];
    NSString *birthday = [user birthday];
    NSString *firstname = [user first_name];
    NSString *lastname = [user last_name];
    NSString *email = [user objectForKey:@"email"];
    NSString *genderString = [user objectForKey:@"gender"];
    NSString *hometown = [[user objectForKey:@"hometown"] objectForKey:@"name"];
    BOOL verifiedFacebookUser = [[user valueForKey:@"verified"] boolValue];
    BOOL gender;
    if([genderString isEqualToString:@"male"]){
        gender = YES;
    }else{
        gender = NO;
    }
    FBSession *session = FBSession.activeSession;
    FBAccessTokenData *accessTokenData = session.accessTokenData;
    NSString *facebookToken = accessTokenData.accessToken;
    
    ProfileDAO *profileDao = [ProfileDAO buildDAO];
    [profileDao newProfileWithIdentifier:facebookID
                               firstname:firstname
                                lastname:lastname
                                   email:email
                               birthdate:birthday
                                hometown:hometown
                                  gender:gender
                           facebookToken:facebookToken
                          verifiedFbUser:verifiedFacebookUser];
    
    [[FacebookHandler client] fetchFriends];
    [self updateFacebookButton];
}

-(void)fbLoggedOut{
    [self updateFacebookButton];
}

-(void)fbError:(NSNotification *)notification{
    NSError *errorString = [notification object];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ops!" message:errorString.description delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
}

-(void)fbFriendsFetched:(NSNotification *)notification{
    NSMutableArray *friends = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:SETUP_FINISHED object:nil];
}


-(void)updateFacebookButton{
    NSString *labelString;
    if([[FacebookHandler client] isAuthenticated]){
        labelString = @"Log out";
    }else{
        labelString = @"Login with Facebook";
    }
    [self.facebookButton setTitle:labelString forState:UIControlStateNormal];
}


- (IBAction)facebookButtonPressed:(id)sender {
    [self.facebookButton setTitle:@"Fetching data..." forState:UIControlStateNormal];
    [[FacebookHandler client] login];
    
}
@end
