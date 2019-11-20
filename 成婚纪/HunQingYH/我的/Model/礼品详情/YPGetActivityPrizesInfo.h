//
//  YPGetActivityPrizesInfo.h
//  hunqing
//
//  Created by Else丶 on 2017/11/16.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetActivityPrizesInfo : NSObject

/**活动奖品ID*/
@property (nonatomic, copy) NSString *ActivityPrizesID;
/**商品名称*/
@property (nonatomic, copy) NSString *CommodityName;
/**关键字*/
@property (nonatomic, copy) NSString *PrizesKeyWord;
/**内容*/
@property (nonatomic, copy) NSString *PrizesContent;
/**国家*/
@property (nonatomic, copy) NSString *Country;
/**图片*/
@property (nonatomic, copy) NSString *Imgs;
/**市场价格*/
@property (nonatomic, copy) NSString *MarketPrice;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

@end
