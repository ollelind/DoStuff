//
//  BaseModel.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BaseModel : NSManagedObject

@property (nonatomic, strong) PFObject *parseObject;

- (NSDictionary *)properties;

@end
