//
//  YPReLoginOtherWayView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginOtherWayView.h"

@implementation YPReLoginOtherWayView

+ (instancetype)yp_reLoginOtherWayView{
    YPReLoginOtherWayView *view;
    
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPReLoginOtherWayView" owner:nil options:nil]lastObject];
    }
    return view;
    
}

- (IBAction)qqBtnClick:(UIButton *)sender {
    self.btnClickBlock(@"qq");
}

- (IBAction)wechatBtnClick:(UIButton *)sender {
    self.btnClickBlock(@"wechat");
}

- (IBAction)protocolBtnClick:(UIButton *)sender {
    self.btnClickBlock(@"protocol");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
