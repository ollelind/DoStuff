//
//  ActivityCategoryPickerView.h
//  DoStuff
//
//  Created by Sebastian Bredberg on 12/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryItemView.h"

@interface ActivityCategoryPickerView : UIView

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CategoryItemView *selectedCategoryItem;
@property (nonatomic, strong) UIView *blurView;
@property (nonatomic, strong) ActivityCategory *selectedCategory;

@end
