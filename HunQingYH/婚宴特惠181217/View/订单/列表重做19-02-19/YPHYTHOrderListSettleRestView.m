//
//  YPHYTHOrderListSettleRestView.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/19.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderListSettleRestView.h"
#import "UIImage+YPGradientImage.h"

@implementation YPHYTHOrderListSettleRestView

+ (instancetype)yp_orderListSettleRestView{
    YPHYTHOrderListSettleRestView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPHYTHOrderListSettleRestView" owner:nil options:nil]lastObject];
    }
    view.layer.cornerRadius = 12;
    view.clipsToBounds = YES;
    return view;
}

- (void)setCancleBtn:(UIButton *)cancleBtn{
    _cancleBtn = cancleBtn;
    _cancleBtn.layer.cornerRadius = 20;
    _cancleBtn.clipsToBounds = YES;
    _cancleBtn.layer.borderColor = RGBS(221).CGColor;
    _cancleBtn.layer.borderWidth = 1;
}

- (void)setSureBtn:(UIButton *)sureBtn{
    _sureBtn = sureBtn;
    _sureBtn.layer.cornerRadius = 20;
    _sureBtn.clipsToBounds = YES;
    [_sureBtn setBackgroundImage:[UIImage gradientImageWithBounds:_sureBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:[UIImage gradientImageWithBounds:_sureBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
