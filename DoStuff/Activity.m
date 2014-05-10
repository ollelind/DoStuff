//
//  Activity.m
//  DoStuff
//
//  Created by Olle Lind on 07/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "Activity.h"
#import "ActivityCategory.h"
#import "User.h"
#import "UserDAO.h"


@implementation Activity

@dynamic identifier;
@dynamic name;
@dynamic information;
@dynamic hostID;
@dynamic categories;
@dynamic host;
@dynamic date;


-(User *)getHostLazy{
    [self willAccessValueForKey:@"host"];
    User *currentItem =  [self valueForKey:@"host"];
    [self didAccessValueForKey:@"host"];
    if (currentItem) {
        return currentItem;
    }
    //this foodDiary is not linked to a foodItem yet, we will try to build the relationship
    if (self.hostID) {
        UserDAO *userDao = [UserDAO buildDAO];
        User *user = (User*)[userDao listEntitiesWithIdentifier:self.hostID];
        self.host = user;
        currentItem = user;
    }
    return currentItem;
}
@end
