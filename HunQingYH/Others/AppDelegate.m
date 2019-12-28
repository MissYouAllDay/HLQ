//
//  AppDelegate.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"
#import "YPReLoginController.h"

//shareSDK
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
////新浪微博SDK头文件<
//#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”

#import "HRShareRegisterManager.h"
#import "DHGuidePageHUD.h"//引导页
#import "VersionManager.h" //版本检测更新
#import "HRCodeScanningVC.h"
#import "HRNavigationController.h"
#import "YPLaunchMovieController.h"//视频引导页
#import "XHLaunchAdManager.h"
#import "TabBarVC.h"
// IPHONE_4S
#define IS_3_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] \
? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)\
: NO)
// IPHONE_5
#define IS_4_0 ([UIScreen instancesRespondToSelector:@selector(currentMode)] \
? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)\
: NO)
// IPHONE_6
#define IS_4_7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] \
? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)\
: NO)
// IPHONE_6_PLUS
#define IS_IPHONE_5_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define AMapKey @"a31973e60a0640164fa1cf55e0eb36eb"
#define BundleId [NSBundle mainBundle].bundleIdentifier

#define UMAnalyticsKey @"5be14590b465f5d4e60000df"

@interface AppDelegate ()
@property (nonatomic, strong) UIApplicationShortcutItem *currentShortItem;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BOOL result = YES;
    [self setEasyShowView];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    
//    // 6-25 高德地图
    [AMapServices sharedServices].apiKey = AMapKey;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    TabBarVC *tabBarC = [[TabBarVC alloc]init];
    self.window.rootViewController = tabBarC;
    
    [self.window makeKeyAndVisible];
    
//    [self createYinDao];
    
    //18-11-07 友盟统计
    [self setUMAnalytics];
    
//    [self shareSDK];

    HRShareRegisterManager *registerManager = [[HRShareRegisterManager alloc] init];
    [registerManager finishLaunchOption:launchOptions];
    //3dtouch
    //系统版本适配
    if(IOS_VERSION < 9.0) return result;
    //判断是否是从shortitem启动的程序
    if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"]) {
        _currentShortItem = launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"];
        //这个返回值很重要、返回no，不会再调用performActionForShortcutItem这个回调方法
        result = NO;
    }
    
    //判断是否已经创建了shortitem、
    NSArray *items = [UIApplication sharedApplication].shortcutItems;
    if (items.count == 0) {
        [self createShortIcon];
    }
    return result;
}



#pragma mark - EasyShowView
- (void)setEasyShowView{
    //hud设置
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    
    //在展示消息的时候，界面上是否可以事件。默认为YES，如果你想在展示消息的时候不让用户有手势交互，可设为NO
    options.textSuperViewReceiveEvent = NO ;
    
    //显示/隐藏的动画形式。有无动画，渐变，抖动，三种样式。
    options.textAnimationType = TextAnimationTypeFade ;
    
    //提示框所在的位置。有上，中，下，状态栏上，导航条上，五种选择。
    options.textStatusType = ShowTextStatusTypeMidden ;
    //转圈加载框 ，可修改
    options.lodingShowType =LodingShowTypeTurnAroundLeft;
    
    //文字大小
    options.textTitleFount = [UIFont systemFontOfSize:15] ;
    //文字颜色
    options.textTitleColor = [UIColor blackColor] ;
    //背景颜色
    options.textBackGroundColor = [UIColor whiteColor];
    //阴影颜色。(为clearcolor的时候不显示阴影)
    options.textShadowColor = MainColor;
}

#pragma mark - 友盟统计
- (void)setUMAnalytics{
    //18-11-07 友盟统计
    [UMConfigure setEncryptEnabled:YES];
//    [UMConfigure setLogEnabled:YES];//调试时为YES,上架需关闭
    [UMConfigure initWithAppkey:UMAnalyticsKey channel:@"App Store"];
    
}

-(void)createShortIcon{
    //    NSString *bundleIdentifier = BundleId;[NSBundle mainBundle].bundleIdentifier
    
    UIApplicationShortcutIcon *shortIcon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCapturePhoto];
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.First", BundleId] localizedTitle:@"扫一扫" localizedSubtitle:nil icon:shortIcon1 userInfo:nil];
    
//    UIApplicationShortcutIcon *shortIcon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
//    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:[NSString stringWithFormat:@"%@.Second", BundleId] localizedTitle:@"扫一扫" localizedSubtitle:nil icon:shortIcon2 userInfo:nil];
    
    [[UIApplication sharedApplication] setShortcutItems:@[shortItem1]];
}
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //    _count--;
    [self handleItem:shortcutItem];
}

-(void)handleItem:(UIApplicationShortcutItem *)shortItem{

    //处理shortitem事件
    if ([shortItem.type isEqualToString:[NSString stringWithFormat:@"%@.First", BundleId]]) {
        NSLog(@"First Item---");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TOScanVC" object:@"TOScanVC"];
    }
//    else if ([shortItem.type isEqualToString:[NSString stringWithFormat:@"%@.Second", BundleId]]){
//        NSLog(@"Second Item---");
//    }
   
}



-(void)createYinDao{
    // 设置APP引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
//        [self setStaticGuidePage];
        
        // 动态引导页
        // [self setDynamicGuidePage];
        
        // 视频引导页
//        [self setVideoGuidePage];
//        NSLog(@"第一次进入");
    
        //19-06-02 引导去掉
//        YPLaunchMovieController *movie = [[YPLaunchMovieController alloc]init];
//        movie.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Video_Onboard_compressed" ofType:@"mp4"]];//
//        LCTabBarController *tabBarC = [[LCTabBarController alloc]init];
//        movie.VC = tabBarC;
//        self.window.rootViewController = movie;
    
    }else{
        NSLog(@"不是第一次");
    }
  
}

#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray ;
    if (IS_4_7) {
        NSLog(@"4.7寸");
           imageNameArray = @[@"47R01.png",@"47R02.png",@"47R03.png"];
    }else if (IS_4_0) {
        NSLog(@"4寸");
        imageNameArray = @[@"4R01.png",@"4R02.png",@"4R03.png"];
    }else if (IS_IPHONE_5_4) {
        NSLog(@"5.4寸");
        imageNameArray = @[@"55R01.png",@"55R02.png",@"55R03.png"];
    }else{
        NSLog(@"X");
        imageNameArray = @[@"X01.png",@"X02.png",@"X03.png"];
    }

    // 创建并添加引导页
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.frame imageNameArray:imageNameArray buttonIsHidden:YES];
      guidePage.slideInto = YES;
    [self.window addSubview:guidePage];
  
   
}

//#pragma mark - 设置APP动态图片引导页
//- (void)setDynamicGuidePage {
//    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
//    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
//    guidePage.slideInto = YES;
//    [self.navigationController.view addSubview:guidePage];
//}
//

#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Video_Onboard_compressed" ofType:@"mp4"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.bounds videoURL:videoURL];
    [self.window addSubview:guidePage];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [VersionManager checkVerSion]; //检测app版本
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
+(AppDelegate *)shareAppDelegate{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}
#pragma mark --------微信-------
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    // 跳转到URL scheme中配置的地址
    //NSLog(@"跳转到URL scheme中配置的地址-->%@",url);
    return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
}

//支付成功时调用，回到第三方应用中
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    //微信
    if ([url.scheme isEqualToString:@"wx088a1224a6df0843"])
    {
        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    return YES;
}
#pragma mark - 微信支付回调
- (void)onResp:(BaseResp *)resp
{
    //    支付结果回调
    if([resp isKindOfClass:[PayResp class]]){
        
        switch (resp.errCode) {
            case WXSuccess:{
                
                //支付返回结果，实际支付结果需要去自己的服务器端查询
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default:{
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}


@end
