//
//  YPPhotoVideoNoticeView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPhotoVideoNoticeView.h"

@implementation YPPhotoVideoNoticeView

+ (instancetype)yp_photoVideoNoticeView{
    YPPhotoVideoNoticeView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPPhotoVideoNoticeView" owner:nil options:nil]lastObject];
    }
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    return view;
}

- (void)setKnowBtn:(UIButton *)knowBtn{
    _knowBtn = knowBtn;
    
    _knowBtn.layer.cornerRadius = 5;
    _knowBtn.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
