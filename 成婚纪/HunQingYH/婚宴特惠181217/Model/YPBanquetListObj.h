//
//  YPBanquetListObj.h
//  HunQingYH
//
//  Created by spring on 2019/9/2.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBanquetListObj : NSObject
///商品Id
@property (nonatomic , copy) NSString              * BanquetID;
///名称
@property (nonatomic , copy) NSString              * BanquetHallName;
///价格
@property (nonatomic , copy) NSString              * FloorPrice;
///面积
@property (nonatomic , copy) NSString              * Acreage;
///服务商名称
@property (nonatomic , copy) NSString              * Height;
///服务商手机号
@property (nonatomic , assign) NSInteger               MaxTableCount;
///上下架状态 0下架,1上架
@property (nonatomic , copy) NSString           *HotelLogo;
///销量
@property (nonatomic , assign) NSInteger           ShelfType;
///价格
@property (nonatomic , copy) NSString              * Collection;

///价格比例
@property (nonatomic , copy) NSString          * Name;
///封面图
@property (nonatomic , copy) NSString              * HeadImg;

///19-01-10
/**服务商头像*/
@property (nonatomic, assign) NSInteger MinTableNumber;

/**最小桌数*/
@property (nonatomic, copy) NSString *Discount;
/**最大桌数*/
@property (nonatomic, copy) NSString *DiscountCharge;

@property (nonatomic, copy) NSString *ServiceCharge;
@property (nonatomic, copy) NSString *ReservedQuantity;
@property (nonatomic, copy) NSString *Address;


@end

NS_ASSUME_NONNULL_END
