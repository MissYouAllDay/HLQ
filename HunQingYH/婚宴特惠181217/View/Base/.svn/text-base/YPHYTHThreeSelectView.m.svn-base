//
//  YPHYTHThreeSelectView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHThreeSelectView.h"

@implementation YPHYTHThreeSelectView

+ (instancetype)yp_threeSelectView{
    YPHYTHThreeSelectView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPHYTHThreeSelectView" owner:nil options:nil]lastObject];
    }
    return view;
}

- (void)setAreaBtn:(FSCustomButton *)areaBtn{
    _areaBtn = areaBtn;
    _areaBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
}

- (void)setXiaoliangBtn:(FSCustomButton *)xiaoliangBtn{
    _xiaoliangBtn = xiaoliangBtn;
    _xiaoliangBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
}

- (void)setPriceBtn:(FSCustomButton *)priceBtn{
    _priceBtn = priceBtn;
    _priceBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
