//
//  zzz.m
//  TestTableView
//
//  Created by Quach Ngoc Tam on 2/21/14.
//  Copyright (c) 2014 QsoftVietNam. All rights reserved.
//

#import "zzz.h"

@implementation zzz

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setTitleHeader:(NSString *)text{
    [super setTitleHeader:text];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 30, 40)];
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    UILabel *lalbeName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-20, 30)];
    //    lalbeName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    lalbeName.text = stringName;
    [subView setBackgroundColor:[UIColor redColor]];
    //    [subView addSubview:lalbeName];
}
//
//- (UIView*)viewNameHeader:(NSString*)stringName{
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-30, 40)];
//    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    //    UILabel *lalbeName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-20, 30)];
//    //    lalbeName.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    //    lalbeName.text = stringName;
//    [subView setBackgroundColor:[UIColor redColor]];
//    //    [subView addSubview:lalbeName];
//    //
//    //    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, lalbeName.frame.size.height, self.view.frame.size.width, 10)];
//    //    [img setImage:[UIImage imageNamed:@"bg_basic_info_shadow.png"]];
//    //    img.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    //    [subView addSubview:img];
//    
//    return subView;
//}
@end
