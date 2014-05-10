//
//  UserDAO.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "BaseDAO.h"
#import "User.h"

@interface UserDAO : BaseDAO

-(User *)newUserWithName:(NSString *)name
               birthdate:(NSString *)birthdate
                hometown:(NSString *)hometown
              facebookId:(NSString *)facebookId
              identifier:(int64_t)identifier;

@end
