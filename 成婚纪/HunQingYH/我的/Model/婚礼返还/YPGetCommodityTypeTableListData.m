//
//  YPGetCommodityTypeTableListData.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPGetCommodityTypeTableListData.h"

@implementation YPGetCommodityTypeTableListData
+ (NSDictionary *)objectClassInArray{
    return @{
             @"Data" : [CXSpecificationsModel class]
             };
}

- (void)setCarouselFigure:(NSString *)CarouselFigure {
    
    _CarouselFigure = CarouselFigure;
    
    self.CarouselFigureArr = [_CarouselFigure componentsSeparatedByString:@","];
}

@end
