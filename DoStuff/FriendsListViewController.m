//
//  FriendsListViewController.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "FriendsListViewController.h"
#import "User.h"
#import "UserDAO.h"
#import "SDWebImageManager.h"
#import "FriendListCell.h"

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController{
    NSArray *friends;
    NSMutableDictionary *sections;
    NSArray *sectionIndexes;
}

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
    [self.navigationItem setTitle:@"Homies"];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, navBar.frame.size.height)];
    searchBar.delegate = self;
    searchBar.tintColor = COLOR_ORANGE;
    searchBar.backgroundColor = COLOR_BACKGROUND_GREY;
    [navBar addSubview:searchBar];
    
    _table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [_table registerNib:[FriendListCell nib] forCellReuseIdentifier:[FriendListCell identifier]];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = COLOR_BACKGROUND_GREY;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.separatorColor = [UIColor clearColor];
    
    UserDAO *userDao = [UserDAO buildDAO];
    friends = [userDao listEntitiesSortedByAttribute:@"name"];
    [self.view addSubview:_table];
    [self loadFriends:@""];
}

-(void)loadFriends:(NSString *)filter{
    
    sections = [NSMutableDictionary dictionary];
    for(User *user in friends){
        if (filter.length > 0 && [[user.name lowercaseString] rangeOfString:filter.lowercaseString].location == NSNotFound ) {
            continue;
        }
        NSString *firstLetter = [[user.name uppercaseString] substringToIndex:1];
        if([sections valueForKey:firstLetter] == nil){
            sections[firstLetter] = [NSMutableArray array];
        }
        NSMutableArray *sectionArray = sections[firstLetter];
        [sectionArray addObject:user];
    }
    
    NSArray *keys = [sections allKeys];
    sectionIndexes = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    [_table reloadData];
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sections objectForKey:[sectionIndexes objectAtIndex:section]] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, 30)];
    container.backgroundColor = [UIColor clearColor];
    UIView *coloredView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, 25)];
    coloredView.backgroundColor = COLOR_ORANGE;
    [container addSubview:coloredView];
    CustomLabel *label = [[CustomLabel alloc]initWithFrame:CGRectMake(15, 5, 50, 15)];
    label.text = [sectionIndexes objectAtIndex:section];
    label.textColor = [UIColor whiteColor];
    [container addSubview:label];
    return container;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FriendListCell defaultCellHeight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendListCell *cell = [_table dequeueReusableCellWithIdentifier:[FriendListCell identifier] forIndexPath:indexPath];
    NSMutableArray *array = [sections objectForKey:[sectionIndexes objectAtIndex:indexPath.section]];
    User *friend = [array objectAtIndex:indexPath.row];
    [cell buildFromUser:friend];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self loadFriends:searchText];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
