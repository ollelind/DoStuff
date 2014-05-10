//
//  ActivityDAO.m
//  DoStuff
//
//  Created by Olle Lind on 08/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ActivityDAO.h"

@implementation ActivityDAO

-(Activity *)newActivityWithIdentifier:(int64_t)identifier
                                hostID:(int64_t)hostID
                                  name:(NSString *)name
                           information:(NSString *)information
                    activityCategories:(NSArray *)activityCategories
                                  date:(NSDate *)date
{
    Activity *item = (Activity *)[self listEntitiesWithIdentifier:identifier];
    if(item == nil){
        item = (Activity*)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Activity class]) inManagedObjectContext:self.managedObjectContext];
    }
    item.identifier = identifier;
    item.hostID = hostID;
    item.name = name;
    item.information = information;
    item.date = [date timeIntervalSinceReferenceDate];
    [item addCategories:[NSSet setWithArray:activityCategories]];
    [self save];
    return item;
}

@end
