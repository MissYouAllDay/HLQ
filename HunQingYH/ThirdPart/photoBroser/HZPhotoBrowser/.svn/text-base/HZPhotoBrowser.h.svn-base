//
//  HZPhotoBrowser.h
//  photoBrowser
//
//  Created by huangzhenyu on 15/6/23.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZPhotoBrowserView.h"

@class HZPhotoBrowser;

typedef void(^YPPhotoDeleteBlock)(NSInteger index);
typedef void(^YPPhotoRejectBlock)(NSInteger index);

@protocol HZPhotoBrowserDelegate <NSObject>

- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;
@end

@interface HZPhotoBrowser : UIViewController

/**
 婚庆端 : 照片视频 Reject
 用户端 : 供应商 去掉不合格 CustomerPortCorper
 */
@property (nonatomic, copy) NSString *isReject;
/**照片视频 不合格判断*/
@property (nonatomic, strong) NSArray *rejectArr;
/**删除回调*/
@property (nonatomic, copy) YPPhotoDeleteBlock deleteBlock;
/**驳回回调*/
@property (nonatomic, copy) YPPhotoRejectBlock rejectBlock;

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) int currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;//图片总数

@property (nonatomic, weak) id<HZPhotoBrowserDelegate> delegate;

- (void)show;
@end
