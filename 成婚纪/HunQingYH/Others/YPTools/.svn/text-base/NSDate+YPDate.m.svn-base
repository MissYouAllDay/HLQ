//
//  NSDate+YPDate.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "NSDate+YPDate.h"

@implementation NSDate (YPDate)

- (NSString *)yp_stringWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)yp_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    if(!timeZone) [formatter setDateFormat:format];
    if(!locale) [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

@end
