//
//  HRNavigationController.m
//  MEMCoupon
//
//  Created by DiKai on 16/7/23.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import "HRNavigationController.h"
@interface HRNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HRNavigationController
+ (void)load{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [navBar setTitleTextAttributes:attrs];
    
    //navBar.backgroundColor = TGColor(243, 69, 102);
    //[navBar setTranslucent:NO];
    
    CGSize imageSize =CGSizeMake(320,NAVIGATION_BAR_HEIGHT);
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    [WhiteColor set];//1-10 修改NavigationColor
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [navBar setBackgroundImage:pressedColorImg forBarMetrics:UIBarMetricsDefault];//用Default
    
    //[navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];//用Default
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    itemDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];
    
    NSMutableDictionary *itemDisableDict = [NSMutableDictionary dictionary];
    itemDisableDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisableDict  forState:UIControlStateDisabled];
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)viewDidLoad{
    [super viewDidLoad];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navBarHairlineImageView.hidden = YES;
//    self.navigationBar.barTintColor = MainColor;
//    self.navigationBar.tintColor=[UIColor whiteColor];
//
//    self.navigationBar.translucent = YES;
//   
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}
//消除方法警告
-(void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
    
}

// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    return self.childViewControllers.count > 1;
    return NO;
}

/**
 *  拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {//如果push进来的不是第一个控制器
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"返回B"] highImage:[UIImage imageNamed:@"返回B"]  target:self action:@selector(back) title:@""];
    }
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
 
   
    [super pushViewController:viewController animated:animated];
}


-(void)back{
    [self popViewControllerAnimated:YES];
}
@end
