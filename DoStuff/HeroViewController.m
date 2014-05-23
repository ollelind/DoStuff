//
//  HeroViewController.m
//  DoStuff
//
//  Created by Olle Lind on 02/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "HeroViewController.h"
#import "HeroCell.h"
#import "DataFactory.h"
#import "ActivityDAO.h"
#import "Activity.h"
#import "HeroHeaderView.h"
#import "NSDate-Utilities.h"
#import "Helper.h"
#import "ActivityCategoryDAO.h"

@interface HeroViewController (){
}

@end

@implementation HeroViewController

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
    
    [self.navigationItem setTitle:@"Do Stuff?"];
    
    

    // Do any additional setup after loading the view from its nib.
    self.table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.table.separatorColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.showsVerticalScrollIndicator = NO;
    [self.table registerNib:[HeroCell nib] forCellReuseIdentifier:[HeroCell identifier]];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = COLOR_BACKGROUND_GREY;
    [self.view addSubview:self.table];
    
}

-(void)loadActivities{
    self.sections = [NSMutableDictionary dictionary];
    self.sectionIndexes = [NSMutableArray array];
    ActivityDAO *dao = [ActivityDAO buildDAO];
    NSArray *array = [dao listEntitiesSortedByAttribute:@"date"];
    [self insertActivities:array];
    [self.table reloadData];
}

-(void)insertActivities:(NSArray *)activities{
    if(!self.sections || !self.sectionIndexes){
        self.sections = [NSMutableDictionary dictionary];
        self.sectionIndexes = [NSMutableArray array];
    }
    for(Activity *activity in activities){
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:activity.date];
        NSString *dateString = [[Helper shared] getStringFromDate:date];
        
        if(![self.sections objectForKey:dateString]){
            // The date hasn't been added to the sections yet, add it
            [self.sections setObject:[NSMutableArray arrayWithObject:activity] forKey:dateString];
            [self.sectionIndexes addObject:dateString];
        }else{
            // The date is already in sections, add it to the section
            NSMutableArray *sectionArray = [self.sections objectForKey:dateString];
            [sectionArray addObject:activity];
        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    if([[ActivityCategoryDAO buildDAO] countEntities] == 0){
        DataFactory *factory = [[DataFactory alloc]init];
        [factory populateCategories];
        [factory populateActivities];
    }
    [self loadActivities];
}

#pragma mark - Table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionIndexes.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.sections objectForKey:[self.sectionIndexes objectAtIndex:section]] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeroHeaderViewHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *temp = [[NSBundle mainBundle] loadNibNamed:@"HeroHeaderView" owner:self options:nil];
    HeroHeaderView *headerView = [temp objectAtIndex:0];
    NSString *dateString = [self.sectionIndexes objectAtIndex:section];
    [headerView.dateLabel setText:dateString];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HeroCell defaultCellHeight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeroCell *cell = [self.table dequeueReusableCellWithIdentifier:[HeroCell identifier]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSMutableArray *array = [self.sections objectForKey:[self.sectionIndexes objectAtIndex:indexPath.section]];
    Activity *activity = [array objectAtIndex:indexPath.row];
    [cell setActivity:activity];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
