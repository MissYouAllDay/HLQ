//
//  CXMyCouponListVC.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

// 券的状态 
typedef enum : NSUInteger {
    ConpouTypeNotUsed,          // 已使用
    ConpouTypeAlreadyUsed,      // 未使用
    ConpouTypeExpired           // 已过期
} ConpouType;

@interface CXMyCouponListVC : UIViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, assign) ConpouType conpouType;    // 券的状态
@property (nonatomic, strong) UINavigationController  *mainNa;    // <#这里是个注释哦～#>

@end

NS_ASSUME_NONNULL_END
