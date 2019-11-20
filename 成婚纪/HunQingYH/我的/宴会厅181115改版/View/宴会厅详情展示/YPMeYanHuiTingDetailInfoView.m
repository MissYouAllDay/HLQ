//
//  YPMeYanHuiTingDetailInfoView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeYanHuiTingDetailInfoView.h"

@implementation YPMeYanHuiTingDetailInfoView

+ (instancetype)yp_MeYanHuiTingDetailInfoView{
    YPMeYanHuiTingDetailInfoView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPMeYanHuiTingDetailInfoView" owner:nil options:nil]lastObject];
    }
    view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    return view;
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 18;
    _iconImgV.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
