//
//  YPGetUserFlowRecord.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/14.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetUserFlowRecord : NSObject

/**Id*/
@property (nonatomic, copy) NSString *Id;
/**商家id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**商家名称*/
@property (nonatomic, copy) NSString *FacilitatorName;
/**订单类型
 0伴手礼,1婚礼返还,2代收*/
@property (nonatomic, copy) NSString *OrderType;
/**提交时间*/
@property (nonatomic, copy) NSString *CreateTime;
/**类型
 0线上,1线下*/
@property (nonatomic, copy) NSString *PaymentType;
/**是否支付
 0未支付,1已支付,2已拒单*/
@property (nonatomic, copy) NSString *MakePayment;
/**审核状态
 0未审核,1已审核,2已驳回*/
@property (nonatomic, copy) NSString *Type;
/**金额*/
@property (nonatomic, assign) CGFloat Money;
/**分配金额*/
@property (nonatomic, assign) CGFloat DistributionLine;

@end
