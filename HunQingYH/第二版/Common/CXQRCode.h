//
//  CXQRCode.h
//  HuanXinDemo
//
//  Created by mac on 01/9/13.
//  Copyright © 2018年 HuaTingAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXQRCode : NSObject

#pragma mark - 生成条形码
//生成最原始的条形码
+ (CIImage *)barcodeImageWithContent:(NSString *)content;

//改变条形码尺寸大小
+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size;


+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(NSInteger)blue;


//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content;

//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size;

//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(NSInteger)blue;

#pragma mark - 生成二维码
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(NSInteger)blue;

@end
