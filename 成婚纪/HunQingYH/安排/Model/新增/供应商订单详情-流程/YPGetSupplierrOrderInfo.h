//
//  YPGetSupplierrOrderInfo.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/7.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetSupplierrOrderInfoData.h"

@interface YPGetSupplierrOrderInfo : NSObject

/**总数量*/
@property (nonatomic, copy) NSString *TotalCount;
/**新郎信息 姓名,手机号*/
@property (nonatomic, copy) NSString *Groom;
/**新娘信息 姓名,手机号*/
@property (nonatomic, copy) NSString *Bride;
/**酒店名称*/
@property (nonatomic, copy) NSString *RummeryName;
/**宴会厅名称*/
@property (nonatomic, copy) NSString *BanquetHallName;
/**酒店地址*/
@property (nonatomic, copy) NSString *RummeryAddress;
/**流程*/
@property (nonatomic, strong) NSArray<YPGetSupplierrOrderInfoData *> *Data;

///9.20 添加
/**档期ID 供应商订单已接受时才返回 ,否则返回0*/
@property (nonatomic, copy) NSString *ScheduleID;

@end
