//
//  YPEDuGoodDetailController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/4/17.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPEDuGoodDetailController : UIViewController

/**商品ID*/
@property (nonatomic, copy) NSString *commodityId;
/**5-23 是否显示购物车*/
@property (nonatomic, assign) BOOL willShowCart;
/**奖品列表类型 0伴手礼,1婚礼返还,2代收*/
@property (nonatomic, copy) NSString *ActivityIdType;

@end
