//
//  CreateActivityViewController.m
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "DatePickerView.h"
#import "ActivityCategoryPickerView.h"
#import "FriendsPicker.h"

@interface CreateActivityViewController (){
    int level;
}

@end

@implementation CreateActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.backgroundColor = COLOR_BACKGROUND_GREY;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView addSubview:self.nextView];
    [self.view addSubview:self.scrollView];
    level = 0;
    [self showNextView];
}

-(void)showNextView{
    switch (level) {
        case 0:
            [self showDatePickerView];
            break;
        case 1:
            [self showFriendPickerView];
            break;
        default:
            break;
    }
}

-(void)showDatePickerView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.datePickerUpperBackground.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.datePickerUpperBackground.bounds;
    maskLayer.path = maskPath.CGPath;
    self.datePickerUpperBackground.layer.mask = maskLayer;
    self.datePickerUpperBackground.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    
    UIBezierPath *maskPathLower = [UIBezierPath bezierPathWithRoundedRect:self.datePickerLowerBackground.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayerLower = [[CAShapeLayer alloc] init];
    maskLayerLower.frame = self.datePickerLowerBackground.bounds;
    maskLayerLower.path = maskPathLower.CGPath;
    self.datePickerLowerBackground.layer.mask = maskLayerLower;
    self.datePickerLowerBackground.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];

    
    
    [self presentStep:self.datePickerView animated:YES];
}

-(void)showFriendPickerView{
    FriendsPicker *picker = [[FriendsPicker alloc]initWithFrame:CGRectMake(15, 0, 290, 200)];
    [self presentStep:picker animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{

}

-(void)presentStep:(UIView *)view animated:(BOOL)animated{
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, view.frame.size.width, 1)];
    divider.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    [view addSubview:divider];
    
    [self.scrollView addSubview:view];
    view.layer.zPosition = -level;
    level++;
    if(animated){
        [view setOriginY:self.scrollView.contentSize.height - view.frame.size.height];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view setOriginY:self.scrollView.contentSize.height];
            [self.nextView setOriginY:CGRectGetMaxY(view.frame)];
        } completion:nil];
        
    }else{
        [view setOriginY:self.scrollView.contentSize.height];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + view.frame.size.height);
    [self.scrollView scrollRectToVisible:CGRectMake(0, view.frame.origin.y, 320, 200) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextPressed:(id)sender {
    [self showNextView];
}
@end
