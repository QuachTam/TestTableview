//
//  DISMakesViewController.m
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import "DISMakesViewController.h"
#import "DISMakesCustomCellInfo.h"
#import "AlphabetTableHeaderView.h"
#import "DISModelsViewController.h"
#import "TitleControl.h"
#import "DropDownMenuEntity.h"
#import "DropDownMenuModel.h"
#import "DropDownMenuViewController.h"

static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";

@interface DISMakesViewController ()
@property (copy, nonatomic) NSMutableDictionary *arrayName;
@property (copy, nonatomic) NSArray *arrayKeys;
@property (nonatomic, retain) NSMutableArray *filteredNames;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, retain) TitleControl *control;
@property (nonatomic, retain) DropDownMenuViewController *drop;
@property (nonatomic, retain) DropDownMenuModel *menuModel;
@end

@implementation DISMakesViewController

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
    
//    UITableView *tableView = (id)[self.view viewWithTag:1];
//    [tableView registerNib:[UINib nibWithNibName:@"DISMakesCustomCellInfo" bundle:nil] forCellReuseIdentifier:SectionsTableIdentifier];
//    
    [self.tableView registerClass:[AlphabetTableHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([AlphabetTableHeaderView class])];
//
//    self.filteredNames = [NSMutableArray array];
//    UISearchBar *searchBar = [[UISearchBar alloc]
//                              initWithFrame:CGRectMake(0, 0, 320, 44)];
//    self.tableView.tableHeaderView = searchBar;
//    self.searchController = [[UISearchDisplayController alloc]
//                        initWithSearchBar:searchBar
//                        contentsController:self];
//    self.searchController.delegate = self;
//    self.searchController.searchResultsDataSource = self;
    
    self.arrayName = [[NSMutableDictionary alloc] init];
    self.arrayKeys = [[NSArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames"
                                                     ofType:@"plist"];
    self.arrayName = [NSDictionary dictionaryWithContentsOfFile:path];
    self.arrayKeys = [[self.arrayName allKeys] sortedArrayUsingSelector:
                 @selector(compare:)];
    NSLog(@"xxx: %@", self.arrayName);
    [self setRightButtonItem];
    [self initControlNavication];
    [self initModelMenuDropDown];
}

- (void)initControlNavication{
    _control = [[TitleControl alloc] initWithFrame:CGRectZero];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:17.0];
    NSString *title = [NSString stringWithFormat:@"All Makes"];
    CGSize tmp = [title sizeWithFont:boldFont];
    _control.frame = CGRectMake(0, 0, tmp.width, 44.0);
    [_control setTitle:title];
    [_control addTarget:self action:@selector(titleTouch:) forControlEvents:UIControlEventTouchUpInside];
    [_control addTarget:self action:@selector(titleTouchOut:) forControlEvents:UIControlEventTouchUpOutside];
    _control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.navigationItem.titleView = _control;
}

- (void)titleTouch:(id)sender{
    [self actionButtonCenter];
}

- (void)titleTouchOut:(id)sender{
    
}

- (void)setRightButtonItem{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    rightButton.tag = 0;
    [rightButton setImage:[UIImage imageNamed:@"bt_more_action.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(actionButtonRight1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UIButton *pdfButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 31)];
    pdfButton.tag = 1;
    [pdfButton setImage:[UIImage imageNamed:@"bt_pdf.png"] forState:UIControlStateNormal];
    [pdfButton addTarget:self action:@selector(actionButtonRight2) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *pdfButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pdfButton];
    
    self.navigationItem.rightBarButtonItems = @[barRightButtonItem, pdfButtonItem];
}

#pragma mark -
#pragma mark Search Display Delegate Methods
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"DISMakesCustomCellInfo" bundle:nil] forCellReuseIdentifier:SectionsTableIdentifier];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.filteredNames removeAllObjects];
    if (searchString.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *namedict, NSDictionary *b)
         {
             NSString *name = [namedict objectForKey:@"1"];
             NSRange range = [name rangeOfString:searchString
                                         options:NSCaseInsensitiveSearch];
             return range.location != NSNotFound;
         }];
        for (NSString *key in self.arrayKeys) {
            NSArray *matches = [self.arrayName[key]
                                filteredArrayUsingPredicate:predicate];
            [self.filteredNames addObjectsFromArray:matches];
        } }
    [[self tableView] reloadData];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (tableView.tag==1) {
        return [self.arrayKeys count];
//    }else{
//        return 1;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (tableView.tag==1) {
        NSString *key = self.arrayKeys[section];
        NSArray *nameSection = self.arrayName[key];
        return [nameSection count];
//    }else{
//        return [self.filteredNames count];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 50;
    }
    return [AlphabetTableHeaderView headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (tableView.tag==1) {
        AlphabetTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[AlphabetTableHeaderView headerViewIdentifier]];
        NSString *title = [self.arrayKeys objectAtIndex:section];
        [view setTitleHeader:title];
        [view setTextColor:[UIColor whiteColor]];
        UIColor *blueColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:254/255.0 alpha:1.0];
        [view setFillColor:blueColor];
    
        [self setBackGroundView:view];
        return view;
//    }else{
//        return nil;
//    }
}

- (void)setBackGroundView:(AlphabetTableHeaderView*)superView{
    UIView *bgView = [[UIView alloc] initWithFrame:superView.contentView.bounds];
    [superView setBackgroundView:bgView];
    UIImageView *img = [[UIImageView alloc] initWithFrame:bgView.bounds];
    [img setImage:[UIImage imageNamed:@"bg_screen.png"]];
    img.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [bgView addSubview:img];
    superView.backgroundView = bgView;
}


- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.arrayKeys;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusableCellIdentifier = @"DISMakesCustomCellInfo";
    DISMakesCustomCellInfo *cell = [self.tableView dequeueReusableCellWithIdentifier:reusableCellIdentifier];
    if (!cell) {
        [[self tableView] registerNib:[UINib nibWithNibName:@"DISMakesCustomCellInfo" bundle:nil] forCellReuseIdentifier:reusableCellIdentifier];
        cell = [self.tableView dequeueReusableCellWithIdentifier:reusableCellIdentifier];
    }
//    if (tableView.tag==1) {
        NSString *key = self.arrayKeys[indexPath.section];
        NSArray *nameSection = self.arrayName[key];
        [cell setDataCellWith:[nameSection objectAtIndex:indexPath.row]];

//    }else{
//        [cell setDataCellWith:[self.filteredNames objectAtIndex:indexPath.row]];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DISModelsViewController *modelsVC = [[DISModelsViewController alloc] initWithNibName:@"DISModelsViewController" bundle:nil];
    NSString *key = self.arrayKeys[indexPath.section];
    NSArray *nameSection = self.arrayName[key];
    modelsVC.nameModels = [[nameSection objectAtIndex:indexPath.row] objectForKey:@"1"];
    [self.navigationController pushViewController:modelsVC animated:YES];
}



#pragma Start DropDown menu

- (void)initModelMenuDropDown{
    NSArray *arrayLableLeft = @[@"menu 1", @"menu 2", @"menu 3", @"menu 4", @"menu 5", @"menu 6", @"menu 7", @"menu 8", @"menu 9"];
    NSArray *arrayLableRight = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    self.menuModel = [[DropDownMenuModel alloc] init];
    
    DropDownMenuEntity *dropEntity = [[DropDownMenuEntity alloc] init];
    dropEntity.arrayItemsLeft = [NSMutableArray arrayWithArray:arrayLableLeft];
    dropEntity.arrayItemsRight = [NSMutableArray arrayWithArray:arrayLableRight];
    dropEntity.type = @"0";
    dropEntity.isCenter = YES;
    [self.menuModel.arrayMenu addObject:dropEntity];
    
    NSArray *arrayLableLeft1 = @[@"menu 1", @"menu 2", @"menu 3"];
    DropDownMenuEntity *dropEntity1 = [[DropDownMenuEntity alloc] init];
    dropEntity1.arrayItemsLeft = [NSMutableArray arrayWithArray:arrayLableLeft1];
    dropEntity1.type = @"1";
    [self.menuModel.arrayMenu addObject:dropEntity1];
}

- (void)dropDownMenu:(DropDownMenuEntity*)menuEntity{
    if (!self.drop) {
        self.drop = [[DropDownMenuViewController alloc] initWithNibName:@"DropDownMenuViewController" bundle:nil];
        self.drop.superView = self;
        self.drop.delegate = self;
        self.drop.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:self.drop.view];
    }
    [self.drop.view bringSubviewToFront:self.view];
    [self.drop setValue:menuEntity];
}

- (void)didSelectOpen:(DropDownMenuEntity*)menuEntity{
    [self resetStatusMenu:menuEntity];
}
- (void)didSelectClose:(DropDownMenuEntity*)menuEntity{
    [self resetStatusMenu:menuEntity];
}

- (void)resetStatusMenu:(DropDownMenuEntity*)menuEntity{
    NSMutableArray *array = self.menuModel.arrayMenu;
    for (DropDownMenuEntity *entity in array) {
        if ([entity.type isEqualToString:menuEntity.type]) {
            entity.isOpen = menuEntity.isOpen;
        }else{
            entity.isOpen = NO;
        }
    }
}

- (void)actionButtonCenter{
    DropDownMenuEntity *menuEntity = [self.menuModel.arrayMenu objectAtIndex:0];
    [self dropDownMenu:menuEntity];
}

- (void)actionButtonRight1{
    DropDownMenuEntity *menuEntity = [self.menuModel.arrayMenu objectAtIndex:1];
    [self dropDownMenu:menuEntity];
}

- (void)actionButtonRight2{
    DropDownMenuEntity *menuEntity = [self.menuModel.arrayMenu objectAtIndex:1];
    [self dropDownMenu:menuEntity];
}

- (void)didSelectIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"indexPath: %@", indexPath);
}

#pragma End DropDown menu



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
