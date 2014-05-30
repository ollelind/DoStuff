//
//  FriendListCell.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "FriendListCell.h"

@implementation FriendListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    UIView *selectedContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, [FriendListCell defaultCellHeight])];
    selectedContainer.backgroundColor = [UIColor clearColor];
    UIView *selectedBackground = [[UIView alloc]initWithFrame:CGRectMake(28, 0, 292, 60)];
    selectedBackground.backgroundColor = COLOR_MAIN;
    [selectedContainer addSubview:selectedBackground];
    [self setSelectedBackgroundView:selectedContainer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)buildFromUser:(User *)user{
    if(self.nameLabel == nil){
    }
    self.nameLabel.text = user.name;
    self.hometownLabel.text = user.hometown;
    [self.profileImageView setImageURL:user.imageURL];
}



+(double)defaultCellHeight{
    return 65;
}

@end
