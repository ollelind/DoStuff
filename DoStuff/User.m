//
//  User.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic name;
@dynamic birthdate;
@synthesize imageURL;
@dynamic hometown;
@dynamic facebookId;
@dynamic identifier;

-(NSString *)imageURL{
    if(self.facebookId.length > 0){
        return [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal&height=120&width=120", self.facebookId];
    }
    return nil;
}

@end
