//
//  YPGetSupplierrOrderList.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGetSupplierrOrderList : NSObject

/**订单ID*/
@property (nonatomic, copy) NSString *SupplierOrderID;
/**公司ID*/
@property (nonatomic, copy) NSString *CorpID;
/**公司名称*/
@property (nonatomic, copy) NSString *CorpName;
/**公司logo*/
@property (nonatomic, copy) NSString *CorpLogo;
/**公司酒店ID*/
@property (nonatomic, copy) NSString *CorpRummeryID;
/**公司酒店地址*/
@property (nonatomic, copy) NSString *CorpRummeryAddress;
/**客户ID*/
@property (nonatomic, copy) NSString *CustomerID;
/**婚期*/
@property (nonatomic, copy) NSString *WeddingDate;
/**内部价格*/
@property (nonatomic, copy) NSString *InsidePrice;
/**新人价格*/
@property (nonatomic, copy) NSString *ExternalPrice;
/**结算价格*/
@property (nonatomic, copy) NSString *SettlementPrice;
/**应答状态 0 未应答 1、已同意 2、已拒绝*/
@property (nonatomic, copy) NSString *AnswerStatus;
/**结算状态 1、已结算 2、未结算*/
@property (nonatomic, copy) NSString *Status;
/**结算时间*/
@property (nonatomic, copy) NSString *SettlementTime;

///9.7 添加
/**公司联系人姓名,电话 逗号分隔 例 张三,1860001234
 
 9.22 修改 只有电话
 
 */
@property (nonatomic, copy) NSString *CorpPhone;
/**公司酒店名称*/
@property (nonatomic, copy) NSString *CorpRummeryName;

@end
