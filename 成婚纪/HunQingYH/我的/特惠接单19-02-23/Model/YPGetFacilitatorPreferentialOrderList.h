//
//  YPGetFacilitatorPreferentialOrderList.h
//  HunQingYH
//
//  Created by Else丶 on 2019/2/25.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetFacilitatorPreferentialOrderList : NSObject

/**订单Id*/
@property (nonatomic, copy) NSString *Id;
/**商品名称*/
@property (nonatomic, copy) NSString *Name;
/**桌数*/
@property (nonatomic, copy) NSString *TableNumber;
/**餐标*/
@property (nonatomic, copy) NSString *MealAmount;
/**支付状态
 0定金,1已结清(已结清等待酒店确认) -- 19-02-28 接单不使用*/
@property (nonatomic, copy) NSString *PaymentType;
/**待付尾款*/
@property (nonatomic, copy) NSString *PaidAmount;
/**支付类型
 0未支付,1已支付(交易全部完成),2已失效*/
@property (nonatomic, copy) NSString *PaymentStatus;
/**商品封面图*/
@property (nonatomic, copy) NSString *CoverMap;
/**用户Id*/
@property (nonatomic, copy) NSString *UserId;
/**用户姓名*/
@property (nonatomic, copy) NSString *UserName;
/**用户头像*/
@property (nonatomic, copy) NSString *UserHeadportrait;
/**用户手机号*/
@property (nonatomic, copy) NSString *UserPhone;
/**接单状态
 0待定,1接单,2拒单*/
@property (nonatomic, copy) NSString *ReceiptType;

/**服务时间*/
@property (nonatomic, copy) NSString *ServiceTime;
/**下单时间*/
@property (nonatomic, copy) NSString *CreateTime;

/**服务商输入尾款状态
 0未输入,1已输入*/
@property (nonatomic, copy) NSString *FacilitatorTailMoney;

@end

NS_ASSUME_NONNULL_END
