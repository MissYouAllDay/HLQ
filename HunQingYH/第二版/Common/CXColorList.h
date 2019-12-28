//
//  ColorList.h
//  HunQingYH
//
//  Created by apple on 2019/10/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - 字体 + 颜色 配置- - - - - - - - - - - - - - - - - - - - - -
#ifndef ColorList_h
#define ColorList_h

#pragma mark - - - - - - - - - - - - - - 颜色- - - - - - - - - - - - - - - - - - - - - -

// 通用
#define RGB(x,y,z) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1]
#define RGBS(x) [UIColor colorWithRed:x/255.0f green:x/255.0f blue:x/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 其他
#define NavBarColor RGB(237, 66, 87)
#define CHJ_bgColor  RGB(242, 242, 242)
#define MainColor RGB(250, 47, 113)
#define TextColor RGB(252, 107, 113)
#define TextNormalColor RGB(116, 118, 126)
#define TextSelectColor RGB(255, 68, 79)
#define HuiPinkColor RGB(255, 63, 72)
#define SortMenuFontColor  RGBS(114)
#define BiaoTiColor RGBS(156)
#define DarkBiaoTiColor RGBS(59)
#define LoginBtnColor RGB(27,162,230)
#define kBaseLine(a) (CGFloat)a * ScreenWidth / 375.0
#define CHJ_RedColor RGB(250, 80, 120)
#define LineColor RGB(224,224,224)


//颜色
#define BlackColor   [UIColor blackColor]
#define WhiteColor   [UIColor whiteColor]
#define LightGrayColor     [UIColor lightGrayColor]
#define GrayColor          [UIColor grayColor]
#define ClearColor [UIColor clearColor]



#pragma mark- - - - - - - - - - - - - - 字体 - - - - - - - - - - - - - - - - - - - - - -
// 通用
#define Font(a)     [UIFont systemFontOfSize:a]
#define FontW(a,b)  [UIFont systemFontOfSize:a weight:b]

//字号
#define kFont(s)        [UIFont systemFontOfSize:(s)]
#define kBiggistFont    kFont(20.0)
#define kBigFont        kFont(17.0)
#define kNormalFont     kFont(15.0)
#define kSmallFont      kFont(13.0)
#define kMostSmallFont  kFont(11.0)



#pragma mark - - - - - - - - - - - - - - 距离- - - - - - - - - - - - - - - - - - - - - -

#define ScreenWidth  (int)[[UIScreen mainScreen] bounds].size.width
#define ScreenHeight (int )[[UIScreen mainScreen] bounds].size.height

// 出去导航栏 - 底部安全距离
#define ScreenContentHeight (int)(ScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT)

//基于宽度 375 的屏幕计算 长度
#define Line375(a)  ([UIScreen mainScreen].bounds.size.width  *  a) / 375.f

//基于高度 667 的屏幕计算 高度
#define Line667(a)  ([UIScreen mainScreen].bounds.size.height *  a) / 667.f

// 缩放比例
#define ScreenScale [UIScreen mainScreen].bounds.size.width / 375.f

#define TabBarHeight 50

//#define RealHeight(value) ((value) / 667.0f * [UIScreen mainScreen].bounds.size.height)
//#define RealWidth(value)  ((value) / 375.0f * [UIScreen mainScreen].bounds.size.wi

#define STAUSBARHEI  ([UIApplication sharedApplication].statusBarFrame.size.height)

#define iPhoneX (STAUSBARHEI != 20.f)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)




#endif /* ColorList_h */
