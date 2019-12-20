//
//  LCTabBarController.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015 Leo <leodaxia@gmail.com>
//
//  Copyright (c) 2015-2017 Leo
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "LCTabBarController.h"
#import "LCTabBarCONST.h"
#import "LCTabBarItem.h"

//#import "YPHomeController.h"
//#import "YPReHomeController.h"//1-2 修改
//#import "YPReReHomeController.h"//5-9 首页 改版
//#import "YPArrangeController.h"//安排 -- 婚车
//#import "YPNewMarriedController.h"//安排 -- 新人
//#import "YPMeController.h"
//#import "YPReMeController.h"//5-10 我的 改版
#import "YPMe180831Controller.h"//18-08-31 我的改版
#import "HRNavigationController.h"
#import "HRBeiHunController.h"//11-29 添加 备婚
//#import "HRFaxianViewController.h"//发现
//#import "YPActivityController.h"//5-11 活动
#import "YPReActivityController.h"//18-08-27 活动
#import "YPReFindController.h"//5-28 重做 发现
#import "YPPassengerDistributionController.h"//18-11-27 客源分配
#import "YPHunYanTeHuiBaseController.h"//18-12-17 特惠
#import "YPHome180904Controller.h"//18-09-04 首页改版
#import "YPHome190223Controller.h"//19-02-23 首页改版
#import "YPWedSchemeViewController.h"//19-02-28 婚礼策划
#import "YPKeYuan190306BaseViewController.h"//19-03-06 客源
#import "YPKeYuan190513ViewController.h"
#import "ManageViewController.h"//管理
#import "CXManagerHomeVC.h" // 管理
#import "YPHome190226FindSupplierController.h"
@interface LCTabBarController () <LCTabBarDelegate>

//@property (nonatomic, strong) YPHome180904Controller *homeVC;
@property (nonatomic, strong) YPHome190223Controller *homeVC;
//@property (nonatomic, strong) YPArrangeController *arrangeVC;
//@property (nonatomic, strong) YPNewMarriedController *marriedVC;
//@property (nonatomic, strong) YPMeController *meVC;
//@property (nonatomic, strong) YPReMeController *meVC;
@property (nonatomic, strong) YPMe180831Controller *meVC;
@property (nonatomic, strong) HRBeiHunController *beiHunVC;
//@property(nonatomic,strong)HRFaxianViewController *faxianVC ;
@property (nonatomic, strong) YPReFindController *faxianVC;
@property (nonatomic, strong) YPReActivityController *actVC;
@property (nonatomic, strong) YPHunYanTeHuiBaseController *tehuiVC;
//@property (nonatomic, strong) YPHome190226FindSupplierController *tehuiVC;
@property (nonatomic, strong) YPWedSchemeViewController *cehuaVC;
//@property (nonatomic, strong) YPPassengerDistributionController *keyuanVC;
//@property (nonatomic, strong) YPKeYuan190306BaseViewController *keyuanVC;
@property (nonatomic, strong) YPKeYuan190513ViewController *keyuanVC;
/**管理*/
@property(nonatomic,strong)CXManagerHomeVC  *manageVC;
/**tabbar我的或者管理控制器标识*/
@property(nonatomic,copy)NSString  *typeStr;
@end

@implementation LCTabBarController

#pragma mark - getter

//- (YPHome180904Controller *)homeVC{
//    if (!_homeVC) {
//        _homeVC = [[YPHome180904Controller alloc]init];
//    }
//    _homeVC.hidesBottomBarWhenPushed = NO;
//    return _homeVC;
//}
-(CXManagerHomeVC *)manageVC{
    if (!_manageVC) {
        _manageVC =[CXManagerHomeVC new];
    }
    return _manageVC;
}
- (YPHome190223Controller *)homeVC{
    if (!_homeVC) {
        _homeVC = [[YPHome190223Controller alloc]init];
    }
    _homeVC.hidesBottomBarWhenPushed = NO;
    return _homeVC;
}

- (YPMe180831Controller *)meVC{
    if (!_meVC) {
        _meVC = [[YPMe180831Controller alloc]init];
    }
    _meVC.hidesBottomBarWhenPushed = NO;
    return _meVC;
}

- (HRBeiHunController *)beiHunVC{
    if (!_beiHunVC) {
        _beiHunVC = [[HRBeiHunController alloc]init];
    }
    return _beiHunVC;
}

- (YPReFindController *)faxianVC{
    if (!_faxianVC) {
        _faxianVC = [[YPReFindController alloc]init];
    }
    return _faxianVC;
}

- (YPReActivityController *)actVC{
    if (!_actVC) {
        _actVC = [[YPReActivityController alloc]init];
    }
    return _actVC;
}

//- (YPPassengerDistributionController *)keyuanVC{
//    if (!_keyuanVC) {
//        _keyuanVC = [[YPPassengerDistributionController alloc]init];
//    }
//    return _keyuanVC;
//}

//- (YPKeYuan190306BaseViewController *)keyuanVC{
//    if (!_keyuanVC) {
//        _keyuanVC = [[YPKeYuan190306BaseViewController alloc]init];
//    }
//    return _keyuanVC;
//}

- (YPKeYuan190513ViewController *)keyuanVC{
    if (!_keyuanVC) {
        _keyuanVC = [[YPKeYuan190513ViewController alloc]init];
    }
    return _keyuanVC;
}

- (YPHunYanTeHuiBaseController *)tehuiVC{
    if (!_tehuiVC) {
        
        _tehuiVC = [[YPHunYanTeHuiBaseController alloc]init];//[[YPHunYanTeHuiBaseController alloc]init];
    }
    return _tehuiVC;
}

- (YPWedSchemeViewController *)cehuaVC{
    if (!_cehuaVC) {
        _cehuaVC = [[YPWedSchemeViewController alloc]init];
    }
    return _cehuaVC;
}

#pragma mark -

- (UIColor *)itemTitleColor {
    
    if (!_itemTitleColor) {
        
        //        _itemTitleColor = LCColorForTabBar(117, 117, 117);
        _itemTitleColor = LCColorForTabBar(102, 102, 102);//5-11 修改
    }
    return _itemTitleColor;
}

- (UIColor *)selectedItemTitleColor {
    
    if (!_selectedItemTitleColor) {
        
        //        _selectedItemTitleColor = LCColorForTabBar(234, 103, 7);
        _selectedItemTitleColor = LCColorForTabBar(250, 80, 119);//5-11 修改
    }
    return _selectedItemTitleColor;
}

- (UIFont *)itemTitleFont {
    
    if (!_itemTitleFont) {
        
        _itemTitleFont = [UIFont systemFontOfSize:10.0f];
    }
    return _itemTitleFont;
}

- (UIFont *)badgeTitleFont {
    
    if (!_badgeTitleFont) {
        
        _badgeTitleFont = [UIFont systemFontOfSize:11.0f];
    }
    return _badgeTitleFont;
}

#pragma mark -

- (void)loadView {
    
    [super loadView];
    
    self.itemImageRatio = 0.70f;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
////    for (UIView *child in self.tabBar.subviews) {
////        if ([child isKindOfClass:[UIControl class]]) {
////            [child removeFromSuperview];
////        }
////    }
//
//    [self removeOriginControls];
//}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self removeOriginControls];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    [self removeOriginControls];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.typeStr =@"管理";
    [self.tabBar addSubview:({
        
        LCTabBar *tabBar = [[LCTabBar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.delegate  = self;
        
        self.lcTabBar = tabBar;
    })];
    
    [self setupTabBar];
    
    //    UIKeyboardWillShowNotification
    //    [[NSNotificationCenter defaultCenter] addobserver];
}

- (void)setupTabBar{
    //    self.homeVC = [[YPHomeController alloc] init];
    self.homeVC.view.backgroundColor = CHJ_bgColor;
    //    vc1.tabBarItem.badgeValue = @"23";
    self.homeVC.title = @"首页";
    self.homeVC.tabBarItem.tag =1;
    self.homeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    self.homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_red"];
    
    //    self.faxianVC.title = @"婚礼秀";
    //    self.faxianVC.tabBarItem.tag =2;
    //    self.faxianVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_hunlixiu"];
    //    self.faxianVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_hunlixiu_red"];
    
    self.cehuaVC.title = @"婚礼策划";
    self.cehuaVC.tabBarItem.tag =2;
    self.cehuaVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_hunlixiu"];
    self.cehuaVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_hunlixiu_red"];
    
    self.tehuiVC.title = @"订婚宴";//19-03-15 修改
    self.tehuiVC.tabBarItem.tag = 3;
    self.tehuiVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_tehui"];
    self.tehuiVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_tehui_red"];
    
    self.keyuanVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_keyuan"];
    self.keyuanVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_keyuan_red"];
    self.keyuanVC.title = @"客源";
    self.keyuanVC.tabBarItem.tag = 4;
    
        self.meVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_wode"];
        self.meVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_wode_red"];
        self.meVC.title = @"我的";
        self.meVC.tabBarItem.tag = 5;
    self.manageVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_wode"];
    self.manageVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_wode_red"];
    self.manageVC.title = @"管理";
    self.manageVC.tabBarItem.tag = 5;
    
    
    //给传进来的控制器添加导航控制器
    HRNavigationController *navC1 = [[HRNavigationController alloc] initWithRootViewController:self.homeVC];
    //    HRNavigationController * navC2 = [[HRNavigationController alloc] initWithRootViewController:self.faxianVC];
    HRNavigationController * navC2 = [[HRNavigationController alloc] initWithRootViewController:self.cehuaVC];
    HRNavigationController *navC3 = [[HRNavigationController alloc] initWithRootViewController:self.tehuiVC];
    HRNavigationController *navC4 = [[HRNavigationController alloc] initWithRootViewController:self.keyuanVC];
    HRNavigationController *navC5 = [[HRNavigationController alloc] initWithRootViewController:self.manageVC];
    HRNavigationController *navC6 = [[HRNavigationController alloc] initWithRootViewController:self.meVC];

    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        
        
        [VC removeFromParentViewController];
        
    }];
    if ([self.typeStr isEqualToString:@"我的"]) {
    
        self.viewControllers        = @[navC1, navC2, navC3, navC4, navC6];

    }else{
        self.viewControllers        = @[navC1, navC2, navC3, navC4, navC5];

    }
    NSLog(@"%zd",self.viewControllers.count);
    
    /**************************************** Key Code ****************************************/
    
//    self.viewControllers        = @[navC1, navC2, navC3, navC4, navC5];
    
    /******************************************************************************************/
}

- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        
        if ([obj isKindOfClass:[UIControl class]]) {
            
            [obj removeFromSuperview];
        }
    }];
}
-(void)changeToMe{
    self.typeStr =@"我的";


  

    [self.lcTabBar.tabBarItems removeLastObject];
    
    //给传进来的控制器添加导航控制器
    HRNavigationController *navC1 = [[HRNavigationController alloc] initWithRootViewController:self.homeVC];
    //    HRNavigationController * navC2 = [[HRNavigationController alloc] initWithRootViewController:self.faxianVC];
    HRNavigationController * navC2 = [[HRNavigationController alloc] initWithRootViewController:self.cehuaVC];
    HRNavigationController *navC3 = [[HRNavigationController alloc] initWithRootViewController:self.tehuiVC];
    HRNavigationController *navC4 = [[HRNavigationController alloc] initWithRootViewController:self.keyuanVC];
    HRNavigationController *navC5 = [[HRNavigationController alloc] initWithRootViewController:self.manageVC];
    HRNavigationController *navC6 = [[HRNavigationController alloc] initWithRootViewController:self.meVC];

    self.viewControllers        = @[ navC6];



    
}
-(void)changeToManage{
    self.typeStr =@"管理";
    [self.lcTabBar removeAllSubviews];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        
        
        [VC removeFromParentViewController];
        
    }];
    
    
    [self setupTabBar];
    
    

}
- (void)setViewControllers:(NSArray *)viewControllers {
  
 

    self.lcTabBar.badgeTitleFont         = self.badgeTitleFont;
    self.lcTabBar.itemTitleFont          = self.itemTitleFont;
    self.lcTabBar.itemImageRatio         = self.itemImageRatio;
    self.lcTabBar.itemTitleColor         = self.itemTitleColor;
    self.lcTabBar.selectedItemTitleColor = self.selectedItemTitleColor;

    NSLog(@"哈哈哈%zd",viewControllers.count);
    self.lcTabBar.tabBarItemCount = viewControllers.count;

    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        UIViewController *VC = (UIViewController *)obj;

        UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        [self addChildViewController:VC];

        [self.lcTabBar addTabBarItem:VC.tabBarItem];
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    NSLog(@"tabbar ------ %zd\n",selectedIndex);
    
    UIViewController *viewController = self.viewControllers[selectedIndex];
    
    if (self.viewControllers.count <= 1) {
        
        [super setSelectedIndex:selectedIndex];
        
        self.lcTabBar.selectedItem.selected = NO;
        self.lcTabBar.selectedItem = self.lcTabBar.tabBarItems[selectedIndex];
        self.lcTabBar.selectedItem.selected = YES;
        
    }else{
        //        if (viewController == self.viewControllers[1]  || viewController == self.viewControllers[3] || viewController == self.viewControllers[4]) {
        if (viewController == self.viewControllers[1]  || viewController == self.viewControllers[2] || viewController == self.viewControllers[3]|| viewController == self.viewControllers[4]) {
            //18-09-05
            
            if (!UserId_New) {
                YPReLoginController *first = [[YPReLoginController alloc]init];
                UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                [self presentViewController:firstNav animated:YES completion:nil];
                
                
            }else{
                [super setSelectedIndex:selectedIndex];
                
                self.lcTabBar.selectedItem.selected = NO;
                self.lcTabBar.selectedItem = self.lcTabBar.tabBarItems[selectedIndex];
                self.lcTabBar.selectedItem.selected = YES;
            }
            
        }else{
            [super setSelectedIndex:selectedIndex];
            
            self.lcTabBar.selectedItem.selected = NO;
            self.lcTabBar.selectedItem = self.lcTabBar.tabBarItems[selectedIndex];
            self.lcTabBar.selectedItem.selected = YES;
        }
    }
    
}

#pragma mark - XXTabBarDelegate Method

- (void)tabBar:(LCTabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to {
    
    NSLog(@"tabbar -didSelectedItemFrom ------ %zd - %zd\n",from,to);
    
    self.selectedIndex = to;
    
    if (self.selectedIndex ==1) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LcTabBarDidClickNotification" object:nil userInfo:nil];
        
    }else{
        
    }
    
}

@end