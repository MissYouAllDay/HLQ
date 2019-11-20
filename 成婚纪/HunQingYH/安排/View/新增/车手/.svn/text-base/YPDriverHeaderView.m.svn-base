//
//  YPDriverHeaderView.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDriverHeaderView.h"

@implementation YPDriverHeaderView

+ (instancetype)driverHeaderView{
    YPDriverHeaderView *header = [[[NSBundle mainBundle]loadNibNamed:@"YPDriverHeaderView" owner:nil options:nil]lastObject];
    return header;
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 3;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderWidth = 1;
    _iconImgV.layer.borderColor = CHJ_bgColor.CGColor;
}

@end
