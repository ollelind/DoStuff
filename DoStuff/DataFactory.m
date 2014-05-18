//
//  DataFactory.m
//  DoStuff
//
//  Created by Olle Lind on 07/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "DataFactory.h"
#import "ActivityCategoryDAO.h"
#import "Activity.h"
#import "ActivityDAO.h"
#import "User.h"
#import "UserDAO.h"

@implementation DataFactory

-(void)populateCategories{
    ActivityCategoryDAO *dao = [ActivityCategoryDAO buildDAO];
    [dao newItemWithName:@"Drinking" imageURL:@"category_training"];
    [dao newItemWithName:@"Sporting" imageURL:@"category_training"];
    [dao newItemWithName:@"Gaming" imageURL:@"category_training"];
}

-(void)populateActivities{
    UserDAO *userDao = [UserDAO buildDAO];
    NSArray *users = [userDao listEntities];
    if(users.count > 0){
        ActivityCategoryDAO *acDao = [ActivityCategoryDAO buildDAO];
        NSArray *categories = [acDao listEntities];
        ActivityDAO *activityDao = [ActivityDAO buildDAO];
        if(categories.count > 0){
            for(int i=0; i<20; i++){
                User *user = users[arc4random()%users.count];
                ActivityCategory *category = categories[arc4random()%categories.count];
                [activityDao newActivityWithIdentifier:arc4random()%100000
                                                hostID:user.identifier
                                                  name:category.name
                                           information:@"Information about the activity, place etc.."
                                    activityCategories:@[category]
                                                  date:[NSDate dateWithTimeIntervalSinceNow:-arc4random()%60*60*24*10]];
            }
        }
    }
}

@end
