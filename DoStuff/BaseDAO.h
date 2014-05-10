//
//  BaseDAO.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseModel.h"

@interface BaseDAO : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+(id)buildDAO;
-(NSArray *) listEntities;
-(NSArray *) listEntitiesSortedByAttribute:(NSString *)attribute;
-(NSArray *) listEntitiesWithValue:(NSString *)value forKey:(NSString *)key;
-(NSArray *) listEntitiesWithIdentifier:(int64_t)identifier;
-(NSUInteger) countEntities;
-(BaseModel *) latestObject;
-(BaseModel *) oldestObject;

-(void)save;

@end
