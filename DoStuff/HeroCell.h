//
//  HeroCell.h
//  DoStuff
//
//  Created by Olle Lind on 07/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Activity.h"
#import "ProfilePictureImageView.h"
#import "CustomLabel.h"

@interface HeroCell : CustomTableViewCell
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet ProfilePictureImageView *profileImageView;
@property (weak, nonatomic) IBOutlet CustomLabel *nameLabel;
@property (weak, nonatomic) IBOutlet CustomLabel *informationLabel;

-(void)setActivity:(Activity *)activity;

@end
