//
//  YPMyWalletBalanceView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletBalanceView.h"

@implementation YPMyWalletBalanceView

+ (instancetype)yp_MyWalletBalanceView{
    
    YPMyWalletBalanceView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPMyWalletBalanceView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 10;
    _backView.layer.masksToBounds = NO;
    
    _backView.layer.shadowColor = [UIColor colorWithRed:0.99 green:0.68 blue:0.78 alpha:1.00].CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
}

- (void)setTiXianBtn:(UIButton *)tiXianBtn{
    _tiXianBtn = tiXianBtn;
    
    _tiXianBtn.layer.cornerRadius = 15;
    _tiXianBtn.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
