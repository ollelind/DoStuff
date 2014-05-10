//
//  ActivityDAO.h
//  DoStuff
//
//  Created by Olle Lind on 08/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "BaseDAO.h"
#import "Activity.h"

@interface ActivityDAO : BaseDAO

-(Activity *)newActivityWithIdentifier:(int64_t)identifier
                                hostID:(int64_t)hostID
                                  name:(NSString *)name
                           information:(NSString *)information
                    activityCategories:(NSArray *)activityCategories
                                  date:(NSDate *)date;

@end
