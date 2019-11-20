//
//  RequestPostUploadHelper.h
//  Zr_cy_ios
//
//  Created by zrsoft on 14-9-2.
//  Copyright (c) 2014年 Richard Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestPostUploadHelper : NSObject

/**
 *POST 提交 并可以上传图片目前只支持单张
 */
+ (NSString *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (UIImage *)picFilePath  // IN 上传图片路径
                     picFileName: (NSString *)picFileName;  // IN 上传图片名称
+ (NSString *)postRequestDataWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (NSData *)fileData // IN 上传图片路径
                     picFileName: (NSString *)picFileName;  // IN 上传图片名称
/**
 * 修发图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;
/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;

@end
