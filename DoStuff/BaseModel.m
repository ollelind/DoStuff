//
//  BaseModel.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (NSDictionary *)properties{
    // for all properties
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithCapacity:numberOfProperties];
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *key = [[NSString alloc] initWithUTF8String:property_getName(property)];
        NSString *value = [self valueForKey:key];
        if(value){
            [dictionary setObject:value forKey:key];
        }
    }
    free(propertyArray);
    return dictionary;
}

@end
