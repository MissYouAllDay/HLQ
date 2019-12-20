//
//  YPHYTHRefundController.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHRefundController : UIViewController

/**订单Id*/
@property (nonatomic, copy) NSString *Id;
/**商品名称*/
@property (nonatomic, copy) NSString *Name;
/**桌数*/
@property (nonatomic, copy) NSString *TableNumber;
/**餐标*/
@property (nonatomic, copy) NSString *MealAmount;
/**支付金额*/
@property (nonatomic, copy) NSString *PaymentAmount;
/**商品封面图*/
@property (nonatomic, copy) NSString *CoverMap;

@end

NS_ASSUME_NONNULL_END
