//
//  DatePickerView.h
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView <UIScrollViewDelegate>

// Interface
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// Properties
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSMutableArray *datesArray;
@property (nonatomic, assign) CGFloat leftMargin;

@end
