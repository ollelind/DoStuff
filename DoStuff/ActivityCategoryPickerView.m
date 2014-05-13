//
//  ActivityCategoryPickerView.m
//  DoStuff
//
//  Created by Sebastian Bredberg on 12/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ActivityCategoryPickerView.h"
#import "ActivityCategory.h"
#import "ActivityCategoryDAO.h"
#import "CategoryItemView.h"

#define PADDING 5

@implementation ActivityCategoryPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Load data
        ActivityCategoryDAO *dao = [ActivityCategoryDAO buildDAO];
        self.categories = [dao listEntities];
        
        // Init properties
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor whiteColor];;
        [self addSubview:self.scrollView];
        
        [self reloadView];
    }
    return self;
}

-(void)reloadView{
    for(UIView *subview in self.scrollView.subviews){ [subview removeFromSuperview]; }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, 0);
    
    double scrollViewHeight = 0;
    for(int i=0; i<self.categories.count*5; i++){
        
        double x = PADDING + (i%(int)(self.scrollView.frame.size.width / CATEGORY_ITEM_SIZE.width)) * (CATEGORY_ITEM_SIZE.width + PADDING);
        int size = self.scrollView.frame.size.width;
        double divider =(i+1)*CATEGORY_ITEM_SIZE.width;
        int y = PADDING + (int)divider/size * (CATEGORY_ITEM_SIZE.height + PADDING);
        
        ActivityCategory *category = [self.categories objectAtIndex:0];
        CategoryItemView *itemView = [[CategoryItemView alloc]initWithCategory:category];
        itemView.tag = i;
        [itemView addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [itemView setOriginX:x];
        [itemView setOriginY:y];
        [self.scrollView addSubview:itemView];
        scrollViewHeight = MAX(scrollViewHeight, CGRectGetMaxY(itemView.frame) + PADDING);
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, scrollViewHeight);
    
    self.blurView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    self.blurView.backgroundColor = [UIColor blackColor];
    self.blurView.layer.opacity = 0.7;
    self.blurView.userInteractionEnabled = NO;
    
}

-(void)itemPressed:(UIControl *)item{
    CategoryItemView *categoryItem = (CategoryItemView *)item;
    if(categoryItem == self.selectedCategoryItem){
        [categoryItem deselectItem];
        [self removeBlurView];
        self.selectedCategoryItem = nil;
        return;
    }
    
    if(self.selectedCategoryItem){
        [self.selectedCategoryItem deselectItem];
    }
    self.selectedCategoryItem = categoryItem;
    [categoryItem selectItem];
    categoryItem.layer.zPosition = 100;
    [self showBlurView];
}

-(void)showBlurView{
    if(self.blurView.superview == nil){
        [self.scrollView addSubview:self.blurView];
        self.blurView.layer.opacity = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.blurView.layer.opacity = 0.6;
        }];
        
    }
}
-(void)removeBlurView{
    if(self.blurView.superview){
        [UIView animateWithDuration:0.2 animations:^{
            self.blurView.layer.opacity = 0;
        } completion:^(BOOL finished) {
            [self.blurView removeFromSuperview];
            self.selectedCategoryItem.layer.zPosition = 0;
        }];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
