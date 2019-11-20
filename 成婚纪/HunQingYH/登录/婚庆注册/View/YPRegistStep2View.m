//
//  YPRegistStep2View.m
//  hunqing
//
//  Created by YanpengLee on 2017/5/12.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegistStep2View.h"

@implementation YPRegistStep2View

+ (YPRegistStep2View *)registStep2View{
    YPRegistStep2View *step2 = [[[NSBundle mainBundle] loadNibNamed:@"YPRegistStep2View" owner:nil options:nil]lastObject];
    return step2;
}

@end
