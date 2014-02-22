//
//  TitleControl.m
//  Customer
//
//  Created by Cừu Lười on 1/9/14.
//  Copyright (c) 2014 El Nino. All rights reserved.
//

#import "TitleControl.h"

@interface TitleControl()

@property (nonatomic, weak) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation TitleControl

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
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"TitleControl" owner:self options:nil] objectAtIndex:0];
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    self.titleLabel.accessibilityIdentifier = @"account-balance-title-label";
}

- (CGFloat)getCurrentBoundWidth {
    UIScreen *screen = [UIScreen mainScreen];
    if (![self inLandscapeMode]) {
        return screen.bounds.size.width;
    } else {
        return screen.bounds.size.height;
    }
}

- (BOOL)inLandscapeMode {
    UIInterfaceOrientation orientation = [[self class] currentOrientation];
    return UIDeviceOrientationIsLandscape(orientation);
}

+(UIInterfaceOrientation)currentOrientation {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIDevice currentDevice] orientation];
    if (orientation == 0 || (!UIDeviceOrientationIsValidInterfaceOrientation(orientation))) {
        orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    orientation = [UIApplication sharedApplication].statusBarOrientation;
    return orientation;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat magin = 5.0;
    CGRect titleRect = CGRectZero;
    if (_titleLabel.text && _titleLabel.text.length) {
        CGSize tmp = [_titleLabel.text sizeWithFont:_titleLabel.font];
        titleRect.size = tmp;
        titleRect.size.width = [self getCurrentBoundWidth] - 80;
        titleRect.origin.x = CGRectGetWidth(self.view.bounds) / 2 - titleRect.size.width / 2;
        titleRect.origin.y = magin;
    }
    _titleLabel.frame = titleRect;
    
    CGRect subRect = CGRectOffset(titleRect, 0, titleRect.size.height - magin);
    if (_subTitleLabel.text && _subTitleLabel.text.length) {
        CGSize tmp = [_subTitleLabel.text sizeWithFont:_subTitleLabel.font];
        subRect.size = tmp;
        subRect.origin.x = CGRectGetWidth(self.view.bounds) / 2 - tmp.width / 2;
    }
    _subTitleLabel.frame = subRect;
    
    CGRect iconRect = CGRectOffset(subRect, subRect.size.width + 2 * magin, 0);
    iconRect.size = _iconImageView.image.size;
    iconRect.origin.y = CGRectGetMidY(subRect) - _iconImageView.image.size.height / 2;
    _iconImageView.frame = iconRect;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < CGRectGetMaxY(self.frame)) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
}

- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
    [self layoutSubviews];
}

- (void)setSubTitle:(NSString *)subTitle {
    [_subTitleLabel setText:subTitle];
    [self layoutSubviews];
}
@end
