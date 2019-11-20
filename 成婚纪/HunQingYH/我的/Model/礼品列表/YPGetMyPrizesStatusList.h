//
//  YPGetMyPrizesStatusList.h
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetMyPrizesStatusList : NSObject

/**奖品领取ID*/
@property (nonatomic, copy) NSString *AcquiringPrizesID;
/**奖品编码*/
@property (nonatomic, copy) NSString *PrizesCode;
/**档次*/
@property (nonatomic, copy) NSString *Grade;
/**发货地址ID*/
@property (nonatomic, copy) NSString *DeliveryId;
/**货物状态 0等待发货、1已发货*/
@property (nonatomic, copy) NSString *PrizesStart;
/**物流单号*/
@property (nonatomic, copy) NSString *LogisticsNumber;
/**创建时间*/
@property (nonatomic, copy) NSString *CreateTime;

@end
