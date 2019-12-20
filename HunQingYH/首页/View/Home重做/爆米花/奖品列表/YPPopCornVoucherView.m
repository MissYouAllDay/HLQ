//
//  YPPopCornVoucherView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPopCornVoucherView.h"

@implementation YPPopCornVoucherView

+ (instancetype)yp_popCornVoucherView{
    YPPopCornVoucherView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPPopCornVoucherView" owner:nil options:nil]lastObject];
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
