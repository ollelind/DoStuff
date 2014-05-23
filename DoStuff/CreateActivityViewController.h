//
//  CreateActivityViewController.h
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateActivityViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *nextView;
- (IBAction)nextPressed:(id)sender;


// Date picker
@property (strong, nonatomic) IBOutlet UIView *datePickerView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerLowerBackground;
@property (weak, nonatomic) IBOutlet UIView *datePickerUpperBackground;

@end
