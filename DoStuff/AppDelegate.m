//
//  AppDelegate.m
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "AppDelegate.h"
#import "SetupViewController.h"
#import "FacebookHandler.h"
#import "FriendsListViewController.h"
#import "DataManager.h"
#import "ParseClient.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Init Parse
    [ParseClient client];
    [[ParseClient client] trackAppStartWithLaunchOptions:launchOptions];
    
    // Init clients
    [DataManager client];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupFinished) name:SETUP_FINISHED object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbLoggedIn) name:FB_LOGGED_IN object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbLoggedOut) name:FB_LOGGED_OUT object:nil];
    
    //[FBLoginView class];

    //[[FacebookHandler client] checkIfFacebookIsAuthenticated];
    [self showSetup];
    [self customizeAppUI];
    
    return YES;
}

-(void)customizeAppUI{
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:[NSString stringWithFormat:@"%@-Medium",fontName] size:18.0] forKey:NSFontAttributeName];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];

}

-(void)fbLoggedIn{
    [self showTabBar];
}
-(void)fbLoggedOut{
    [self showSetup];
}

-(void)showSetup{
    SetupViewController *setupViewController = [[SetupViewController alloc]init];
    [self.window setRootViewController:setupViewController];
}
-(void)showTabBar{
    self.tabBarController = [[CustomTabBarController alloc]initAnimated:YES];
    [self.window setRootViewController:self.tabBarController];
}

-(void)setupFinished{
    [self showTabBar];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    /*BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    [FBSession.activeSession setStateChangeHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         // Call the sessionStateChanged:state:error method to handle session state changes
         [[FacebookHandler client] sessionStateChanged:session state:state error:error];
     }];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;*/
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager client] saveContext];
}

@end
