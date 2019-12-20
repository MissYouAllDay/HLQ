//
//  HRShareRegisterManager.m
//  HunQingYH
//
//  Created by Dikai on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRShareRegisterManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
@implementation HRShareRegisterManager
- (void)finishLaunchOption:(NSDictionary *)option{
    //
        [ShareSDK registerActivePlatforms:@[
    
    
                                            @(SSDKPlatformTypeWechat),
                                            @(SSDKPlatformTypeQQ),
    //                                        @(SSDKPlatformTypeSinaWeibo),
    
                                            ]
                                 onImport:^(SSDKPlatformType platformType){
                                     switch (platformType){
                                         case SSDKPlatformTypeWechat:
                                             [ShareSDKConnector connectWeChat:[WXApi class]];
                                             break;
                                         case SSDKPlatformTypeQQ:
                                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                             break;
    //                                     case SSDKPlatformTypeSinaWeibo:
    //                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
    //                                         break;
                                         default:
                                             break;
                                     }
                                 }
                          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
    
                              switch (platformType){
                                  case SSDKPlatformTypeSinaWeibo:
                                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
    //                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"1980517958"
    //                                                            appSecret:@"c1775981a62bdf2f71f4b43ed3b025d6"
    //                                                          redirectUri:@"http://www.sharesdk.cn"
    //                                                             authType:SSDKAuthTypeBoth];
    //                                  break;
                                  case SSDKPlatformTypeWechat:
                                      [appInfo SSDKSetupWeChatByAppId:@"wx088a1224a6df0843"
                                                            appSecret:@"17ce666b2471bc480dd435121a0f2446"];
                                      break;
                                  case SSDKPlatformTypeQQ:
                                      [appInfo SSDKSetupQQByAppId:@"1106431085"
                                                           appKey:@"egAN62Xje6SGH2XN"
                                                         authType:SSDKAuthTypeBoth];
                                      break;
    
                                  default:
                                      break;
                              }
                          }];
    
    
    
    
//    [ShareSDK registerApp:@"Your App Key"
//     
//          activePlatforms:@[
//                            @(SSDKPlatformTypeCopy),
//                            @(SSDKPlatformTypeMail),
//                            @(SSDKPlatformTypeSMS),
//                            @(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformSubTypeWechatTimeline),
//                            @(SSDKPlatformSubTypeQQFriend),
//                            @(SSDKPlatformSubTypeQZone)]
//                 onImport:^(SSDKPlatformType platformType)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeWechat:
//                 [ShareSDKConnector connectWeChat:[WXApi class]];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
//             default:
//                 break;
//         }
//     }
//          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
//     {
//         
//         switch (platformType)
//         {
//             case SSDKPlatformTypeSinaWeibo:
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.sharesdk.cn"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
//                 
//             default:
//                 break;
//         }
//     }];
}

@end
