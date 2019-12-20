//
//  CXDataManager.h
//  HunQingYH
//
//  Created by apple on 2019/9/27.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 后期跟数据相关的零散 功能。可放入此文件 - - - - - - - - - - - - - - - - - -


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXDataManager : NSObject

/**
 保存用户信息

 @param object 用户信息
 */
+ (void)savaUserInfo:(NSDictionary *)object;

/**
 辨别用户身份

 @return 用户身份
 */
+ (NSString *)checkUserProfession:(NSString *)profession;


/**
 隐藏键盘
 */
+ (void)hiddenKeyBoard ;


/**
 判断输入的内容是否是纯数字
 
 @param number 输入的内容
 @return YES：纯数字。NO： 不是纯数字
 */
+ (BOOL) checkNumInputShouldNumber:(NSString *)number;


/**
 判断手机号
 
 @param number 手机号
 @return YES：是手机号。NO：不是手机号
 */
+ (BOOL)checkTelPhoneNum:(NSString *)number;


@end

NS_ASSUME_NONNULL_END
