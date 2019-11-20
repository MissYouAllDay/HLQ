//
//  YPGetUserShoppingRecord.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/19.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPGetUserShoppingRecord.h"

@implementation YPGetUserShoppingRecord

+ (NSDictionary *)objectClassInArray{
    return @{
             @"CommodityData" : [YPGetUserShoppingRecordCommodityData class]
             };
}

@end
