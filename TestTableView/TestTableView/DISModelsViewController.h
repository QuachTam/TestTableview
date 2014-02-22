//
//  DISModelsViewController.h
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DISModelsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSString *nameModels;

@end
