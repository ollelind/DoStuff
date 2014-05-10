//
//  UserDAO.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "UserDAO.h"
#import "AppDelegate.h"

@implementation UserDAO

-(User *)newUserWithName:(NSString *)name
               birthdate:(NSString *)birthdate
                hometown:(NSString *)hometown
              facebookId:(NSString *)facebookId
              identifier:(int64_t)identifier
{
    NSArray *array = [self listEntitiesWithValue:facebookId forKey:@"facebookId"];
    User *user;
    if(array.count > 0){
        user = (User *)array[0];
    }else{
        user = (User*)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([User class]) inManagedObjectContext:self.managedObjectContext];
    }
    user.name = name;
    user.birthdate = birthdate;
    user.hometown = hometown;
    user.facebookId = facebookId;
    user.identifier = identifier;
    [self save];
    return user;
}

@end
