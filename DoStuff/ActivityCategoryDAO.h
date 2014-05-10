//
//  ActivityCategoryDAO.h
//  DoStuff
//
//  Created by Olle Lind on 08/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "BaseDAO.h"
#import "ActivityCategory.h"

@interface ActivityCategoryDAO : BaseDAO

-(ActivityCategory *)newItemWithName:(NSString *)name imageURL:(NSString *)imageURL;

@end
