//
//  CXActivityCouponModel.h
//  HunQingYH
//
//  Created by canxue on 2019/12/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 优惠券、福利 model- - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - - - -美食福利、宝妈福利等数据model- - - - - - - - - - - - - - - - - -


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXActivityCouponModel : NSObject


@property (nonatomic, copy) NSString *Id;    // <#这里是个注释哦～#>
@property (nonatomic, copy) NSString *CategoryName;    // 类别名称
@property (nonatomic, copy) NSString *Name;    // 券名称
@property (nonatomic, copy) NSString *CreateTime;    // 发布时间
@property (nonatomic, copy) NSString *ValidityTime;    // 到期时间
@property (nonatomic, copy) NSString *Number;    // 券数量
@property (nonatomic, copy) NSString *SurplusNumber;    // 剩余数量
@property (nonatomic, copy) NSString *MerchantName;    // 商家名称
@property (nonatomic, copy) NSString *MerchantAddress;    // 商家地址
@property (nonatomic, copy) NSString *MerchantPhone;    // 商家电话
@property (nonatomic, copy) NSString *ReceiveCategory;    // 领取类别 0免费领取，1条件领取
@property (nonatomic, copy) NSString *CollectionNumber;    // 领取数量
@property (nonatomic, copy) NSString *AreaId;    // 地区id
@property (nonatomic, copy) NSString *MerchantExplain;    // 商家优惠
@property (nonatomic, copy) NSString *CoverMap;    // 封面图
@property (nonatomic, copy) NSString *DetailMap;    // 详情图
@property (nonatomic, copy) NSString *ReceiveCondition;    // 领取条件

@end

NS_ASSUME_NONNULL_END
