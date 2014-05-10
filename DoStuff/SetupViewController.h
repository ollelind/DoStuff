//
//  SetupViewController.h
//  DoStuff
//
//  Created by Olle Lind on 28/04/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreetingsView.h"
#import "ImportDataView.h"
#import "SignUpInformationView.h"

@interface SetupViewController : UIViewController<GreetingsViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

// Views


@end
