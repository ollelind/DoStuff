//
//  User.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface User : BaseModel

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * birthdate;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * hometown;
@property (nonatomic, retain) NSString * facebookId;
@property (nonatomic) int64_t identifier;

@end
