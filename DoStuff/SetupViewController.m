//
//  SetupViewController.m
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController (){
    NSMutableArray *views;
}

@end

@implementation SetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    views = [NSMutableArray array];
    self.scrollView.backgroundColor = COLOR_BACKGROUND_GREY;
    
    NSArray *temp = [[NSBundle mainBundle] loadNibNamed:@"GreetingsView" owner:self options:nil];
    GreetingsView *greetingsView = [temp objectAtIndex:0];
    greetingsView.delegate = self;
    
    temp = [[NSBundle mainBundle] loadNibNamed:@"SignUpInformationView" owner:self options:nil];
    SignUpInformationView *signUpInformationView = [temp objectAtIndex:0];
    
    temp = [[NSBundle mainBundle] loadNibNamed:@"ImportDataView" owner:self options:nil];
    ImportDataView *importDataView = [temp objectAtIndex:0];
    
    [self addViewToSetup:greetingsView];
    [self addViewToSetup:signUpInformationView];
    [self addViewToSetup:importDataView];
}

-(void)addViewToSetup:(UIView *)view{
    [views addObject:view];
    [self.scrollView addSubview:view];
    
    [view setOriginX:(views.count-1) * screenSize.width];
    
    self.scrollView.contentSize = CGSizeMake(views.count*screenSize.width, self.scrollView.frame.size.height);
    
}

#pragma mark - View Delegates
-(void)showNextView{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + screenSize.width, 0) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
