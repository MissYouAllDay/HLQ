//
//  YPUnPassCheckView.m
//  hunqing
//
//  Created by Else丶 on 2018/3/19.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import "YPUnPassCheckView.h"

@implementation YPUnPassCheckView

+ (instancetype)yp_unPassCheckView{
    
    YPUnPassCheckView *view;
    
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPUnPassCheckView" owner:nil options:nil] lastObject];
    }
    view.layer.cornerRadius = 3;
    view.clipsToBounds = YES;
    view.line2.enabled = NO;
    return view;
}

- (void)setSureBtn:(UIButton *)sureBtn{
    _sureBtn = sureBtn;
    
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
