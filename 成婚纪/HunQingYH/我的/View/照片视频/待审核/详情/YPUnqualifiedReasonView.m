//
//  YPUnqualifiedReasonView.m
//  hunqing
//
//  Created by Else丶 on 2018/3/19.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import "YPUnqualifiedReasonView.h"
#import "UITextView+WZB.h"

@implementation YPUnqualifiedReasonView

+ (instancetype)yp_unqualifiedReasonView{
    YPUnqualifiedReasonView *view;
    
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPUnqualifiedReasonView" owner:nil options:nil] lastObject];
    }
    view.layer.cornerRadius = 3;
    view.clipsToBounds = YES;
    return view;
}

- (void)setTextView:(UITextView *)textView{
    _textView = textView;
    
    _textView.layer.borderColor = LightGrayColor.CGColor;
    _textView.layer.borderWidth = 1;
    
    // 设置文本框占位文字
    _textView.wzb_placeholder = @"请写明不合格的原因(非必填)...";
    _textView.wzb_placeholderColor = LightGrayColor;
    _textView.font = kNormalFont;
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
