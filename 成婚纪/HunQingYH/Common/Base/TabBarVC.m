//
//  TabBarVC.m
//  XSchoolParents
//
//  Created by 李秋 on 2017/10/12.
//  Copyright © 2017年 李秋. All rights reserved.
//

#import "TabBarVC.h"
#import "YPMe180831Controller.h"//18-08-31 我的改版
#import "HRNavigationController.h"
#import "HRBeiHunController.h"//11-29 添加 备婚
//#import "HRFaxianViewController.h"//发现
//#import "YPActivityController.h"//5-11 活动
#import "YPReActivityController.h"//18-08-27 活动
#import "YPReFindController.h"//5-28 重做 发现
#import "YPPassengerDistributionController.h"//18-11-27 客源分配
#import "YPHunYanTeHuiBaseController.h"//18-12-17 特惠
#import "CXDingHunYanVC.h"      // 订婚宴。 19-09-24
#import "YPHome190223Controller.h"//19-02-23 首页改版
#import "YPWedSchemeViewController.h"//19-02-28 婚礼策划
#import "YPKeYuan190306BaseViewController.h"//19-03-06 客源
#import "YPKeYuan190513ViewController.h"
#import "ManageViewController.h"//管理
#import "YPHome190226FindSupplierController.h"//招商家

// 第二期
#import "CXCommunityViewController.h"   // 社区
#import "CXActivityHomeVC.h"        //免费领

@interface TabBarVC ()
@property (nonatomic,assign) NSInteger index;
@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
}

- (void)createTabBar{
 
     [self createControllerWithTitle:@"婚宴" image:@"canchu"selectedimage:@"canchu-2" className:[CXDingHunYanVC class]];
     [self createControllerWithTitle:@"婚礼" image:@"hunlicehua"selectedimage:@"hunlicehua-2" className:[YPWedSchemeViewController class]];
     [self createControllerWithTitle:@"免费领" image:@"mianfeilingqu"selectedimage:@"mianfeilingqu-2" className:[CXActivityHomeVC class]];
     [self createControllerWithTitle:@"社区" image:@"shequ"selectedimage:@"shequ-2" className:[CXCommunityViewController class]];
//     [self createControllerWithTitle:@"管理" image:@"tabbar_wode"selectedimage:@"tabbar_wode_red" className:[ManageViewController class]];
     [self createControllerWithTitle:@"我的" image:@"guanli"selectedimage:@"guanli-2" className:[YPMe180831Controller class]];
}

//提取公共方法
- (void)createControllerWithTitle:(NSString *)title image:(NSString *)image selectedimage:(NSString *)selectedimage  className:(Class)class{
    UIViewController *vc = [[class alloc]init];
   HRNavigationController * nav = [[HRNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    nav.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColor, NSForegroundColorAttributeName,
                                                       nil,nil] forState:UIControlStateSelected];
}

// 点击tabbarItem自动调用
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (index != _index) {
        [self animationWithIndex:index];
        _index = index;
    }
    if (index==1 ||index==2 ||index==3||index==4) {
        //18-09-05
        
        if (!UserId_New) {
           
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
          
        }else{
            if (index != _index) {
                [self animationWithIndex:index];
                _index = index;
            }
        }
        
    }else{
        if (index != _index) {
            [self animationWithIndex:index];
            _index = index;
        }
    }
    
    
    
 
   
    
    
    
//    if([item.title isEqualToString:@"发现"])
//    {
//        // 也可以判断标题,然后做自己想做的事
//    }
//    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    HRNavigationController *navCtrl = (HRNavigationController *)viewController;
    UIViewController *rootCtrl = navCtrl.topViewController;
    if([rootCtrl isKindOfClass:[YPWedSchemeViewController class]])
    {
        
        if (!UserId_New) {
            
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
            YPHome190223Controller *navCtrl2 = self.viewControllers[0];
            self.selectedViewController = navCtrl2;
            self.selectedIndex = 0;
            return NO;
            
        }else{
            return YES;
        }
      
        
    }
    return YES;
    
}


- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    /**
     CABasicAnimation类的使用方式就是基本的关键帧动画。
     
     所谓关键帧动画，就是将Layer的属性作为KeyPath来注册，指定动画的起始帧和结束帧，然后自动计算和实现中间的过渡动画的一种动画方式。
     */
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
}

@end
