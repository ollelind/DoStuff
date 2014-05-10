//
//  Helpers.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

+(NSString *)stringFromValue:(id)value{
    NSString *valueString = @"";
    if([value isKindOfClass:[NSNumber class]]){
        NSNumber *valueObject = (NSNumber *)value;
        if(((int)(valueObject.doubleValue*10) % 10) > 0){
            valueString = [NSString stringWithFormat:@"%.2f", valueObject.doubleValue];
        }else{
            valueString = [NSString stringWithFormat:@"%.0f", valueObject.doubleValue];
        }
        
    }else if([value isKindOfClass:[NSString class]]){
        valueString = (NSString *)value;
    }else{
        NSObject *object = (NSObject *)value;
        valueString = object.description;
    }
    return valueString;
}

@end
