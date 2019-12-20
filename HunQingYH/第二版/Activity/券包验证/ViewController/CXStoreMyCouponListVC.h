//
//  CXStoreMyCouponListVC.h
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

// - - - - - - - - - - - - - - 领券情况 未验证list- - - - - - - - - - - - - - - - - - - - - -
#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXStoreMyCouponListVC : UIViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, strong) UINavigationController  *mainNa;    // <#这里是个注释哦～#>
@end

NS_ASSUME_NONNULL_END
