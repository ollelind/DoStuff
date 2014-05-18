//
//  Helpers.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+(Helper *)shared;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

-(NSString *)getStringFromDate:(NSDate *)date;
+(NSString *)stringFromValue:(id)value;

@end
