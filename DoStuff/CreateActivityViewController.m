//
//  CreateActivityViewController.m
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "DatePickerView.h"

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
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePickerView)];
    [self.view addGestureRecognizer:tap];
    level = 0;
    
}
-(void)showDatePickerView{
    NSArray *temp = [[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil];
    DatePickerView *datePickerView = [temp objectAtIndex:0];
    [self presentStep:datePickerView animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{

}

-(void)presentStep:(UIView *)view animated:(BOOL)animated{
    view.backgroundColor = COLOR_BACKGROUND_GREY;
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
        } completion:nil];
        
    }else{
        [view setOriginY:self.scrollView.contentSize.height];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
