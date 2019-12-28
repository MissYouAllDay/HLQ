//
//  CXUtils.h
//  GlobeVisa
//
//  Created by 盟仕乐 on 2017/4/11.
//  Copyright © 2017年 MSLiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

#pragma mark - - - - - - - - - - - - -   Block - - - - - - - - - - - - - - - 
/**
 定位信息

 @param cityName   城市名称  比如 区
 @param address    定位地址
 @param detailInfo 详细信息
 @param coreLocation 坐标
 */
typedef void(^LocationBlock)(NSString *cityName,NSString *address,NSDictionary *detailInfo, CLLocationCoordinate2D coreLocation);

#pragma mark - - - - - - - - - - - - -   interface - - - - - - - - - - - - - - -

@protocol CXUtilsDelegate <NSObject>

/**
 相册选择单张图片

 @param editImg 编辑过后的图片
 @param oriImg  原图
 */
- (void)selectPhoto:(UIImage *)editImg withOriImg:(UIImage *)oriImg;

@end

@interface CXUtils : NSObject

/** 代理 */
@property (nonatomic, weak) id<CXUtilsDelegate> delegate;

/** <#mark#> */
@property (nonatomic, assign) CGFloat latitude;
/** <#mark#> */
@property (nonatomic, assign) CGFloat longitude;

/**
 初始化
 */
+ (id)shareCXUtils;



/** 开始定位 */
-(void)startLocation;

/**
 获取城市信息

 @param cityInfo 城市信息回调
 */
- (void)getCityName:(LocationBlock)cityInfo;


+ (MBProgressHUD *)showHUD;

+ (void)hideHUD;

+ (void)showAllTextHUB:(NSString *) alert;

#pragma mark - - - - - - - - - - - - -   日期 - - - - - - - - - - - - - - -

//计算某个时间后的日期
+ (NSDate *)datewithEndDay:(NSString *)dayNUm withStartDate:(NSDate *)startDate;

//计算2个日期之间 相差的天数
+ (NSInteger)daysFromBeginDate:(NSDate *)beginDate endDate:(NSString *)endDate;

//人员类型界面 textview的高度
+ (NSDictionary *)heightofPersonTypeTextViewfwithText:(NSArray *)dataDic;

// 计算人员中 基本信息 的高度
+ (NSDictionary *)heightofBaseInfoTextViewfwithText:(NSArray *)dataDic;

/**
 获取当前时间
 
 @return 当前时间
 */
+ (NSString *)getCurrentDate;


/**
 时间转换
 
 @param miliSeconds 时间
 @return  上午 12:12 下午 12:12      昨天         星期一 星期二 星期三
 */
+ (NSString *)getMessageListDateDisplayString:(long long) miliSeconds;

/**
 时间转换
 
 @param miliSeconds 时间
 @return  上午 12:12 下午 12:12  昨天 12:12       星期一 星期二 星期三
 */
+ (NSString *)getChatListDateDisplayString:(long long) miliSeconds;

#pragma mark - - - - - - - - - - - - -   label计算 - - - - - - - - - - - - - - -
// label 的高度  
/**
 label 宽固定   返回label的高度

 @param text label 的 text
 @param width label 固定的 宽度
 @param font label  的字体大小  UIFont 格式
 @return label 的高度
 */
+ (CGFloat)labelHei:(NSString *)text withWidth:(CGFloat)width withFont:(UIFont *)font;
// labelsize
+ (CGSize)labelSize:(NSMutableAttributedString *)text withWidth:(CGFloat)width withFont:(UIFont *)font;


/** 两端对齐 */
+ (void)changeAlignmentRightandLeft:(UILabel *)label;
/** 输入框提示文本 */
+ (void)changePlaceHolder:(UITextField *)textfield withText:(NSString *)placeholder;


#pragma mark - - - - - - - - - - - - -   图片 - - - - - - - - - - - - - - -

/**
 根据颜色生成图片

 @param color 颜色值
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

// 返回状态栏的高度
+ (CGFloat)statueBarHeight;

/**
 返回用户m默认头像
 */
+ (UIImage *)userLogoDefaImage;

/**
 文字转图片
 
 @param size 图片大小
 @param bgColor 背景颜色
 @param context 文字
 @param font 文字大小
 @param textColor 文字y颜色
 @return 图片
 */
+ (UIImage *)createTextImg:(CGSize)size backColor:(UIColor *)bgColor withText:(NSString *)context withTextFont:(UIFont *)font withTextColor:(UIColor *)textColor ;


/// 渐变颜色 layer
/// @param rect 尺寸
/// @param colors 渐变颜色
/// @param startPoint 开始位置
/// @param endPoint 结束位置
/// @param locations 渐变位置
+ (CAGradientLayer *)gradientLayerWithFrame:(CGRect)rect withColors:(NSArray *)colors withStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint withLocations:(NSArray *)locations;

/// 将16进制颜色 转换为 UICOLOR
/// @param color  16进制颜色
+ (UIColor *)colorWithHexString: (NSString *)color ;

#pragma mark - - - - - - - - - - - - -   相册  相机 - - - - - - - - - - - - - - -

//判断摄像头 权限
+ (BOOL)passportGetIntoCamera:(UIViewController *)viewController;
// 判断相册权限
//+ (BOOL)album:(UIButton*)albumbtn:(UIViewController *)viewController;

// 拨打电话
+ (void)phoneAction:(UIViewController *)viewController withTel:(NSString *)tel ;


#pragma mark - - - - - - - - - - - - -   信息 验证 - - - - - - - - - - - - - - -
//手机号验证
+ (BOOL)checkTelNumber:(NSString *)telNumber;
//邮箱验证
+ (BOOL)checkEmail:(NSString *)email;
//日期验证
+ (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;
//判断是否为纯数字
+ (BOOL)isNum:(NSString *)checkedNumString ;
/** 数据 */
+ (BOOL)isMoney:(NSString *)money ;

/**
 银行卡 认证
 
 @param cardNumber 银行卡
 @return 是否是否正确
 */
+ (BOOL) IsBankCard:(NSString *)cardNumber;

/**
 身份证 检测
 
 @param userID  身份证号
 @return 是否有有效
 */
+ (BOOL)checkUserID:(NSString *)userID;



// - - - - - - - - - - - - - - - - - - - - 弹窗  - - - - - - - - - - - - - - - - - - - - - -
/**
 提示框 只有确定按钮
 
 @param titler  标题
 @param message 提示信息
 @param sure    确定按钮文字  默认为 “确定”
 @param successBlock 确认回调
 @param completion   弹窗之后 回调
 */
+ (void)showAlertSigle:(NSString *)titler withMessage:(NSString *)message withSuccessText:(NSString *)sure withVC:(UIViewController *)vc withSuccessBlock:(void(^)(void))successBlock withCompletion:(void(^)(void))completion;

/**
 提示框 取消 确定 同时存在
 
 @param titler  标题
 @param message 提示信息
 @param cancel  取消按钮文字  默认为 “取消”
 @param sure    确定按钮文字  默认为 “确定”
 @param cancelBlock  取消回调
 @param successBlock 确认回调
 @param completion   弹窗之后 回调
 */
+ (void)showAlertDouble:(NSString *)titler withMessage:(NSString *)message withCancelText:(NSString *)cancel withSuccessText:(NSString *)sure withVC:(UIViewController *)vc withCancelBlock:(void(^)(void))cancelBlock withSuccessBlock:(void(^)(void))successBlock withCompletion:(void(^)(void))completion;

#pragma mark - - - - - - - - - - - - -   相册相机 - - - - - - - - - - - - - - -


/**
 调用c相册

 @param vc 弹出相册的视图
 @return 是否有相册权限
 */
+ (BOOL)openLocationPhoto:(UIViewController *)vc ;

+ (BOOL)openCamera:(UIViewController *)vc;

/**
 摄像机权限

 @param vc 视图
 @return yes：有权限  NO：没有权限
 */
+ (BOOL)checkCameraAnthen:(UIViewController *)vc;


/**
 相册权限

 @param vc 视图
 @return   YES： 有权限  NO：没有权限
 */
+ (BOOL)checkPhotoAuthen:(UIViewController *)vc;


/**
 返回固定大小的图片

 @param image timage
 @param width 固定w宽度
 @param height 固定长度
 @return 图片
 */
+ (UIImage *)resizeUIImage:(UIImage *)image towidth:(CGFloat)width height:(CGFloat)height;

/**
 文件保存路径
 
 @return 用户数据保存路径
 */
+ (NSString *)fileNameWithLocationData;


#pragma mark - - - - - - - - - - - - -   数据库存储 - - - - - - - - - - - - - - - 
/**
 根据存储的信息转为对应的变量类型

 @param string 存储的信息
 */
+ (id)getIDVariableValueTypesWithString:(NSString *)string;

/**
 根据id变量类型转化为对应string以供存储

 @param varialeValue 存入的数据
 @return 字符串类型
 */
+ (NSString *)setIDVariableToString:(id)varialeValue;

//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//字典转json
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 创建文件
 */
- (void)createSysFile;

#pragma mark - - - - - - - - - - - - -   网络请求 - - - - - - - - - - - - - - -
/**
 将GBK 格式的 数据流 转换为 需要的数据
 
 @param responseObject GBK 格式的 数据流
 @return 需要的数据
 */
+ (id)changeGBKdataToUTF8:(NSData *)responseObject ;

// 切指定的角
+ (CAShapeLayer *)maskRoundCornes:(UIView *)view withRadi:(CGSize)size withCorners:(UIRectCorner)corners;

#pragma mark - - - - - - - - - - - - -   距离 - - - - - - - - - - - - - - -
/**
 计算jk距离
 
 @param lat1 坐标1 lat
 @param lat2 坐标2 lat
 @param lng1 坐标1 lng
 @param lng2 坐标2 lng
 @return   k距离
 */
+ (double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2 ;

#pragma mark - - - - - - - - - - - - -   金额计算 - - - - - - - - - - - - - - -
/**
 将分转换为元
 
 @param oriRMB 传入的人民币金额  单位 分
 @return       返回的人民币金额  单位  元
 */
+ (NSString *)changeRMBUnitFTY:(NSString *)oriRMB ;

/**
 将 元 换算 为 分
 
 @param oriRMB 传入的人民币金额    单位  元
 @return       返回的r人民币金额   单位  分
 */
+ (NSString *)changeRMBUnitYTF:(NSString *)oriRMB;

/**
加法
 @param onePrice 金额1
 @param towPrice 金额2
 @return 总金额
 */
+ (NSString *)decimalAddPrice:(NSString *)onePrice withSecondprice:(NSString *)towPrice;

/**
 加法
 @param onePrice 减数
 @param towPrice 被减数
 @return 总金额
 */
+ (NSString *)decimalSubPrice:(NSString *)onePrice withSecondprice:(NSString *)towPrice;

/**
 乘法

 @param oneDec 乘数
 @param twoDec 被乘数
 @return 结果
 */
+ (NSDecimalNumber *)decimalNumber:(NSDecimalNumber *)oneDec ByMultiplyingBy:(NSDecimalNumber *)twoDec;


/**
 除法

 @param oneDec 除数
 @param twoDec 被除数
 @return 结果
 */
+ (NSDecimalNumber *)decimalNumber:(NSDecimalNumber *)oneDec ByDividingBy:(NSDecimalNumber *)twoDec;


/**
 获取html中的imgURL

 @param webString html
 @return imgURL 的数组
 */
+ (NSArray *)getImageurlFromHtml:(NSString *)webString;

/** 阿拉伯数字转汉子数字 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum;

// 输入金额规范
+ (NSString *)checkInputMoney:(NSString *)money;

// 输入的数字规范
+ (NSString *)checkInputNum:(NSString *)member;

// 是否为空。yes 有值。 NO，无值
+(BOOL)haveValue:(id)value;



@end
