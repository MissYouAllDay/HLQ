//
//  YPReMeHeaderView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeHeaderView.h"

@implementation YPReMeHeaderView

+ (instancetype)yp_ReMeHeaderView{
    
    YPReMeHeaderView *header;
    if (!header) {
        header = [[[NSBundle mainBundle]loadNibNamed:@"YPReMeHeaderView" owner:nil options:nil] lastObject];
    }
    return header;
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 40;
    _iconImgV.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
