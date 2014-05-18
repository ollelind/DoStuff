//
//  CategoryItemView.h
//  DoStuff
//
//  Created by Sebastian Bredberg on 12/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCategory.h"
#import "CustomLabel.h"

#define CATEGORY_ITEM_SIZE CGSizeMake(65,65)

@interface CategoryItemView : UIControl

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CustomLabel *categoryNameLabel;
@property (nonatomic, strong) UIScrollView *parentScrollView;

-(id)initWithCategory:(ActivityCategory *)category;
-(void)selectItem;
-(void)deselectItem;

@end
