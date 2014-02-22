//
//  AlphabetTableHeaderView.h
//  dis-header-tableview
//
//  Created by Cừu Lười on 2/15/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphabetTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (void)setTitleHeader:(NSString *)text;

+ (CGFloat)headerHeight;

+ (NSString *)headerViewIdentifier;

- (void)setFillColor:(UIColor *)fillColor;

- (void)setTextColor:(UIColor *)textColor;

@end
