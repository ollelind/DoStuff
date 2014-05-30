//
//  ParseClient.h
//  DoStuff
//
//  Created by Olle Lind on 30/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseClient : NSObject

+(ParseClient *)client;

-(void)trackAppStartWithLaunchOptions:(NSDictionary *)launchOptions;


#pragma mark - Social
-(void)loginFacebookWithPermissions:(NSArray *)permissions;

@end
