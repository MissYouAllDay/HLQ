//
//  YPFirstBtnView.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPFirstBtnView.h"

@implementation YPFirstBtnView

+ (instancetype)firstView{
    YPFirstBtnView *first = [[[NSBundle mainBundle]loadNibNamed:@"YPFirstBtnView" owner:nil options:nil]lastObject];
    return first;
}

- (void)setLoversBtn:(UIButton *)loversBtn{
    _loversBtn = loversBtn;
    _loversBtn.layer.borderWidth = 2;
    _loversBtn.layer.borderColor = WhiteColor.CGColor;
}

- (void)setServiceBtn:(UIButton *)serviceBtn{
    _serviceBtn = serviceBtn;
    _serviceBtn.layer.borderWidth = 2;
    _serviceBtn.layer.borderColor = WhiteColor.CGColor;
}

- (void)setCompanybtn:(UIButton *)companybtn{
    _companybtn = companybtn;
    _companybtn.layer.borderWidth = 2;
    _companybtn.layer.borderColor = WhiteColor.CGColor;
}

@end
