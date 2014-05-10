//
//  ProfileDAO.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ProfileDAO.h"

@implementation ProfileDAO

-(Profile *)newProfileWithFirstname:(NSString *)firstname
                           lastname:(NSString *)lastname
                              email:(NSString *)email
                          birthdate:(NSString *)birthdate
                           hometown:(NSString *)hometown
                             gender:(BOOL)gender
                           imageURL:(NSString *)imageURL
                      facebookToken:(NSString *)facebookToken
                     verifiedFbUser:(BOOL)verifiedFbUser
{
    Profile *item = (Profile *)[self latestObject];
    if(item == nil){
         item = (Profile *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Profile class]) inManagedObjectContext:self.managedObjectContext];
    }
    item.firstname = firstname;
    item.lastname = lastname;
    item.email = email;
    item.birthdate = birthdate;
    item.hometown = hometown;
    item.gender = gender;
    item.imageURL = imageURL;
    item.facebookToken = facebookToken;
    item.verifiedFacebookUser = verifiedFbUser;
    [self save];
    return item;
}

@end
