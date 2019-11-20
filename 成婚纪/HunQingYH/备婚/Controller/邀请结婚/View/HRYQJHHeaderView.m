//
//  HRYQJHHeaderView.m
//  HunQingYH
//
//  Created by Hiro on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJHHeaderView.h"

@implementation HRYQJHHeaderView
+ (instancetype)inviteView{
    
    HRYQJHHeaderView *view = [[[NSBundle mainBundle]loadNibNamed:@"HRYQJHHeaderView" owner:nil options:nil]lastObject];

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
