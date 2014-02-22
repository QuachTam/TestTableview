//
//  DISMakesCustomCellInfo.h
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DISMakesCustomCellInfo : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit;

- (void)setDataCellWith:(NSDictionary*)dict;
@end
