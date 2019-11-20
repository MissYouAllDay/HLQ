//
//  UIImage+UIImage_fixedOrientation.h
//  Coupon
//
//  Created by shanshanxu on 16/4/25.
//  Copyright © 2016年 shanshanxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_fixedOrientation)
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+(NSData *)resetSizeOfImageData:(UIImage *)source_image;
@end
