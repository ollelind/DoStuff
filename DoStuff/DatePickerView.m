//
//  DatePickerView.m
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "DatePickerView.h"
#import "NSDate-Utilities.h"
#import "CustomLabel.h"
#import "Helper.h"

#define kDateItemSidePadding 5
#define kDateItemHeight 40
#define kDateItemWidth 80

@implementation DatePickerView

-(void)awakeFromNib{
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, self.scrollView.frame.size.height);
    self.scrollView.delegate = self;
    
    // Clear properties
    self.datesArray = [NSMutableArray array];
    self.leftMargin = 0;
    
    [self addNumberOfDates:10];
}

-(void)addNumberOfDates:(int)number{
    
    for(int i=0; i<number; i++){
        NSDate *date = [[NSDate date] dateByAddingDays:self.datesArray.count];
        
        UIView *item = [self itemForDate:date];
        [self.datesArray addObject:item];
        if(self.leftMargin == 0){
            self.leftMargin = self.scrollView.frame.size.width/2 - kDateItemWidth/2;
        }
        [item setOriginX:self.scrollView.contentSize.width + self.leftMargin];
        [self.scrollView addSubview:item];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + kDateItemWidth, self.scrollView.contentSize.height);
        
    }
}

-(UIView *)itemForDate:(NSDate *)date{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDateItemWidth + kDateItemSidePadding*2, kDateItemHeight)];
    container.tag = 1;
    
    CustomLabel *dateLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, kDateItemWidth-kDateItemSidePadding*2, kDateItemHeight)];
    dateLabel.tag = 2;
    dateLabel.numberOfLines = 1;
    dateLabel.adjustsFontSizeToFitWidth = YES;
    dateLabel.minimumScaleFactor = 0.5;
    dateLabel.text = [[Helper shared] getStringFromDate:date];
    dateLabel.center = container.center;
    
    [container addSubview:dateLabel];
    
    return container;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double middleX = scrollView.contentOffset.x + self.leftMargin;
    int index = (middleX / kDateItemWidth) - 1;
    for(int i=0; i<self.datesArray.count; i++){
        UIView *view = [self.datesArray objectAtIndex:i];
        CustomLabel *label = (CustomLabel *)[view viewWithTag:2];
        if(i == index){
            label.textColor = COLOR_ORANGE;
        }else{
            label.textColor = [UIColor blackColor];
        }
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
