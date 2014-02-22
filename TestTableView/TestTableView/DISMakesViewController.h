//
//  DISMakesViewController.h
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenuViewController.h"

@interface DISMakesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, DropDownMenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
