//
//  UIColor+YPColor.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "UIColor+YPColor.h"

@implementation UIColor (YPColor)

+ (UIColor *)yp_colorWithHexString:(NSString *)color{
    unsigned int r,g,b;
    [[NSScanner scannerWithString:[color substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&r];
    [[NSScanner scannerWithString:[color substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&g];
    [[NSScanner scannerWithString:[color substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&b];
    return [UIColor colorWithRed:((CGFloat) r/255.0f) green:((CGFloat) g/255.0f) blue:((CGFloat) b/255.0f) alpha:1.0f];
}

@end
