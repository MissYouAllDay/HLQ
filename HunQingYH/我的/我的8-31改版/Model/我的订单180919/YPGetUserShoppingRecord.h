//
//  YPGetUserShoppingRecord.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/19.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPGetUserShoppingRecordCommodityData.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPGetUserShoppingRecord : NSObject

/**订单Id*/
@property (nonatomic, copy) NSString *Id;
/**订单审核状态
 0未审核,1已审核,2审核驳回*/
@property (nonatomic, copy) NSString *IsStatus;
/**订单时间*/
@property (nonatomic, copy) NSString *CreateTime;
/**快递名称*/
@property (nonatomic, copy) NSString *ExpressName;
/**快递单号*/
@property (nonatomic, copy) NSString *ExpressNumber;
/**额度*/
@property (nonatomic, copy) NSString *Quota;
/**活动名称*/
@property (nonatomic, copy) NSString *ActivityCategoryName;
/**手机号*/
@property (nonatomic, copy) NSString *Phone;
/**CommodityData*/
@property (nonatomic, strong) NSArray<YPGetUserShoppingRecordCommodityData *> *CommodityData;

@end

NS_ASSUME_NONNULL_END
