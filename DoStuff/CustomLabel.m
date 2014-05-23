//
//  CustomLabel.m
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    NSString *textWight;
    NSLog(@"%@", self.font.fontName);
    if([self.font.fontName rangeOfString:@"Regular"].location != NSNotFound){
        textWight = @"Light";
    }
    else if([self.font.fontName rangeOfString:@"Medium"].location != NSNotFound){
        textWight = @"Medium";
    }
    else if([self.font.fontName rangeOfString:@"Bold"].location != NSNotFound){
        textWight = @"Bold";
    }
    else{
        textWight = @"Light";
    }
    self.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@-%@", fontName, textWight] size:self.font.pointSize];
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
