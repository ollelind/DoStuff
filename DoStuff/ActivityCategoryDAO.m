//
//  ActivityCategoryDAO.m
//  DoStuff
//
//  Created by Olle Lind on 08/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ActivityCategoryDAO.h"

@implementation ActivityCategoryDAO

-(ActivityCategory *)newItemWithName:(NSString *)name imageURL:(NSString *)imageURL{
    ActivityCategory *item;
    /*NSArray *array = [self listEntitiesWithValue:name forKey:@"name"];
    if(array.count > 0){
        item = array[0];
    }else{*/
        item = (ActivityCategory*)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ActivityCategory class]) inManagedObjectContext:self.managedObjectContext];
    //}
    item.name = name;
    item.imageURL = imageURL;
    [self save];
    return item;
}

@end
