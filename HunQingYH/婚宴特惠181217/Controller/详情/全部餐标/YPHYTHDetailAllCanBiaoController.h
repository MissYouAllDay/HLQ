//
//  YPHYTHDetailAllCanBiaoController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/18.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YPAllCanBiaoDateBlock)(NSString *dateStr);

@interface YPHYTHDetailAllCanBiaoController : UIViewController

@property (nonatomic, copy) NSString *titleStr;
/**date*/
@property (nonatomic, copy) NSString *dateStr;
/**商品ID*/
@property (nonatomic, copy) NSString *CommodityId;

/**折扣比例*/
@property (nonatomic, copy) NSString *Discount;
/**服务费比例*/
@property (nonatomic, copy) NSString *ServiceChargeProportion;

@property (nonatomic, copy) YPAllCanBiaoDateBlock dateBlock;

@end

NS_ASSUME_NONNULL_END
