//
//  YPReceivePopCornView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReceivePopCornView.h"

@implementation YPReceivePopCornView

+ (instancetype)yp_receivePopCornView{
    
    YPReceivePopCornView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPReceivePopCornView" owner:nil options:nil]lastObject];
    }
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
    return view;
}

- (void)setNoBtn:(UIButton *)noBtn{
    _noBtn = noBtn;
    
    _noBtn.layer.cornerRadius = 5;
    _noBtn.clipsToBounds = YES;
    _noBtn.layer.borderColor = LightGrayColor.CGColor;
    _noBtn.layer.borderWidth = 1;
}

- (void)setGetBtn:(UIButton *)getBtn{
    _getBtn = getBtn;
    
    _getBtn.layer.cornerRadius = 5;
    _getBtn.clipsToBounds = YES;
    _getBtn.layer.borderColor = LightGrayColor.CGColor;
    _getBtn.layer.borderWidth = 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
