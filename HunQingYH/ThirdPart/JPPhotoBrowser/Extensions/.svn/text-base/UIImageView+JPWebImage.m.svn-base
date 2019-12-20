//
//  UIImageView+LoadImage.m
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "UIImageView+JPWebImage.h"


@implementation UIImageView (JPWebImage)

- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self jp_setImageWithURL:url placeholderImage:placeholder cornerRadius:0];
}

- (void)jp_setCornerImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self jp_setImageWithURL:url placeholderImage:placeholder cornerRadius:self.bounds.size.width/2.0];
}

- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cornerRadius:(CGFloat)cornerRadius {
    
    if (!url){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JPDownloadImageCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if(!isDirExist){
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件出错");
            return;
        }
    }
    NSString *urlString = [url absoluteString];
    NSString *imageName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *pathString = [[path stringByAppendingString:@"/"] stringByAppendingString:imageName];
    NSData *saveData = [NSData dataWithContentsOfFile:pathString];
    UIImage *saveImage = placeholder;
    //占位图
    self.image = saveImage;
    //本地缓存
    if (saveData) {
        saveImage = [UIImage imageWithData:saveData];
        //不做剪切处理
        self.image = saveImage;

        return;
    }
    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建会话请求
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:pathString] error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData *saveData = [NSData dataWithContentsOfFile:pathString];
            UIImage *saveImage = placeholder;
            if (saveData) {
                saveImage = [UIImage imageWithData:saveData];
            }
            //不做剪切处理
            self.image = saveImage;
        });
    }];
    //发送请求
    [downTask resume];
}

- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder downloadImageBlock:(downloadImageBlock)downloadImageBlock {
    
    if (!url){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JPDownloadImageCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if(!isDirExist){
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件出错");
            return;
        }
    }
    NSString *urlString = [url absoluteString];
    NSString *imageName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *pathString = [[path stringByAppendingString:@"/"] stringByAppendingString:imageName];
    NSData *saveData = [NSData dataWithContentsOfFile:pathString];
    UIImage *saveImage = placeholder;
    //占位图
    self.image = saveImage;
    //本地缓存
    if (saveData) {
        saveImage = [UIImage imageWithData:saveData];
        //不做剪切处理
        self.image = saveImage;
        if (downloadImageBlock) {
            downloadImageBlock(saveImage);
        }

        return;
    }
    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建会话请求
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:pathString] error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData *saveData = [NSData dataWithContentsOfFile:pathString];
            UIImage *saveImage = placeholder;
            if (saveData) {
                saveImage = [UIImage imageWithData:saveData];
            }
            //不做剪切处理
            self.image = saveImage;
            if (downloadImageBlock) {
                downloadImageBlock(saveImage);
            }
        });
    }];
    //发送请求
    [downTask resume];

}

@end
