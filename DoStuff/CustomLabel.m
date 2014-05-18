//
//  CustomLabel.m
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

static NSString *fontName = @"Helvetica";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{

}

+(CustomLabel *)customRegularWithSize:(FontSize)size{
    return [CustomLabel customLabelWithType:@"Regular" size:size];
}
+(CustomLabel *)customMediumWithSize:(FontSize)size{
    return [CustomLabel customLabelWithType:@"Medium" size:size];
}
+(CustomLabel *)customBoldWithSize:(FontSize)size{
    return [CustomLabel customLabelWithType:@"Bold" size:size];
}

+(CustomLabel *)customLabelWithType:(NSString *)textType size:(FontSize)size{
    CustomLabel *label = [[CustomLabel alloc]init];
    label.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-%@", fontName, textType] size:size];
    label.textColor = COLOR_DARK_GREY;
    return label;
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
