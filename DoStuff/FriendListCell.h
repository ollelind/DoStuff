//
//  FriendListCell.h
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ProfilePictureImageView.h"
#import "CustomLabel.h"
#import "CustomTableViewCell.h"
#import "User.h"

@interface FriendListCell : CustomTableViewCell
@property (strong, nonatomic) IBOutlet ProfilePictureImageView *profileImageView;
@property (strong, nonatomic) IBOutlet CustomLabel *nameLabel;
@property (weak, nonatomic) IBOutlet CustomLabel *hometownLabel;

-(void)buildFromUser:(User *)user;

@end
