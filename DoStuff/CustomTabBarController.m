//
//  CustomTabBarController.m
//  DoStuff
//
//  Created by Olle Lind on 06/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "HeroViewController.h"
#import "FriendsListViewController.h"
#import "CreateActivityViewController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (id)initAnimated:(BOOL)animated{
    self = [super init];
    if(self){
        self.delegate = self;
        
        FriendsListViewController *friendsListViewController = [[FriendsListViewController alloc]init];
        HeroViewController *heroViewController = [[HeroViewController alloc]init];
        CreateActivityViewController *activityViewController = [[CreateActivityViewController alloc]init];
        
        CustomNavigationController *heroNavCon = [[CustomNavigationController alloc]initWithRootViewController:heroViewController];
        CustomNavigationController *friendsNavCon = [[CustomNavigationController alloc]initWithRootViewController:friendsListViewController];
        CustomNavigationController *activityNavCon = [[CustomNavigationController alloc]initWithRootViewController:activityViewController];
        
        UITabBarItem *heroBarItem = [[UITabBarItem alloc] init];
        UITabBarItem *friendsBarItem = [[UITabBarItem alloc] init];
        UITabBarItem *activityBarItem = [[UITabBarItem alloc] init];
        
        [self customizeTabBarItem:heroBarItem];
        [self customizeTabBarItem:friendsBarItem];
        [self customizeTabBarItem:activityBarItem];
        
        [heroViewController setTabBarItem:heroBarItem];
        [friendsListViewController setTabBarItem:friendsBarItem];
        [activityViewController setTabBarItem:activityBarItem];
        
        heroViewController.title = @"Hero";
        friendsListViewController.title = @"Friends";
        activityViewController.title = @"Activity";
        
        [self setViewControllers:@[activityNavCon ,heroNavCon, friendsNavCon] animated:animated];
        [self setSelectedIndex:1];
    }
    return self;
}

-(void)customizeTabBarItem:(UITabBarItem *)item{
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : COLOR_ORANGE
                                   } forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor blackColor]
                                   } forState:UIControlStateDisabled];
    [item setTitleTextAttributes:@{
                                   //UITextAttributeFont : [UIFont fontWithProximaNovaBold:LifesumFont12_Footnote],
                                   NSForegroundColorAttributeName : [UIColor redColor]
                                   } forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
