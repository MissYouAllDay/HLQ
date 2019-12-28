//
//  CommonFileList.h
//  HunQingYH
//
//  Created by apple on 2019/10/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 全局中引用的文件- - - - - - - - - - - - - - - - - - - - - -

#ifndef CommonFileList_h
#define CommonFileList_h


// - - - - - - - - - - - - - - 基础文件- - - - - - - - - - - - - - - - - - - - - -
#import "CXColorList.h"                             // 颜色
#import "CXRequestHTTPList.h"                   // 接口列表
#import "CXSysConfigerList.h"                   // 宏定义


#import "UIButton+CXCustomIcon.h"               // button 图片+文字位置设置 这是个坑
#import "FSCustomButton.h"                      // button 图片+文字位置设置 这也是个坑

#import "CXDataManager.h"                       // 数据管理     ---- 后期跟数据相关的零散 功能。可放入此文件
#import "UIImage+YPGradientImage.h"             // 将渐变色设置为渐变图片
#import "NSString+Check.h"                      // 对输入的内容校验
#import "Masonry.h"                             // 布局
#import "JXCategoryView.h"                      //  联动列表
#import "MJRefresh.h"                           // 下拉刷新


#import "CXBaseViewController.h"                // base vc

#import "FSCustomButton.h"      // 按钮
#import "CXUtils.h"             // 工具类
#import "CXBaseTableView.h"

// MARK: - old

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIBarButtonItem+item.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+YYWebImage.h"
#import "JVFloatLabeledTextField.h"
#import "FMDB.h"
#import "IQKeyboardManager.h"//键盘管理
#import "ZLPhoto.h"//图片选择/展示
#import <AFNetworking/AFNetworking.h>
#import "NetworkTool.h"//网络请求
#import "NSString+Hash.h"//MD5加密
#import "UIView+extension.h"
//#import "ActivityHUDManager.h"

#import "Upload.h"//上传图片
#import "BANetManager.h"//上传图片/视频 - 文件服务器改版
#import "BADataEntity.h"

//#import "SMPagerTabView.h"//切换标签页
//#import "DLProgressHUD.h"
#import "UINavigationController+YPCategory.h"
//#import "MBProgressHUD+WJExtension.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
//弹窗
#import <MMPopupView.h>
#import <MMSheetView.h>
#import "UIView+Badge.h"//任意视图添加角标
#import "EasyShowView.h"//遮罩
//登录
#import "YPReLoginController.h"
#import "YYKit.h"
#import <YYCache.h>

//5-28
#import <VTMagic/VTMagic.h>
//#import "WRNavigationBar.h"
//6.4webview
#import "HRWebViewController.h"

//6-25 高德地图
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

//6-27 登录重做
#import "YPReLoginController.h"
//6.28分享自定义封装
#import "HRShareView.h"

//7-24 shimmer Label闪烁
#import "FBShimmeringView.h"

#import "LCTabBarController.h"

//18-11-07 友盟统计
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>//事件点击统计

//18-11-12 通讯录读取手机号
#import "YPAddressBookTool.h"
//抽屉
#import "UIViewController+CWLateralSlide.h"
#import "SliderMeViewController.h"


#endif /* CommonFileList_h */
