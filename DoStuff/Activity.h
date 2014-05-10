//
//  Activity.h
//  DoStuff
//
//  Created by Olle Lind on 07/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ActivityCategory, User;

@interface Activity : NSManagedObject

@property (nonatomic) int64_t identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * information;
@property (nonatomic) int64_t hostID;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain, getter = getHostLazy) User *host;
@property (nonatomic) NSTimeInterval date;
@end

@interface Activity (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(ActivityCategory *)value;
- (void)removeCategoriesObject:(ActivityCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
