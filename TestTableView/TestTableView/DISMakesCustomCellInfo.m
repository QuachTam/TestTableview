//
//  DISMakesCustomCellInfo.m
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import "DISMakesCustomCellInfo.h"

@implementation DISMakesCustomCellInfo

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setDataCellWith:(NSDictionary*)dict{
    self.lblName.text = [dict objectForKey:@"1"];
    self.lblUnit.text = [dict objectForKey:@"2"];
    [self setNeedsLayout];
}

@end
