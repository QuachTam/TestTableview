//
//  AlphabetTableHeaderView.m
//  dis-header-tableview
//
//  Created by Cừu Lười on 2/15/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "AlphabetTableHeaderView.h"

@interface AlphabetTableHeaderView()

@property (nonatomic, weak) IBOutlet UILabel *lineLabel;
@property (nonatomic, weak) IBOutlet UIView *view;

@end

@implementation AlphabetTableHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadViewFromNib];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

- (void)loadViewFromNib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"AlphabetTableHeaderView" owner:self options:nil] objectAtIndex:0];
    self.view = view;
    self.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.view];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect textRect = self.titleLabel.frame;
    if (self.titleLabel.text.length) {
//        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
        textRect.size.width = ceilf(textSize.width) + 5.0;
    }
    self.titleLabel.frame = textRect;
    CGRect lineRect = self.lineLabel.frame;
    lineRect.size.width = CGRectGetWidth(self.view.frame) - 35.0;
    self.lineLabel.frame = lineRect;
}

- (void)setTitleHeader:(NSString *)text {
    NSString *title = @"";
    if (text && text.length) {
        title = [text uppercaseString];
    }
    [self.titleLabel setText:title];
    [self setNeedsLayout];
}

+ (CGFloat)headerHeight {
    return 30.0;
}

+ (NSString *)headerViewIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setFillColor:(UIColor *)fillColor {
    [self.titleLabel setBackgroundColor:fillColor];
    [self.lineLabel setBackgroundColor:fillColor];
}

- (void)setTextColor:(UIColor *)textColor {
    [self.titleLabel setTextColor:textColor];
}

@end
