//
//  YPGetFacilitatorMoneyFlowingWaterListData.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/28.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetFacilitatorMoneyFlowingWaterListData : NSObject

/**记录Id*/
@property (nonatomic, copy) NSString *Id;
/**服务商名称*/
@property (nonatomic, copy) NSString *FacilitatorName;
/**资金类型
 0商家充值、1伴手礼、2婚礼返还、3代收,4提现*/
@property (nonatomic, copy) NSString *SourceType;
/**金额*/
@property (nonatomic, copy) NSString *Money;
/**时间*/
@property (nonatomic, copy) NSString *CreateTime;
/**账号类型
 0银行卡,1支付宝*/
@property (nonatomic, copy) NSString *AccountType;
/**相关账号*/
@property (nonatomic, copy) NSString *AccountNumber;
@end

NS_ASSUME_NONNULL_END
