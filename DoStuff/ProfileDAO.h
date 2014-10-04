//
//  ProfileDAO.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "BaseDAO.h"
#import "Profile.h"

@interface ProfileDAO : BaseDAO

-(Profile *)newProfileWithIdentifier:(NSString *)identifier
                           firstname:(NSString *)firstname
                            lastname:(NSString *)lastname
                               email:(NSString *)email
                           birthdate:(NSString *)birthdate
                            hometown:(NSString *)hometown
                              gender:(BOOL)gender
                       facebookToken:(NSString *)facebookToken
                      verifiedFbUser:(BOOL)verifiedFbUser;

@end
