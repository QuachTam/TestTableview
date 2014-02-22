//
//  ExpandableTableHeaderView.m
//  dis-header-tableview
//
//  Created by Cừu Lười on 2/15/14.
//  Copyright (c) 2014 Cừu Lười. All rights reserved.
//

#import "ExpandableTableHeaderView.h"

#define LEFT_MAGIN 5.0

@interface TextControl()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic) CGAffineTransform originTransform;
@property (nonatomic) CGAffineTransform rotationTransfom;

- (void)controlDidTouch:(id)sender;

@property (nonatomic) CGFloat textWidth;
@property (nonatomic) CGFloat textControlWidth;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic) BOOL isShowingIcon;

@end

@implementation TextControl

@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self addSubview:_textLabel];
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconImageView];
        _originTransform = _iconImageView.transform;
        CGAffineTransform rotationTransform = CGAffineTransformRotate(_originTransform, M_PI_2);
        _rotationTransfom = CGAffineTransformConcat(_originTransform, rotationTransform);
        UIImage *image = [UIImage imageNamed:@"icon_arrow_right_block"];
        _iconImage = image;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect iconRect = CGRectZero;
    CGFloat leftMagin = LEFT_MAGIN;
    if (_iconImageView.image) {
        CGFloat maxDimension = (_iconImageView.image.size.width > _iconImageView.image.size.height) ? _iconImageView.image.size.width:_iconImageView.image.size.height;
        iconRect.size.width = iconRect.size.height = maxDimension;
        iconRect.origin.x = CGRectGetWidth(self.bounds) - maxDimension - LEFT_MAGIN / 4;
        iconRect.origin.y = CGRectGetMidY(self.bounds) - maxDimension / 2;
    }
    _iconImageView.frame = iconRect;
    CGRect textRect = CGRectZero;
    if (_textLabel.text && _textLabel.text.length) {
        textRect.size.width = _textWidth;
        textRect.size.height = CGRectGetHeight(self.bounds);
        textRect.origin.x = leftMagin;
        textRect.origin.y = 0;
    }
    _textLabel.frame = textRect;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self controlDidTouch:Nil];
}

- (void)controlDidTouch:(id)sender {
    [UIView animateWithDuration:0.1 animations:^{
        if (_selected) {
            _iconImageView.transform = _originTransform;
        } else {
            _iconImageView.transform = _rotationTransfom;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            _selected = !_selected;
            [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        _iconImageView.transform = _rotationTransfom;
    } else {
        _iconImageView.transform = _originTransform;
    }
}

- (void)calculateWidth {
    _textWidth = [_text sizeWithAttributes:@{NSFontAttributeName:_textLabel.font}].width;
    _textControlWidth = LEFT_MAGIN + _textWidth + LEFT_MAGIN + _iconImageView.image.size.width;
}

- (void)setText:(NSString *)text {
    _text = [text uppercaseString];
    _textLabel.text = _text;
    [self calculateWidth];
}

- (void)setIsShowingIcon:(BOOL)isShowingIcon {
    _isShowingIcon = isShowingIcon;
    if (_isShowingIcon) {
        _iconImageView.image = _iconImage;
    } else {
        _iconImageView.image = nil;
    }
    [self calculateWidth];
}

@end

@interface ExpandableTableHeaderView()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ExpandableTableHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _textControl = [[TextControl alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_textControl];
        [_textControl addTarget:self action:@selector(textControlDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        _lineView = [[UIView alloc] init];
        [self.contentView addSubview:_lineView];
        UIColor *blueColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:254/255.0 alpha:1.0];
        _textControl.backgroundColor = blueColor;
        _lineView.backgroundColor = blueColor;
        
        _rightBarView = [[RightBarView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_rightBarView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect textRect = CGRectMake(LEFT_MAGIN, 1.5 * LEFT_MAGIN, 0, 3.5*LEFT_MAGIN);
    textRect.size.width = _textControl.textControlWidth;
    _textControl.frame = textRect;
    CGRect lineRect = CGRectOffset(textRect, 0, textRect.size.height);
    lineRect.size.height = 1.0;
    lineRect.size.width = CGRectGetWidth(self.contentView.bounds) - 3 * LEFT_MAGIN;
    _lineView.frame = lineRect;
    
    CGRect righBarRect = CGRectOffset(textRect, textRect.size.width, 0);
    righBarRect.size.width = CGRectGetWidth(self.contentView.bounds) - CGRectGetMaxX(textRect) - 2 * LEFT_MAGIN;
    righBarRect.origin.y = LEFT_MAGIN;
    _rightBarView.frame = righBarRect;
}

+ (CGFloat)headerHeight {
    return 30.0;
}

+ (NSString *)headerViewIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    [_textControl setText:headerTitle];
    [self setNeedsDisplay];
}

- (void)setIsExpanding:(BOOL)isExpanding {
    _isExpanding = isExpanding;
    _textControl.selected = isExpanding;
}

- (void)setShowExpandingIconEnable:(BOOL)showExpandingIconEnable {
    _showExpandingIconEnable = showExpandingIconEnable;
    _textControl.isShowingIcon = _showExpandingIconEnable;
}

- (void)prepareForReuse {
    [_rightBarView setRightViews:Nil];
}

- (void)textControlDidSelected:(TextControl *)sender {
    _isExpanding = sender.selected;
    if (_headerViewDidExpand && _showExpandingIconEnable) {
        _headerViewDidExpand(self);
    }
}

@end
