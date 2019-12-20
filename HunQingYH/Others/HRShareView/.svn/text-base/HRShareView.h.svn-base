//
//  HRShareView.h
//  HunQingYH
//
//  Created by Dikai on 2018/6/28.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
typedef NS_ENUM(NSInteger,ShareType) {
    ShareTypeSocial = 0, //社交分享
    ShareTypeSysterm     //系统
};
//typedef NS_ENUM(NSUInteger, SSDKResponseState){
//    
//};
typedef void(^ShareResultBlock)(SSDKResponseState state,SSDKPlatformType type );

@interface HRShareView : UIView

@property (copy ,nonatomic) ShareResultBlock shareResultBlock;
/**
 *  分享
 *
 *  @param content     @{@"text":@"",@"image":@[],@"url":@""}
 *  @param resultBlock 结果
 */
+ (void)showShareViewWithPublishContent:(id)content
                                 Result:(ShareResultBlock)resultBlock;
/**
 *  分享
 *
 *  @param content     @{@"text":@"",@"image":@[],@"url":@""}
 *  @param resultBlock 结果
 */
- (void)initPublishContent:(id)content
                    Result:(ShareResultBlock)resultBlock;

@end
