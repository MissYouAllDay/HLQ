//
//  NSString+Check.h
//  VideoBook
//
//  Created by clq on 14-4-2.
//  Copyright (c) 2014年 HEXC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

+(BOOL)validatePhoneNumInput:(NSString*)phoneNum;

+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL)validateNumber:(NSString*)number;

+ (BOOL)validateIdentityCard:(NSString *)identityCard;

+ (NSString*)stringFormatWithNull:(NSString *)str;

+ (BOOL)isChinese:(NSString*)str;//判断是否是纯汉字

+ (BOOL)includeChinese:(NSString*)str;//判断是否含有汉字

@end
