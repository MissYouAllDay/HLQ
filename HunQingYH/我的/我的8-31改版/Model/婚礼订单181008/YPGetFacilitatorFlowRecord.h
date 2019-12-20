//
//  YPGetFacilitatorFlowRecord.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetFacilitatorFlowRecord : NSObject

/**Id*/
@property (nonatomic, copy) NSString *Id;
/**商家id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**商家名称*/
@property (nonatomic, copy) NSString *FacilitatorName;
/**新人手机号*/
@property (nonatomic, copy) NSString *Phone;
/**提交时间*/
@property (nonatomic, copy) NSString *CreateTime;
/**类型
 0线上,1线下*/
@property (nonatomic, copy) NSString *PaymentType;
/**是否支付
 0未支付,1已支付*/
@property (nonatomic, copy) NSString *MakePayment;
/**审核状态
 0未审核,1已审核,2已驳回*/
@property (nonatomic, copy) NSString *Type;
/**分配商家名称*/
@property (nonatomic, copy) NSString *DistributionFacilitatorName;
/**用户姓名*/
@property (nonatomic, copy) NSString *UserName;
/**应付金额*/
@property (nonatomic, copy) NSString *Money;
/**返还金额*/
@property (nonatomic, copy) NSString *DistributionLine;
/**驳回理由*/
@property (nonatomic, copy) NSString *DismissReason;
/**婚礼日期*/
@property (nonatomic, copy) NSString *WeddingDate;
/**备注*/
@property (nonatomic, copy) NSString *Meno;
/**接单人手机号*/
@property (nonatomic, copy) NSString *SinglePersonPhone;
/**代收是否打款
 1已打款 0未打款*/
@property (nonatomic, copy) NSString *MakeMoney;
/**活动类型
 0伴手礼,1代收,2婚礼返还*/
@property (nonatomic, copy) NSString *ActivityType;




#pragma mark - - - - - - - - - - - - - - - 新增字段 王铭- - - - - - - - - - - - - - - - -
/** 桌数 */
@property (nonatomic, copy) NSString *TablesNumber;
/** 桌数 后台比较坑。用的字段前后不一致 使用的时候注意 */
@property (nonatomic, copy) NSString *TableNumber;
/** 餐标 */
@property (nonatomic, copy) NSString *MealMark;
/**
 检查输入信息的准确性
 
 @param model 数据
 @return 是否输入符合后台参数传值
 */
+ (BOOL)checkoutData:(YPGetFacilitatorFlowRecord *)model;

/** 用户提交伴手礼申请时使用。 用户的useid */
@property (nonatomic, copy) NSString *IdentityId;
/**
 检查输入信息的准确性
 
 @param model 数据
 @return 是否输入符合后台参数传值
 */
+ (BOOL)checkouUserSubData:(YPGetFacilitatorFlowRecord *)model;

/**
 将输入数据转换为后台所需数据
 
 @param model 数据
 @return 后台所需参数。
 */
+ (NSDictionary *)changeInputInfoToSubData:(YPGetFacilitatorFlowRecord *)model ;
@end

NS_ASSUME_NONNULL_END
