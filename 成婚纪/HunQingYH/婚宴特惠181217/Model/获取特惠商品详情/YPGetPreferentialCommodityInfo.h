//
//  YPGetPreferentialCommodityInfo.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRTingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YPGetPreferentialCommodityInfo : NSObject

///名称
@property (nonatomic , copy) NSString              * Name;
///封面图
@property (nonatomic , copy) NSString              * CoverMap;
///区域名称
@property (nonatomic , copy) NSString              * AreaId;
///折扣比例   优惠服务费
@property (nonatomic , copy) NSString              * Discount;
///服务费比例
@property (nonatomic , copy) NSString              * ServiceChargeProportion;
///定金
@property (nonatomic , assign) NSInteger              EarnestMoney;
///最小桌数
@property (nonatomic , assign) NSInteger              MinTable;
///最大桌数
@property (nonatomic , assign) NSInteger              MaxTable;
///详情图
@property (nonatomic , copy) NSString              * DetaiMap;
///服务商名称
@property (nonatomic , copy) NSString              * FacilitatorName;
///礼品Banner
@property (nonatomic , copy) NSString              * PresentBanner;
///礼品详情图banner
@property (nonatomic , copy) NSString              * PresentDetailMap;

/**服务商id*/
@property (nonatomic, copy) NSString *FacilitatorId;
/**服务商头像*/
@property (nonatomic, copy) NSString *FacilitatorImage;
/**地址*/
@property (nonatomic, copy) NSString *Address;
/**销量*/
@property (nonatomic, copy) NSString *SalesVolume;
/**案例数量*/
@property (nonatomic, copy) NSString *CaseInfoCount;
/**动态数量*/
@property (nonatomic, copy) NSString *DynamicCount;

/** 酒店介绍 */
@property (nonatomic, copy) NSString *Abstract;
/** 优惠服务费 */
@property (nonatomic, copy) NSString *DiscountCharge;
/** 正常服务费 */
@property (nonatomic, copy) NSString *ServiceCharge;

// 新增字段。原因：以前技术写的实体类没有做修改。只能延续用着。。。你想改就改吧，我是比较懒的。改的地方比较多，你改的时候注意点
/** 面积 */
@property (nonatomic, copy) NSString *Acreage;
/** 长度 */
@property (nonatomic, copy) NSString *Length;
/** 宽度 */
@property (nonatomic, copy) NSString *Width;
/** 高度 */
@property (nonatomic, copy) NSString *Height;
/** 柱子数量 */
@property (nonatomic, assign)  NSInteger Column;




- (void)getOtherModelValue:(HRTingModel *)banquetModel ;


@end

NS_ASSUME_NONNULL_END
