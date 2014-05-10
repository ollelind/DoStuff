//
//  LoginViewController.m
//  DoStuff
//
//  Created by Olle Lind on 30/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions: @[@"basic_info", @"email", @"user_friends"]];
    loginView.delegate = self;
    [loginView setOriginX:screenSize.width/2 -loginView.frame.size.width/2];
    [loginView setOriginY:100];
    [self.view addSubview:loginView];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
