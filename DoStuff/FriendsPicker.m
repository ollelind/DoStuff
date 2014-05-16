//
//  FriendsPicker.m
//  DoStuff
//
//  Created by Sebastian Bredberg on 15/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "FriendsPicker.h"
#import "FriendCollectionViewCell.h"

@implementation FriendsPicker{
    NSMutableArray *friends;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        friends = [NSMutableArray arrayWithObjects:@"Olle",@"Sebastian",@"Christoffer",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle",@"Olle", nil];
        
        UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [aFlowLayout setItemSize:CGSizeMake(80,80)];
        [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        aFlowLayout.minimumInteritemSpacing = 0;
        aFlowLayout.minimumLineSpacing = 5;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:aFlowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = COLOR_BACKGROUND_GREY;
        
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([FriendCollectionViewCell class]) bundle:nil];
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:NSStringFromClass([FriendCollectionViewCell class])];
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return friends.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = friends[indexPath.row];
    FriendCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FriendCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.nameLabel.text = name;
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    [self selectedAniamtionForCell:(FriendCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]];
    [friends removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

-(void)selectedAniamtionForCell:(FriendCollectionViewCell *)cell{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FriendCollectionViewCell class]) owner:self options:nil];
    FriendCollectionViewCell *animCell = [array objectAtIndex:0];
    animCell.frame = cell.frame;
    [self.collectionView addSubview:animCell];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [animCell setFrame:CGRectMake(0, -100, animCell.frame.size.width, animCell.frame.size.height)];
    } completion:nil];
}


@end
