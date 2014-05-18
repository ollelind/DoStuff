//
//  CategoryItemView.m
//  DoStuff
//
//  Created by Sebastian Bredberg on 12/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CategoryItemView.h"

@implementation CategoryItemView{
    CGRect realFrame;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCategory:(ActivityCategory *)category{
    self = [self initWithFrame:CGRectMake(0, 0, CATEGORY_ITEM_SIZE.width, CATEGORY_ITEM_SIZE.height)];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.imageView.image = [UIImage imageNamed:category.imageURL];
    self.backgroundColor = COLOR_BACKGROUND_GREY;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = COLOR_LIGHT_GREY.CGColor;
    [self addSubview:self.imageView];
    
    self.categoryNameLabel = [CustomLabel customBoldWithSize:FontSizeSmallText_12];
    self.categoryNameLabel.textAlignment = NSTextAlignmentCenter;
    self.categoryNameLabel.textColor = [UIColor whiteColor];
    self.categoryNameLabel.adjustsFontSizeToFitWidth = YES;
    self.categoryNameLabel.minimumScaleFactor = 0.5;
    self.categoryNameLabel.frame = CGRectMake(3, 0, self.frame.size.width-6, 20);
    self.categoryNameLabel.text = category.name;
    [self addSubview:self.categoryNameLabel];
    
    return self;
}

-(void)selectItem{
    self.layer.zPosition = 100;
    realFrame = self.frame;
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        double max = MIN(self.parentScrollView.frame.size.width, self.parentScrollView.frame.size.height);
        self.frame = CGRectMake(self.parentScrollView.frame.size.width/2-max/2, self.parentScrollView.contentOffset.y, max, max);
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion:nil];
    
}
-(void)deselectItem{
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = realFrame;
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.layer.zPosition = 0;
    }];
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
