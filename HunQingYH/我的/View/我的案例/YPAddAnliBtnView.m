//
//  YPAddAnliBtnView.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddAnliBtnView.h"

@implementation YPAddAnliBtnView

+ (instancetype)addAnliBtnView{
    YPAddAnliBtnView *add = [[[NSBundle mainBundle]loadNibNamed:@"YPAddAnliBtnView" owner:nil options:nil]lastObject];
    return add;
}

@end
