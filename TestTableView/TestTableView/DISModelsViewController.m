//
//  DISModelsViewController.m
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import "DISModelsViewController.h"
#import "AlphabetTableHeaderView.h"
#import "DISMakesCustomCellInfo.h"

@interface DISModelsViewController ()
@property (copy, nonatomic) NSMutableDictionary *arrayName;
@property (copy, nonatomic) NSArray *arrayKeys;

@end

@implementation DISModelsViewController

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
       [self.tableView registerClass:[AlphabetTableHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([AlphabetTableHeaderView class])];
    
    self.arrayName = [[NSMutableDictionary alloc] init];
    self.arrayKeys = [[NSArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames"
                                                     ofType:@"plist"];
    self.arrayName = [NSDictionary dictionaryWithContentsOfFile:path];
    self.arrayKeys = [[self.arrayName allKeys] sortedArrayUsingSelector:
                      @selector(compare:)];
    [self setRightButtonItem];
}


- (void)setRightButtonItem{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    rightButton.tag = 0;
    [rightButton setImage:[UIImage imageNamed:@"bt_more_action.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(actionDrop:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UIButton *pdfButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 31)];
    pdfButton.tag = 1;
    [pdfButton setImage:[UIImage imageNamed:@"bt_pdf.png"] forState:UIControlStateNormal];
    [pdfButton addTarget:self action:@selector(actionDrop:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *pdfButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pdfButton];
    
    self.navigationItem.rightBarButtonItems = @[barRightButtonItem, pdfButtonItem];
}

- (void)actionDrop:(id)sender{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.arrayKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = self.arrayKeys[section];
    NSArray *nameSection = self.arrayName[key];
    return [nameSection count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 75;
    }
    return [AlphabetTableHeaderView headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AlphabetTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[AlphabetTableHeaderView headerViewIdentifier]];
    NSString *title = [self.arrayKeys objectAtIndex:section];
    [view setTitleHeader:title];
    [view setTextColor:[UIColor whiteColor]];
    UIColor *blueColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:254/255.0 alpha:1.0];
    [view setFillColor:blueColor];
    if (section==0) {
        [view addSubview:[self viewNameHeader:self.nameModels]];
    }
    [self setBackGroundView:view];
    return view;
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

- (UIView*)viewNameHeader:(NSString*)stringName{
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 0, 40)];
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [subView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *lalbeName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 0, 30)];
    lalbeName.text = stringName;
    lalbeName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [lalbeName setBackgroundColor:[UIColor clearColor]];
    [subView addSubview:lalbeName];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, lalbeName.frame.size.height, 0, 10)];
    [img setImage:[UIImage imageNamed:@"bg_basic_info_shadow.png"]];
    img.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [subView addSubview:img];
    return subView;
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
    NSString *key = self.arrayKeys[indexPath.section];
    NSArray *nameSection = self.arrayName[key];
    [cell setDataCellWith:[nameSection objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DISModelsViewController *modelsVC = [[DISModelsViewController alloc] initWithNibName:@"DISModelsViewController" bundle:nil];
    [self.navigationController pushViewController:modelsVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
