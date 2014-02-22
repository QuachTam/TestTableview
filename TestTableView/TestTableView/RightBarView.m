//
//  RightBarView.m
//  dis-header-tableview
//
//  Created by Cừu Lười on 2/15/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "RightBarView.h"
#define MAGIN 10.0

@implementation RightBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)setRightViews:(NSArray *)rightViews {
    for (UIView *view in _rightViews) {
        [view removeFromSuperview];
    }
    _rightViews = rightViews;
    for (UIView *view in _rightViews) {
        [self addSubview:view];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect startRect = CGRectMake(CGRectGetWidth(self.bounds), 0, 0, 0);
    for (UIView *view in _rightViews) {
        startRect.origin.x = startRect.origin.x - view.frame.size.width;
        startRect.size.width = view.frame.size.width;
        startRect.origin.y = CGRectGetMidY(self.bounds) - view.frame.size.height / 2;
        startRect.size.height = view.frame.size.height;
        view.frame = startRect;
        startRect.origin.x = startRect.origin.x - MAGIN;
    }
}

@end
