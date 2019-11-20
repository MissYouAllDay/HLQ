//
//  HZImagesGroupView.h
//  photoBrowser
//
//  Created by huangzhenyu on 15/6/23.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YPPhotoDeleteBlock)(NSInteger index);
typedef void(^YPPhotoRejectBlock)(NSInteger index);

@protocol YPImagesGroupViewDelegate <NSObject>

@optional
- (void)frameWithImagesGroupView:(CGRect)frame;

@end

@interface HZImagesGroupView : UIView
@property (nonatomic, strong) NSArray *photoItemArray;
@property (nonatomic, assign) CGRect blClassImgsFrame;
/**是否全屏宽度  Full*/
@property (nonatomic, copy) NSString *isFullWidth;
/**照片视频 Reject*/
@property (nonatomic, copy) NSString *isReject;

/**删除回调*/
@property (nonatomic, copy) YPPhotoDeleteBlock deleteBlock;
/**驳回回调*/
@property (nonatomic, copy) YPPhotoRejectBlock rejectBlock;

@property (nonatomic, assign) id<YPImagesGroupViewDelegate> imgsGroupDelegate;

@end
