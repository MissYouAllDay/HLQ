//
//  YPMeHeaderView.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMeHeaderView.h"

@implementation YPMeHeaderView

+ (instancetype)headerView{
    YPMeHeaderView *header = [[[NSBundle mainBundle]loadNibNamed:@"YPMeHeaderView" owner:nil options:nil]lastObject];
    header.backgroundColor = NavBarColor;
    return header;
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 2;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = WhiteColor.CGColor;
    _iconImgV.layer.borderWidth = 2;
}

- (void)setProfessionLabel:(UILabel *)professionLabel{
    _professionLabel = professionLabel;
    
    _professionLabel.layer.cornerRadius = 2;
    _professionLabel.clipsToBounds = YES;
}

@end
