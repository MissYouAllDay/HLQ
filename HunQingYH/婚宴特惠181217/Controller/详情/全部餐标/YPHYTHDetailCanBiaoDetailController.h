//
//  YPHYTHDetailCanBiaoDetailController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetPreferentialCommodityPriceList.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailCanBiaoDetailController : UIViewController

@property (nonatomic, strong) YPGetPreferentialCommodityPriceList *canbiaoModel;

/**date*/
@property (nonatomic, copy) NSString *dateStr;
/**商品ID*/
@property (nonatomic, copy) NSString *CommodityId;
/**折扣比例*/
@property (nonatomic, copy) NSString *Discount;
/**服务费比例*/
@property (nonatomic, copy) NSString *ServiceChargeProportion;

@end

NS_ASSUME_NONNULL_END
