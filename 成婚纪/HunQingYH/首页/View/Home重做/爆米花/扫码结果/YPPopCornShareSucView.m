//
//  YPPopCornShareSucView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/30.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPopCornShareSucView.h"

@implementation YPPopCornShareSucView

+ (instancetype)yp_popCornShareSucView{
    
    YPPopCornShareSucView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPPopCornShareSucView" owner:nil options:nil]lastObject];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
