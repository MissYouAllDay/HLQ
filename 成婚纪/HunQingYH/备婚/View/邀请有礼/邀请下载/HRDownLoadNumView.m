//
//  HRDownLoadNumView.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRDownLoadNumView.h"

@implementation HRDownLoadNumView
+ (instancetype)inviteView{
    
    HRDownLoadNumView *view = [[[NSBundle mainBundle]loadNibNamed:@"HRDownLoadNumView" owner:nil options:nil]lastObject];
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
