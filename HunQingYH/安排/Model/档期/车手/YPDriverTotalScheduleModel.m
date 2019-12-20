//
//  YPDriverTotalScheduleModel.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDriverTotalScheduleModel.h"

@implementation YPDriverTotalScheduleModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"Data" : [YPGetDriverScheduleList class]
             };
}

@end
