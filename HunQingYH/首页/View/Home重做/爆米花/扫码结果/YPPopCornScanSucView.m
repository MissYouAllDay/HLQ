//
//  YPPopCornScanSucView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/30.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPopCornScanSucView.h"

@implementation YPPopCornScanSucView

+ (instancetype)yp_popCornScanSucView{
    
    YPPopCornScanSucView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPPopCornScanSucView" owner:nil options:nil]lastObject];
    }
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    return view;
    
}

//- (void)setIconImgV:(UIImageView *)iconImgV{
//    _iconImgV = iconImgV;
//    
//    _iconImgV.layer.cornerRadius = 75;
//    _iconImgV.clipsToBounds = YES;
//}

- (void)setGetBtn:(UIButton *)getBtn{
    _getBtn = getBtn;
    
    _getBtn.layer.cornerRadius = 5;
    _getBtn.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
