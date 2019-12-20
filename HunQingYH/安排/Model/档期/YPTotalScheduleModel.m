//
//  YPTotalScheduleModel.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/14.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPTotalScheduleModel.h"

@implementation YPTotalScheduleModel
// 实现这个方法的目的：告诉MJExtension框架statuses和ads数组里面装的是什么模型

+ (NSDictionary *)objectClassInArray{
 return @{
 @"Data" : [YPGetScheduleList class],
   };
 }
 

@end
