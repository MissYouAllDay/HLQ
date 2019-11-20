//
//  NSString+YPString.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YPString)

/**
 * size
 */
- (CGSize)yp_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
/**
 * width
 */
- (CGFloat)yp_widthForFont:(UIFont *)font;

/**
 * height
 */
- (CGFloat)yp_heightForFont:(UIFont *)font width:(CGFloat)width;

#pragma mark - 金额格式化
/**
 * 金额格式化
 */
- (NSString *)yp_moneyFormat:(NSString *)money;
/**
 * 三位数字
 */
- (NSString *)yp_stringFormatToThreeBit:(NSString *)string;
/**
 * 浮点类型
 */
- (NSString *)yp_formatDecimalNumber:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
