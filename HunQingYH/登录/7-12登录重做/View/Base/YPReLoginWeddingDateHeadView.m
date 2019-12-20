//
//  YPReLoginWeddingDateHeadView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/1.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPReLoginWeddingDateHeadView.h"

@implementation YPReLoginWeddingDateHeadView

+ (instancetype)yp_ReLoginWeddingDateHeadView{
    
    YPReLoginWeddingDateHeadView *view;
    if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"YPReLoginWeddingDateHeadView" owner:nil options:nil]lastObject];
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
