//
//  ExpandableTableHeaderView.h
//  dis-header-tableview
//
//  Created by Cừu Lười on 2/15/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightBarView.h"

@interface TextControl : UIControl

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) NSString *text;

@end

@interface ExpandableTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) TextControl *textControl;

@property (nonatomic, strong) NSString *headerTitle;

+ (CGFloat)headerHeight;

+ (NSString *)headerViewIdentifier;

@property (nonatomic) BOOL isExpanding;

@property (nonatomic) BOOL showExpandingIconEnable;

@property (nonatomic) RightBarView *rightBarView;

@property (nonatomic, copy, readwrite) void(^headerViewDidExpand)(ExpandableTableHeaderView *sender);

@end
