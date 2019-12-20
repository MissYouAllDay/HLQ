//
//  YPHYTHDetailSubmitOrderController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetPreferentialCommodityPriceList.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailSubmitOrderController : UIViewController

@property (nonatomic, strong) YPGetPreferentialCommodityPriceList *listModel; 

/**ID*/
@property (nonatomic, copy) NSString *detailID;
/**餐标时间 月份*/
@property (nonatomic, copy) NSString *canbiaoTime;
@property (nonatomic, strong) NSDate *canbiaoDate;

/**折扣比例*/
@property (nonatomic, copy) NSString *Discount;
/**服务费比例*/
@property (nonatomic, copy) NSString *ServiceChargeProportion;

@end

NS_ASSUME_NONNULL_END
