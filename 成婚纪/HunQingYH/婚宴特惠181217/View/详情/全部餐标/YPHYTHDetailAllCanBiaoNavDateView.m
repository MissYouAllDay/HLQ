//
//  YPHYTHDetailAllCanBiaoNavDateView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/18.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailAllCanBiaoNavDateView.h"

@implementation YPHYTHDetailAllCanBiaoNavDateView

+ (instancetype)yp_detailAllCanBiaoNavDateView{
    YPHYTHDetailAllCanBiaoNavDateView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPHYTHDetailAllCanBiaoNavDateView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 4;
    _backView.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
