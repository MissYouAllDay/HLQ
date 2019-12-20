//
//  CALayer+YPCALayer.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/21.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CALayer+YPCALayer.h"

@implementation CALayer (YPCALayer)

- (UIImage *)yp_snapshotImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)yp_setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius{
    self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.shadowOpacity = 1;
    self.shouldRasterize = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
