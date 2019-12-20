//
//  UIColor+YPColor.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YPColor)

/**
 * HexColor
 */
+ (UIColor *)yp_colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
