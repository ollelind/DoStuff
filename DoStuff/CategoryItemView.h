//
//  CategoryItemView.h
//  DoStuff
//
//  Created by Sebastian Bredberg on 12/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCategory.h"

#define CATEGORY_ITEM_SIZE CGSizeMake(65,65)

@interface CategoryItemView : UIControl

@property (nonatomic, strong) UIImageView *imageView;

-(id)initWithCategory:(ActivityCategory *)category;
-(void)selectItem;
-(void)deselectItem;

@end
