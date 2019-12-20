//
//  UINavigationController+YPCategory.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "UINavigationController+YPCategory.h"

@implementation UINavigationController (YPCategory)

- (void)yp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {//如果push进来的不是第一个控制器
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
//        [self removeOriginControls:viewController];
    }
    [self pushViewController:viewController animated:animated];
}

//- (void)removeOriginControls:(UIViewController *)vc {
//    
//    [vc.tabBarController.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
//        
//        if ([obj isKindOfClass:[UIControl class]]) {
//            
//            [obj removeFromSuperview];
//        }
//    }];
//}

@end
