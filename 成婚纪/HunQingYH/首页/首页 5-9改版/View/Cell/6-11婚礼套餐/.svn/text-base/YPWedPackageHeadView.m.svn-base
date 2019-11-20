//
//  YPWedPackageHeadView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPackageHeadView.h"

@implementation YPWedPackageHeadView

+ (instancetype)yp_wedPackageHeadView{
    YPWedPackageHeadView *view;
    if (!view) {
        view = [[[NSBundle mainBundle] loadNibNamed:@"YPWedPackageHeadView" owner:nil options:nil] lastObject];
    }
    return view;
}

- (void)setCountBtn:(UIButton *)countBtn{
    _countBtn = countBtn;
    _countBtn.enabled = NO;
    _countBtn.layer.cornerRadius = 3;
    _countBtn.clipsToBounds = YES;
    [_countBtn setBackgroundColor:RGBA(0, 0, 0, 0.16)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
