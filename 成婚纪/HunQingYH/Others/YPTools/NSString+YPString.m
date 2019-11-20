//
//  NSString+YPString.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "NSString+YPString.h"

@implementation NSString (YPString)

- (CGSize)yp_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:13];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil];
        result =  rect.size;
    }else{
        result = [self sizeForFont:font size:size mode:lineBreakMode];
    }
    return result;
}

- (CGFloat)yp_widthForFont:(UIFont *)font{
    CGSize size = [self yp_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)yp_heightForFont:(UIFont *)font width:(CGFloat)width{
    CGSize size = [self yp_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (NSString *)yp_moneyFormat:(NSString *)money{
    if (!money || money.length == 0) {
        return money;
    }
    
    BOOL hasPoint = NO;
    if ([money rangeOfString:@"."].length > 0) {
        hasPoint = YES;
    }
    
    NSMutableString *pointMoney = [NSMutableString stringWithString:money];
    if (hasPoint == NO) {
        [pointMoney appendString:@".00"];
    }
    
    NSArray *moneys = [pointMoney componentsSeparatedByString:@"."];
    if (moneys.count > 2) {
        return pointMoney;
    }else if (moneys.count == 1){
        return [NSString stringWithFormat:@"%@.00",moneys[0]];
    }else {
        //整数部分 每隔三位加一个逗号
        NSString *frontMoney = [self yp_stringFormatToThreeBit:moneys[0]];
        if ([frontMoney isEqualToString:@""]) {
            frontMoney = @"0";
        }
        NSString *backMoney = moneys[1];
        if (backMoney.length == 1) {
            return [NSString stringWithFormat:@"%@.%@0",frontMoney,backMoney];
        }else if (backMoney.length > 2){
            return [NSString stringWithFormat:@"%@.%@",frontMoney,[backMoney substringToIndex:2]];
        }else{
            return [NSString stringWithFormat:@"%@.%@",frontMoney,backMoney];
        }
    }
}

- (NSString *)yp_stringFormatToThreeBit:(NSString *)string{
    NSString *tempString = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *mStr = [NSMutableString stringWithString:tempString];
    NSInteger n = 2;
    for (NSInteger i = tempString.length - 3; i > 0; i --) {
        //每隔三位 插入一个逗号
        n ++;
        if (n == 3) {
            [mStr insertString:@"," atIndex:i];
            n = 0;
        }
    }
    return mStr;
}

- (NSString *)yp_formatDecimalNumber:(NSString *)string{
    if (!string || string.length == 0) {
        return string;
    }
    NSNumber *number = @([string doubleValue]);
    NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc]init];
    numberFormat.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormat.positiveFormat = @"###,##0.00";
    NSString *amount = [numberFormat stringFromNumber:number];
    return amount;
}

@end
