//
//  YPLotteryPrizeView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPLotteryPrizeView.h"

@implementation YPLotteryPrizeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    YPLotteryPrizeView *view;
    
    if (self = [super initWithFrame:frame]) {
        
//        CGFloat x = frame.origin.x;
//        CGFloat y = frame.origin.y;
//        CGFloat w = frame.size.width;
//        CGFloat h = frame.size.height;
        
        if (!view) {
            view = [[[NSBundle mainBundle]loadNibNamed:@"YPLotteryPrizeView" owner:nil options:nil]lastObject];
        }
        
        view.frame = frame;
        
        view.iconImgV.contentMode = UIViewContentModeScaleToFill;
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        view.layer.borderWidth = 2;
        view.layer.borderColor = RGB(251, 139, 102).CGColor;
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
