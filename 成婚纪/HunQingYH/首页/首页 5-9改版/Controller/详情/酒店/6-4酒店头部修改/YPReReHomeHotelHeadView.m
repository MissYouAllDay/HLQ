//
//  YPReReHomeHotelHeadView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReReHomeHotelHeadView.h"

@implementation YPReReHomeHotelHeadView

+ (instancetype)yp_rereHomeHotelHeadView{
    YPReReHomeHotelHeadView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPReReHomeHotelHeadView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (void)setXiaofeiyouli:(UILabel *)xiaofeiyouli{
    _xiaofeiyouli = xiaofeiyouli;
    _xiaofeiyouli.layer.cornerRadius = 2;
    _xiaofeiyouli.clipsToBounds = YES;
    _xiaofeiyouli.layer.borderColor = RGB(250, 80, 120).CGColor;
    _xiaofeiyouli.layer.borderWidth = 1;
}

- (void)setHunlidanbao:(UILabel *)hunlidanbao{
    _hunlidanbao = hunlidanbao;
    _hunlidanbao.layer.cornerRadius = 2;
    _hunlidanbao.clipsToBounds = YES;
    _hunlidanbao.layer.borderColor = RGB(84, 115, 203).CGColor;
    _hunlidanbao.layer.borderWidth = 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
