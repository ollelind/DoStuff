//
//  ParseClient.h
//  DoStuff
//
//  Created by Olle Lind on 30/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ParseClient : NSObject

+(ParseClient *)client;

-(void)trackAppStartWithLaunchOptions:(NSDictionary *)launchOptions;

-(void)saveObject:(BaseModel *)model;


#pragma mark - Social
-(void)loginFacebookWithPermissions:(NSArray *)permissions;

@end
