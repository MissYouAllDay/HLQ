//
//  YPWeddingOrderSupplierListController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YPWeddingOrderSupplierIDBlock)(NSString *name,NSString *supID);

@interface YPWeddingOrderSupplierListController : UIViewController

/**职业数组*/
@property(nonatomic,strong) NSMutableArray  *zhiYeArr;

@property (nonatomic, copy) YPWeddingOrderSupplierIDBlock supBlock;

@end

NS_ASSUME_NONNULL_END
