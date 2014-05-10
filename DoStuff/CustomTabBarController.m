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

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (id)initAnimated:(BOOL)animated{
    self = [super init];
    if(self){
        self.delegate = self;
        self.view.backgroundColor = [UIColor blueColor];
        
        FriendsListViewController *friendsListViewController = [[FriendsListViewController alloc]init];
        HeroViewController *heroViewController = [[HeroViewController alloc]init];
        
        CustomNavigationController *heroNavCon = [[CustomNavigationController alloc]initWithRootViewController:heroViewController];
        CustomNavigationController *friendsNavCon = [[CustomNavigationController alloc]initWithRootViewController:friendsListViewController];
        
        UITabBarItem *heroBarItem = [[UITabBarItem alloc] init];
        UITabBarItem *friendsBarItem = [[UITabBarItem alloc] init];
        
        [self customizeTabBarItem:heroBarItem];
        [self customizeTabBarItem:friendsBarItem];
        
        [heroViewController setTabBarItem:heroBarItem];
        [friendsListViewController setTabBarItem:friendsBarItem];
        
        heroBarItem.title = @"Hero";
        friendsBarItem.title = @"Friends";
        
        [[UITabBar appearance] setTintColor:[UIColor greenColor]];
        
        [self setViewControllers:@[heroNavCon, friendsNavCon] animated:animated];
    }
    return self;
}

-(void)customizeTabBarItem:(UITabBarItem *)item{
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor blueColor]
                                   } forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor greenColor]
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
