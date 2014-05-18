//
//  HeroHeaderView.m
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "HeroHeaderView.h"


@implementation HeroHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [self setOriginX:0];
    /*[UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
     
    } completion:nil];*/
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
