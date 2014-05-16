//
//  HeroCell.m
//  DoStuff
//
//  Created by Olle Lind on 07/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "HeroCell.h"
#import "User.h"

@implementation HeroCell

- (void)awakeFromNib
{
    // Initialization code

    self.container.layer.cornerRadius = 5.0;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.container.bounds byRoundingCorners:(UIRectCornerTopLeft) cornerRadii:CGSizeMake(30, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.container.layer.mask = maskLayer;
    
    self.container.layer.borderColor = COLOR_LIGHT_GREY.CGColor;
    self.container.layer.borderWidth = 1.0;
}

-(void)setActivity:(Activity *)activity{
    [self.nameLabel setText:activity.name];
    [self.informationLabel setText:activity.information];
    [self.profileImageView setImageURL:activity.host.imageURL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(double)defaultCellHeight{
    return 111;
}

@end
