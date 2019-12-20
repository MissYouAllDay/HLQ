//
//  JPPhotoShowController.h
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JPPhotoShowControllerDelegate <NSObject>

- (void)tapImage;

@end


//负责单张照片的显示的控制器
@interface JPPhotoShowController : UIViewController

- (instancetype)initWithImageUrl:(NSString *)url PlaceholderImage:(UIImage *)placeholderImage SelectedIndex:(NSInteger)index;

/** 大图的URL */
@property(nonatomic,strong)NSString *imageUrl;
/** 占位图 */
@property(nonatomic,strong)UIImage *placeholderImage;
/** 当前点击的序号 */
@property(nonatomic,assign)NSInteger  selectIndex;
/** 当前显示图片的View */
@property(nonatomic,strong) UIImageView *imageV;
/** delegate */
@property(nonatomic,assign) id<JPPhotoShowControllerDelegate> delegate;


@end
