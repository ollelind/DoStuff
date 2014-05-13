//
//  CategoryItemView.m
//  DoStuff
//
//  Created by Sebastian Bredberg on 12/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CategoryItemView.h"

@implementation CategoryItemView

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
    self.backgroundColor = COLOR_ORANGE;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.imageView.image = [UIImage imageNamed:category.imageURL];
    [self addSubview:self.imageView];
    
    return self;
}

-(void)selectItem{
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    }];
    
}
-(void)deselectItem{
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformScale(self.transform, 0.8, 0.8);
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
