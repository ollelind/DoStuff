//
//  CustomTableViewCell.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

+(UINib *)nib;
+(NSString *)identifier;
+(double)defaultCellHeight;

@end
