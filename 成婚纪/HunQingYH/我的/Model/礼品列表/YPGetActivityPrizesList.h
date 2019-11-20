//
//  YPGetActivityPrizesList.h
//  hunqing
//
//  Created by Else丶 on 2017/11/16.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetActivityPrizesList : NSObject

/**活动奖品ID*/
@property (nonatomic, copy) NSString *ActivityPrizesID;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**展示图*/
@property (nonatomic, copy) NSString *ShowImg;
/**国家*/
@property (nonatomic, copy) NSString *Country;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

///1-8 添加
/**价格*/
@property (nonatomic, copy) NSString *MarketPrice;
/**是否为大图*/
@property (nonatomic, copy) NSString *IsBig;

@end
