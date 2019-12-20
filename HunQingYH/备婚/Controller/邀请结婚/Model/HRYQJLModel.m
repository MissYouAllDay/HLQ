//
//  HRYQJLModel.m
//  HunQingYH
//
//  Created by Hiro on 2018/3/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJLModel.h"
#import <MJExtension.h>
@implementation HRYQJLModel
// 实现这个方法的目的：告诉MJExtension框架statuses和ads数组里面装的是什么模型

+ (NSDictionary *)objectClassInArray{
    return @{
             @"Data" : [HRInvitePeopleModel class],
             };
}

@end
