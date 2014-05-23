//
//  FriendCollectionViewCell.h
//  DoStuff
//
//  Created by Sebastian Bredberg on 15/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfilePictureImageView.h"
#import "CustomLabel.h"
#import "User.h"

@interface FriendCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet ProfilePictureImageView *profileImageView;
@property (weak, nonatomic) IBOutlet CustomLabel *nameLabel;

-(void)setUser:(User *)user;

@end
