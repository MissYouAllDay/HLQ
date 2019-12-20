//
//  XHLaunchAdManager.m
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 2017/5/3.
//  Copyright © 2017年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  开屏广告初始化

#import "XHLaunchAdManager.h"
#import "XHLaunchAd.h"
//#import "Network.h"
#import "LaunchAdModel.h"
#import "UIViewController+Nav.h"
#import "YPFreeWeddingController.h" //免费办婚礼
//#import "HRYQJHController.h"//邀请好友结婚
#import "HRShareAppViewController.h"//分享APP
#import "HRBaoMIViewController.h"//领爆米花
#import "YPBHAssureController.h"//婚礼担保
//#import "YPBHProjectController.h"//我要出方案
#import "YPKeYuan190514PublishRingController.h"//19-05-19 免费领对戒
#import "HRFAStoreViewController.h"//共享方案
#import "YPEDuBaseController.h"//婚礼返还
#import "LCTabBarController.h"

#import "YPInviteFriendsWedNormalController.h"//18-10-15 邀请结婚-普通
#import "YPInviteFriendsWedVIPController.h"//18-10-15 邀请结婚-VIP
#import "YPGetInvitationProfit.h"//18-10-18 邀请结婚

//5-23 邀请结婚
#import "YPReYQJHController.h"
//6-1 酒店活动
#import "YPBannerHotelActivityController.h"
//7-8 婚假采购节
#import "YPHunJiaJieController.h"
/** 以下连接供测试使用 */

/** 静态图 */
#define imageURL1 @"http://yun.it7090.com/image/XHLaunchAd/pic01.jpg"
#define imageURL2 @"http://yun.it7090.com/image/XHLaunchAd/pic02.jpg"
#define imageURL3 @"http://yun.it7090.com/image/XHLaunchAd/pic03.jpg"
#define imageURL4 @"http://yun.it7090.com/image/XHLaunchAd/pic04.jpg"

/** 动态图 */
#define imageURL5 @"http://yun.it7090.com/image/XHLaunchAd/pic05.gif"
#define imageURL6 @"http://yun.it7090.com/image/XHLaunchAd/pic06.gif"

/** 视频链接 */
#define videoURL1 @"http://yun.it7090.com/video/XHLaunchAd/video01.mp4"
#define videoURL2 @"http://yun.it7090.com/video/XHLaunchAd/video02.mp4"
#define videoURL3 @"http://yun.it7090.com/video/XHLaunchAd/video03.mp4"

#define BOOLFORKEY @"dhGuidePage"

@interface XHLaunchAdManager()<XHLaunchAdDelegate>
/** 广告模型*/
@property(nonatomic,strong)LaunchAdModel  *adLaunchModel;

///18-10-18 邀请结婚模型
@property (nonatomic, strong) YPGetInvitationProfit *profitModel;

@end

@implementation XHLaunchAdManager

+(void)load{
    [self shareManager];
}

+(XHLaunchAdManager *)shareManager{
    static XHLaunchAdManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[XHLaunchAdManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        if ([[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
            [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                //初始化开屏广告
                [self setupXHLaunchAd];
            }];
        }
    }
    return self;
}

-(void)setupXHLaunchAd{
    
    /** 1.图片开屏广告 - 网络数据 */
    [self example01];
    
    //2.******图片开屏广告 - 本地数据******
//    [self example02];
    
    //3.******视频开屏广告 - 网络数据(网络视频只支持缓存OK后下次显示,看效果请二次运行)******
    //[self example03];

    /** 4.视频开屏广告 - 本地数据 */
    //[self example04];
    
    /** 5.如需自定义跳过按钮,请看这个示例 */
    //[self example05];
    
    /** 6.使用默认配置快速初始化,请看下面两个示例 */
    //[self example06];//图片
    //[self example07];//视频
    
    /** 7.如果你想提前批量缓存图片/视频请看下面两个示例 */
    //[self batchDownloadImageAndCache]; //批量下载并缓存图片
    //[self batchDownloadVideoAndCache]; //批量下载并缓存视频
    
}

#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)example01{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    
    
//    //广告数据转模型
//    LaunchAdModel *model = [[LaunchAdModel alloc] init];
//    //配置广告数据
//    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//    //广告停留时间
//    imageAdconfiguration.duration =5.0;
//    //广告frame
//    imageAdconfiguration.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = ADLaunchImageURL;
//    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//    imageAdconfiguration.GIFImageCycleOnce = NO;
//    //缓存机制(仅对网络图片有效)
//    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
//    //图片填充模式
//    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
//    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//    imageAdconfiguration.openModel =@"";
//    //广告显示完成动画
//    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFlipFromLeft;
//    //广告显示完成动画时间
//    imageAdconfiguration.showFinishAnimateTime = 0.8;
//    //跳过按钮类型
//    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//    //后台返回时,是否显示广告
//    imageAdconfiguration.showEnterForeground = NO;
//
//    //图片已缓存 - 显示一个 "已预载" 视图 (可选)
//    if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]]){
//        //设置要添加的自定义视图(可选)
//        imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
//
//    }
//    //显示开屏广告
//    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
    
        
        NSString *url = @"/api/HQOAApi/SoftwarePageStarts";
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"Type"]   = @"2";   //1安卓App地址，2IosApp地址
        [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
            
            if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
                //广告数据转模型
                self.adLaunchModel = [[LaunchAdModel alloc] init];
                self.adLaunchModel.Type =[[object objectForKey:@"Type"]integerValue];
                self.adLaunchModel.content =[object objectForKey:@"HeadImg"];
                self.adLaunchModel.openUrl =[object objectForKey:@"JumpUrl"];
                self.adLaunchModel.duration = 3;//广告启动页启动时间 18-10-25 修改为3s 郝
                if (![self.adLaunchModel.content isEqualToString:@""]) {
                    //配置广告数据
                    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
                    //广告停留时间
                    imageAdconfiguration.duration = _adLaunchModel.duration;
                    //广告frame
                    imageAdconfiguration.frame = CGRectMake(0, 0,ScreenWidth, ScreenHeight);
                    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
                    imageAdconfiguration.imageNameOrURLString = _adLaunchModel.content;
                    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
                    imageAdconfiguration.GIFImageCycleOnce = NO;
                    //缓存机制(仅对网络图片有效)
                    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
                    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
                    //图片填充模式
                    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
                    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
                    imageAdconfiguration.openModel = _adLaunchModel.openUrl;
                    //广告显示完成动画
                    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
                    //广告显示完成动画时间
                    imageAdconfiguration.showFinishAnimateTime = 0.8;
                    //跳过按钮类型
                    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
                    //后台返回时,是否显示广告
                    imageAdconfiguration.showEnterForeground = NO;
                    
                    //图片已缓存 - 显示一个 "已预载" 视图 (可选)
                    if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:_adLaunchModel.content]]){
                        //设置要添加的自定义视图(可选)
                        imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
                        
                    }
                    //显示开屏广告
                    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
                    
                }
               
                
            }else{
                
               
                
            }
            
        } Failure:^(NSError *error) {
           
            
        }];

    

    
    
    
    //广告数据请求
//    [Network getLaunchAdImageDataSuccess:^(NSDictionary * response) {
//        NSLog(@"广告数据 = %@",response);
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        //配置广告数据
//        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//        //广告停留时间
//        imageAdconfiguration.duration = model.duration;
//        //广告frame
//        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
//        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//        imageAdconfiguration.imageNameOrURLString = model.content;
//        //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//        imageAdconfiguration.GIFImageCycleOnce = NO;
//        //缓存机制(仅对网络图片有效)
//        //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
//        //图片填充模式
//        imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
//        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        imageAdconfiguration.openModel = model.openUrl;
//        //广告显示完成动画
//        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
//        //广告显示完成动画时间
//        imageAdconfiguration.showFinishAnimateTime = 0.8;
//        //跳过按钮类型
//        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//        //后台返回时,是否显示广告
//        imageAdconfiguration.showEnterForeground = NO;
//
//        //图片已缓存 - 显示一个 "已预载" 视图 (可选)
//        if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]]){
//            //设置要添加的自定义视图(可选)
//            imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
//
//        }
//        //显示开屏广告
//        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//
//    } failure:^(NSError *error) {
//    }];
//
}
/*
#pragma mark - 图片开屏广告-本地数据-示例
//图片开屏广告 - 本地数据
-(void)example02{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image2.jpg";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFlipFromLeft;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeRoundProgressText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
}

#pragma mark - 视频开屏广告-网络数据-示例
//视频开屏广告 - 网络数据
-(void)example03{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    
    //广告数据请求
    [Network getLaunchAdVideoDataSuccess:^(NSDictionary * response) {
        
        NSLog(@"广告数据 = %@",response);
        
        //广告数据转模型
        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
        
        //配置广告数据
        XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
        //广告停留时间
        videoAdconfiguration.duration = model.duration;
        //广告frame
        videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //广告视频URLString/或本地视频名(请带上后缀)
        //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
        videoAdconfiguration.videoNameOrURLString = model.content;
        //是否关闭音频
        videoAdconfiguration.muted = NO;
        //视频缩放模式
        videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //是否只循环播放一次
        videoAdconfiguration.videoCycleOnce = NO;
        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
        videoAdconfiguration.openModel = model.openUrl;
        //广告显示完成动画
        videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        //广告显示完成动画时间
        videoAdconfiguration.showFinishAnimateTime = 0.8;
        //后台返回时,是否显示广告
        videoAdconfiguration.showEnterForeground = NO;
        //跳过按钮类型
        videoAdconfiguration.skipButtonType = SkipTypeTimeText;
        //视频已缓存 - 显示一个 "已预载" 视图 (可选)
        if([XHLaunchAd checkVideoInCacheWithURL:[NSURL URLWithString:model.content]]){
            //设置要添加的自定义视图(可选)
            videoAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
            
        }
        
        [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 视频开屏广告-本地数据-示例
//视频开屏广告 - 本地数据
-(void)example04{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 5;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"video0.mp4";
    //是否关闭音频
    videoAdconfiguration.muted = NO;
    //视频填充模式
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = NO;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel =  @"http://www.it7090.com";
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeRoundProgressTime;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //videoAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
    
}
#pragma mark - 自定义跳过按钮-示例
-(void)example05{
    
    //注意:
    //1.自定义跳过按钮很简单,configuration有一个customSkipView属性.
    //2.自定义一个跳过的view 赋值给configuration.customSkipView属性便可替换默认跳过按钮,如下:
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/1242*1786);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image11.gif";
    //缓存机制(仅对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate = ShowFinishAnimateFlipFromLeft;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
    //设置要添加的子视图(可选)
    imageAdconfiguration.subViews = [self launchAdSubViews];
    
    //start********************自定义跳过按钮**************************
    imageAdconfiguration.customSkipView = [self customSkipView];
    //********************自定义跳过按钮*****************************end
    
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
}
*/
#pragma mark - 使用默认配置快速初始化 - 示例
/**
 *  图片
 */
-(void)example06{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //使用默认配置
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = imageURL3;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

/**
 *  视频
 */
-(void)example07{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //使用默认配置
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration defaultConfiguration];
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"video0.mp4";
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = @"http://www.it7090.com";
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}

#pragma mark - 批量下载并缓存
/**
 *  批量下载并缓存图片
 */
-(void)batchDownloadImageAndCache{
    
    [XHLaunchAd downLoadImageAndCacheWithURLArray:@[[NSURL URLWithString:imageURL1],[NSURL URLWithString:imageURL2],[NSURL URLWithString:imageURL3],[NSURL URLWithString:imageURL4],[NSURL URLWithString:imageURL5]] completed:^(NSArray * _Nonnull completedArray) {
        
        /** 打印批量下载缓存结果 */
        
        //url:图片的url字符串,
        //result:0表示该图片下载失败,1表示该图片下载并缓存完成或本地缓存中已有该图片
        NSLog(@"批量下载缓存图片结果 = %@" ,completedArray);
    }];
}

/**
 *  批量下载并缓存视频
 */
-(void)batchDownloadVideoAndCache{
    
    [XHLaunchAd downLoadVideoAndCacheWithURLArray:@[[NSURL URLWithString:videoURL1],[NSURL URLWithString:videoURL2],[NSURL URLWithString:videoURL3]] completed:^(NSArray * _Nonnull completedArray) {
        
        /** 打印批量下载缓存结果 */
        
        //url:视频的url字符串,
        //result:0表示该视频下载失败,1表示该视频下载并缓存完成或本地缓存中已有该视频
        NSLog(@"批量下载缓存视频结果 = %@" ,completedArray);
        
    }];
    
}

#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView{
    
    CGFloat y = XH_IPHONEX ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor =[UIColor clearColor];
//    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

-(NSArray<UIView *> *)launchAdSubViews{
    
    CGFloat y = XH_IPHONEX ? 54 : 30;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-170, y, 60, 30)];
    label.text  = @"subViews";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - customSkipView
//自定义跳过按钮
-(UIView *)customSkipView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    CGFloat y = XH_IPHONEX ? 54 : 30;
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,y, 85, 30);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//跳过按钮点击事件
-(void)skipAction{
    
    //移除广告
    [XHLaunchAd removeAndAnimated:YES];
}

#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",(long)duration] forState:UIControlStateNormal];
}

#pragma mark - XHLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    
    
    if (_adLaunchModel.Type ==0) {
        [self openWebViewWithUrlStr:self.adLaunchModel.openUrl];
    }else{
        [self openLocalPage];
        
    }
    
    
    
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
//     if(openModel==nil) return;
//    
//    YPReHomeWebViewController *VC = [[YPReHomeWebViewController alloc] init];
//    NSString *urlString = (NSString *)openModel;
//    VC.url = urlString;
    //此处不要直接取keyWindow
//    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
//    [rootVC.myNavigationController pushViewController:VC animated:YES];
    
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  XHLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}

/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL{
    
    NSLog(@"video下载/加载完成 path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current{
    
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
}

/**
 *  广告显示完成
 */
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    
    NSLog(@"广告显示完成");
}

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理(注意:实现此方法后,图片缓存将不受XHLaunchAd管理)
 
 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url
//{
//    [launchAdImageView sd_setImageWithURL:url];
//
//}
-(void)openWebViewWithUrlStr:(NSString *)urlStr{
    //2.在webview中打开
    HRWebViewController *webVC =[HRWebViewController new];
    webVC.webUrl =urlStr;
    webVC.isShareBtn =YES;
    webVC.shareURL =urlStr;
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.myNavigationController pushViewController:webVC animated:YES];
}
-(void)openLocalPage{

    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
  
    if ([_adLaunchModel.openUrl isEqualToString:@"YQBHL"]) {
        //邀请好友办婚礼
//        HRYQJHController *openVC = [[HRYQJHController alloc]init];
//        openVC.hidesBottomBarWhenPushed = YES;
//        [rootVC.myNavigationController pushViewController:openVC animated:YES];
        
//        //5-23
//        YPReYQJHController *openVC = [[YPReYQJHController alloc]init];
//        openVC.hidesBottomBarWhenPushed = YES;
//        [rootVC.myNavigationController pushViewController:openVC animated:YES];
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [rootVC presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            //18-10-15 邀请结婚
            [self GetInvitationProfit];
        }
        
    }else if([_adLaunchModel.openUrl isEqualToString:@"FreeBHL"]){
        //免费办婚礼
        YPFreeWeddingController *openVC = [[YPFreeWeddingController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
       [rootVC.myNavigationController pushViewController:openVC animated:YES];

    }else if([_adLaunchModel.openUrl isEqualToString:@"ShareApp"]){
        //分享APP赚现金
        HRShareAppViewController *openVC = [[HRShareAppViewController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
       [rootVC.myNavigationController pushViewController:openVC animated:YES];
    }else if([_adLaunchModel.openUrl isEqualToString:@"FreeBMH"]){
        //免费领爆米花
        HRBaoMIViewController *openVC = [[HRBaoMIViewController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
       [rootVC.myNavigationController pushViewController:openVC animated:YES];
    }else if([_adLaunchModel.openUrl isEqualToString:@"HLDB"]){
        //婚礼担保
        YPBHAssureController *openVC = [[YPBHAssureController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
        [rootVC.myNavigationController pushViewController:openVC animated:YES];
    }else if([_adLaunchModel.openUrl isEqualToString:@"ChuFA"]){
        //我要出方案
        YPKeYuan190514PublishRingController *openVC = [[YPKeYuan190514PublishRingController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
        [rootVC.myNavigationController pushViewController:openVC animated:YES];
    }else if([_adLaunchModel.openUrl isEqualToString:@"GongxianFA"]){
        //共享方案
        HRFAStoreViewController *openVC = [[HRFAStoreViewController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
       [rootVC.myNavigationController pushViewController:openVC animated:YES];
    }else if([_adLaunchModel.openUrl isEqualToString:@"HunLiFH"]){
        //婚礼返还
        YPEDuBaseController *openVC = [[YPEDuBaseController alloc]init];
        openVC.hidesBottomBarWhenPushed = YES;
//        openVC.ActivityId = act_hunLiFanHuan;//18-09-17 添加
        openVC.typeStr = @"1";//婚礼返还
       [rootVC.myNavigationController pushViewController:openVC animated:YES];
    }else if ([_adLaunchModel.openUrl isEqualToString:@"JDHD"]){//酒店活动
        
        YPBannerHotelActivityController *hotelAct = [[YPBannerHotelActivityController alloc]init];
        hotelAct.hidesBottomBarWhenPushed = YES;
        [rootVC.navigationController pushViewController:hotelAct animated:YES];
        
    }else if ([_adLaunchModel.openUrl isEqualToString:@"HJCGJ"]){//婚假采购节
        YPHunJiaJieController *jieVC = [YPHunJiaJieController new];
        jieVC.hidesBottomBarWhenPushed =YES;
        [rootVC.navigationController pushViewController:jieVC animated:YES];
    }
    else{

    }

}

#pragma mark 获取邀请收益 18-10-18 邀请结婚
- (void)GetInvitationProfit{
    
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    NSString *url = @"/api/HQOAApi/GetInvitationProfit";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.profitModel.RefereeStatus = [object objectForKey:@"RefereeStatus"];
            self.profitModel.TopBanner = [object objectForKey:@"TopBanner"];
            self.profitModel.EndBanner = [object objectForKey:@"EndBanner"];
            self.profitModel.Money = [object objectForKey:@"Money"];
            
            if (self.profitModel.RefereeStatus.integerValue == 0) {//0普通用户,1VIP
                //普通
                YPInviteFriendsWedNormalController *yqjh = [[YPInviteFriendsWedNormalController alloc]init];
                yqjh.profitModel = self.profitModel;
                yqjh.hidesBottomBarWhenPushed = YES;
                [rootVC.navigationController pushViewController:yqjh animated:YES];
                
            }else if (self.profitModel.RefereeStatus.integerValue == 1){
                //VIP
                YPInviteFriendsWedVIPController *yqjh = [[YPInviteFriendsWedVIPController alloc]init];
                yqjh.profitModel = self.profitModel;
                yqjh.hidesBottomBarWhenPushed = YES;
                [rootVC.navigationController pushViewController:yqjh animated:YES];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

- (YPGetInvitationProfit *)profitModel{
    if (!_profitModel) {
        _profitModel = [[YPGetInvitationProfit alloc]init];
    }
    return _profitModel;
}

@end
