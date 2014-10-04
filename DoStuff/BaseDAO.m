//
//  BaseDAO.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "BaseDAO.h"
#import "DataManager.h"
#import "BaseModel.h"
#import "ParseClient.h"


@implementation BaseDAO

+(id) buildDAO{
    id newDAO = [[self alloc] init];
    return newDAO;
}

- (NSManagedObjectContext *)managedObjectContext{
    return [DataManager client].managedObjectContext;
}

-(void)save{
    [[DataManager client]saveContext];
}
-(void)saveAndPush:(BaseModel *)object{
    [self save];
    [[ParseClient client] saveObject:object];
}

//generic method to list all the entities in the table
-(NSString *)getEntityName{
    NSString *entityName =NSStringFromClass([self class]);
    return [entityName stringByReplacingOccurrencesOfString:@"DAO" withString:@""];
}
-(NSArray*) listEntities{
    return [self listEntitiesWithContext:self.managedObjectContext];
}

-(NSArray*) listEntitiesWithContext:(NSManagedObjectContext*)context{
    NSString *entityName = [self getEntityName];
    NSManagedObjectContext *moc = context;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    NSUInteger length = [array count];
    if (array != nil && length > 0)
    {
        return array;
    } else {
        return nil;
    }
}

-(BaseModel *) latestObject{
    return [self latestObject:self.managedObjectContext reverse:NO];
}
-(BaseModel *) oldestObject{
    return [self latestObject:self.managedObjectContext reverse:YES];
}
-(BaseModel *) latestObject:(NSManagedObjectContext*)context reverse:(BOOL)reverse{
    NSArray *items = [self listEntitiesWithContext:context];
    if(items.count  > 0){
        if(reverse){
            return items[0];
        }else{
            return items[items.count-1];
        }
    }
    
    return nil;
}

// Specific value for key
-(NSArray *) listEntitiesWithValue:(NSString *)value forKey:(NSString *)key{
    return [self listEntitiesWithValue:value forKey:key context:self.managedObjectContext];
}

-(NSArray *) listEntitiesWithValue:(NSString *)value forKey:(NSString *)key context:(NSManagedObjectContext *)context{
    NSString *className = [self getEntityName];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:className inManagedObjectContext:context];
    if (!entityDescription) {//NOTE: A fetch request must have an entity. Recheck it so we don't have unexpected crashes
        return nil;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set predicate and ordering - we are reusing the predicate everytime, just replacing variables
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ == %@", key, value]];
    [request setPredicate:predicate];
    NSArray *array = [context executeFetchRequest:request error:nil];
    return array;
}

// By identifier
-(NSArray *) listEntitiesWithIdentifier:(int64_t)identifier{
    return [self listEntitiesWithIdentifier:(int64_t)identifier context:self.managedObjectContext];
}

-(NSArray *) listEntitiesWithIdentifier:(int64_t)identifier context:(NSManagedObjectContext *)context{
    NSString *className = [self getEntityName];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:className inManagedObjectContext:context];
    if (!entityDescription) {//NOTE: A fetch request must have an entity. Recheck it so we don't have unexpected crashes
        return nil;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set predicate and ordering - we are reusing the predicate everytime, just replacing variables
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"identifier = %lld", identifier]];
    [request setPredicate:predicate];
    NSArray *array = [context executeFetchRequest:request error:nil];
    if(array.count > 0){
        return array[0];
    }
    return nil;
}

// Sorted by attribute
-(NSArray *) listEntitiesSortedByAttribute:(NSString *)attribute{
    return [self listEntitiesSortedByAttribute:attribute context:self.managedObjectContext];
}

-(NSArray *) listEntitiesSortedByAttribute:(NSString *)attribute context:(NSManagedObjectContext *)context{
    NSString *entityName = [self getEntityName];
    NSManagedObjectContext *moc = context;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:attribute ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    NSUInteger length = [array count];
    if (array != nil && length > 0)
    {
        return array;
    } else {
        return nil;
    }
}

// Count entities
//return the total number of entities for this specific entity
-(NSUInteger) countEntities{
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSString *entityName =NSStringFromClass([self class]);
    entityName = [entityName stringByReplacingOccurrencesOfString:@"DAO" withString:@""];
    return [self countEntitiesWithClassName:entityName context:moc];
}
-(NSUInteger) countEntitiesWithContext:(NSManagedObjectContext*)context{
    NSString *entityName =NSStringFromClass([self class]);
    entityName = [entityName stringByReplacingOccurrencesOfString:@"DAO" withString:@""];
    return [self countEntitiesWithClassName:entityName context:context];
}
//return the total number of entities for a given entity name
-(NSUInteger) countEntitiesWithClassName:(NSString*)entityName context:(NSManagedObjectContext*)moc{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    //we won't count or list entities marked as deleted
    NSError *error = nil;
    NSUInteger count = [moc countForFetchRequest:request error:&error];
    return count;
}

@end
