//
//  Helpers.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "Helper.h"
#import "NSDate-Utilities.h"

@implementation Helper

static Helper *_shared = nil;

+(Helper *)shared{
    static dispatch_once_t onceToken;
    //thread-safe way to create a singleton
    dispatch_once(&onceToken, ^{
        _shared = [[Helper allocWithZone:nil] init];
    });
    return _shared;
}

-(id)init{
    self = [super init];
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"EEEE dd MMMM"];
    
    return self;
}

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

-(NSString *)getStringFromDate:(NSDate *)date{
    NSString *dateString = nil;
    if([date isToday]){
        dateString = @"Today!";
    }else if([date isTomorrow]){
        dateString = @"Tomorrow!";
    }else{
        dateString = [self.dateFormatter stringFromDate:date];
    }
    return dateString;
}

@end
