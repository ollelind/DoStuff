//
//  Profile.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface Profile : BaseModel

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * birthdate;
@property (nonatomic, retain) NSString * hometown;
@property (nonatomic, retain) NSString * facebookToken;
@property (nonatomic) BOOL gender;
@property (nonatomic) BOOL verifiedFacebookUser;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * identifier;

@end
