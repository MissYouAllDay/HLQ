//
//  YPHomeReserveTingController.h
//  HunQingYH
//
//  Created by Else丶 on 2019/5/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetHotelBanquetlList.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPHomeReserveTingController : UIViewController

@property (nonatomic, assign) NSInteger type; ///< 1:首页 2:特惠详情

@property (nonatomic, strong) YPGetHotelBanquetlList *listModel; 
@property (nonatomic, copy) NSString *hotelTing;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *zhuoshu;

@end

NS_ASSUME_NONNULL_END
