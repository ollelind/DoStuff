//
//  HeroHeaderView.h
//  DoStuff
//
//  Created by Olle Lind on 10/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"

#define kHeroHeaderViewHeight 35
@interface HeroHeaderView : UIView
@property (weak, nonatomic) IBOutlet CustomLabel *dateLabel;

@end
