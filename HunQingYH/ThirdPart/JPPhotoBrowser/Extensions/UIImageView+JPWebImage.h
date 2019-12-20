//
//  UIImageView+LoadImage.h
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^downloadImageBlock)(UIImage *image);

@interface UIImageView (JPWebImage)

/**
 模仿SDWebImange下载
 
 @param url NSURL图片地址
 @param placeholder 占位图
 */
- (void)jp_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder;

/**
 模仿SDWebImange下载 适合正方形切圆形图片
 
 @param url NSURL图片地址
 @param placeholder 占位图
 */
- (void)jp_setCornerImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder;

/**
 模仿SDWebImange下载 并加入切圆角

 @param url NSURL图片地址
 @param placeholder 占位图
 @param cornerRadius 圆角半径0-imageView的Width/2
 */
- (void)jp_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
              cornerRadius:(CGFloat)cornerRadius;

/**
 下载图片并block返回已下载的图片

 @param url 图片URL
 @param placeholder 占位图
 @param downloadImageBlock block返回已下载的图片
 */
- (void)jp_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
//        downloadImageBlock:(void(^)(UIImage *image)) downloadImageBlock;
        downloadImageBlock:(downloadImageBlock)downloadImageBlock;
@end
