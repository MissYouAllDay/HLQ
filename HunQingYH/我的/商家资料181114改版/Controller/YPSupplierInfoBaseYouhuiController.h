//
//  YPSupplierInfoBaseYouhuiController.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/14.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YPSupplierInfoBaseYouhuiBlock)(NSInteger recordCount);

@interface YPSupplierInfoBaseYouhuiController : UIViewController

@property (nonatomic, copy) YPSupplierInfoBaseYouhuiBlock baseCountBlock;

@end

NS_ASSUME_NONNULL_END
