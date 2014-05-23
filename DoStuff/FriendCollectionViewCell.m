//
//  FriendCollectionViewCell.m
//  DoStuff
//
//  Created by Sebastian Bredberg on 15/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "FriendCollectionViewCell.h"
#import "User.h"

@implementation FriendCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    self.nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

-(void)setUser:(User *)user{
    self.nameLabel.text = user.name;
    [self.profileImageView setImageURL:user.imageURL];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
