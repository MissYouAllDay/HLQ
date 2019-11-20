//
//  YPGetCommodityInfo.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetCommodityInfo : NSObject

/**商品Id*/
@property (nonatomic, copy) NSString *CommodityId;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**产地*/
@property (nonatomic, copy) NSString *PlaceOrigin;
/**额度*/
@property (nonatomic, assign) NSInteger Quota;
/**封面图*/
@property (nonatomic, copy) NSString *CoverMap;
/**轮播图*/
@property (nonatomic, copy) NSString *CarouselFigure;
/**上下架状态*/
@property (nonatomic, copy) NSString *OffShelf;
/**简介图*/
@property (nonatomic, copy) NSString *BriefIntroduction;

@end
