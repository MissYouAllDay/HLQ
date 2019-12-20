//
//  YPGetPreferentialCommodityList.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPGetPreferentialCommodityList : NSObject

///商品Id
@property (nonatomic , copy) NSString              * Id;
///名称
@property (nonatomic , copy) NSString              * Name;
///服务商名称
@property (nonatomic , copy) NSString              * FacilitatorName;
///服务商手机号
@property (nonatomic , copy) NSString              * FacilitatorPhone;
///上下架状态 0下架,1上架
@property (nonatomic , assign) NSInteger           Type;
///销量
@property (nonatomic , assign) NSInteger           SalesVolume;
///价格
@property (nonatomic , copy) NSString              * Price;
///价格比例
@property (nonatomic , assign) NSInteger           Discount;
///封面图
@property (nonatomic , copy) NSString              * CoverMap;

///19-01-10
/**服务商头像*/
@property (nonatomic, copy) NSString *FacilitatorImage;

/**最小桌数*/
@property (nonatomic, copy) NSString *MinTable;
/**最大桌数*/
@property (nonatomic, copy) NSString *MaxTable;

@end

NS_ASSUME_NONNULL_END
