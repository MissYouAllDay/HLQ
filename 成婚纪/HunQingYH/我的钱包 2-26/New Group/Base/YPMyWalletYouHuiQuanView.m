//
//  YPMyWalletYouHuiQuanView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletYouHuiQuanView.h"

@implementation YPMyWalletYouHuiQuanView

+ (instancetype)yp_MyWalletYouHuiQuanView{
    YPMyWalletYouHuiQuanView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPMyWalletYouHuiQuanView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 10;
    _backView.layer.masksToBounds = NO;
    _backView.layer.borderColor = RGB(253, 173, 199).CGColor;
    _backView.layer.borderWidth = 1;
    
    _backView.layer.shadowColor = [UIColor colorWithRed:0.99 green:0.68 blue:0.78 alpha:1.00].CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
