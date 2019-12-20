//
//  JPPhotoShowController.m
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import "JPPhotoShowController.h"
#import "UIView+JP_Frame.h"
#import "UIImageView+JPWebImage.h"


@interface JPPhotoShowController ()<UIScrollViewDelegate>

/** scroll */
@property(nonatomic,strong) UIScrollView *scrollView;



@end

@implementation JPPhotoShowController


- (instancetype)initWithImageUrl:(NSString *)url PlaceholderImage:(UIImage *)placeholderImage SelectedIndex:(NSInteger)index {
    
    self = [super init];
    if (self) {
        _imageUrl = url;
        _placeholderImage = placeholderImage;
        _selectIndex = index;
        
        [self p_SetupUI];
        [self p_DownLoadImage];
    }
    return self;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIImageView *)imageV{
    
    if (!_imageV) {
        
        _imageV = [[UIImageView alloc] init];;
    }
    return _imageV;
}

/** 设置图片显示 */
- (void)p_SetupUI {
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    
    _scrollView.frame = self.view.bounds;
    _scrollView.delegate = self;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 2;
    
    [_scrollView addSubview:self.imageV];
    
    [self p_SetImageSizeWithImage:_placeholderImage scale:1];
    
    _imageV.userInteractionEnabled = YES;
    
    //添加单击 双击 手势
    UITapGestureRecognizer *oneTapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_OneTapImage)];
    oneTapImage.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_DoubleTapImage)];
    doubleTapImage.numberOfTapsRequired = 2;
    
    [oneTapImage requireGestureRecognizerToFail:doubleTapImage];
    
    [_imageV addGestureRecognizer:oneTapImage];
    [_imageV addGestureRecognizer:doubleTapImage];
}

/** 设置图片大小 */
- (void)p_SetImageSizeWithImage:(UIImage *)image scale:(CGFloat)scale {
    
    //屏幕尺寸
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //原图尺寸
    CGSize imageSize = image.size;
    //需要设置的尺寸
    CGSize size = CGSizeZero;
    size.width = screenSize.width*scale;
    size.height = size.width *imageSize.height / imageSize.width;
    //设置图片位置
    _imageV.frame = CGRectMake(0, 0, size.width, size.height);
    _scrollView.contentSize = size;
    //短图居中
    if (size.height < _scrollView.jp_h*scale) {
        _imageV.jp_y = (_scrollView.jp_h - size.height)*0.5;
        if (_imageV.jp_y < 0) {
            _imageV.jp_y = 0;
        }
    }
}

/** 下载图片 */
- (void)p_DownLoadImage {
    
    [_imageV jp_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:_placeholderImage downloadImageBlock:^(UIImage *image) {
        if (image) {
            [self p_SetImageSizeWithImage:image scale:1];
        }
    }];
}

/** 单击图片 */
- (void)p_OneTapImage {
    
    if ([self.delegate respondsToSelector:@selector(tapImage)]) {
        [self.delegate tapImage];
    }
}

/** 双击 */
- (void)p_DoubleTapImage {
    
    CGFloat scale = self.scrollView.zoomScale < 2 ? 2 : 1;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.zoomScale = scale;
    
    }];
}

//UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    [self p_SetImageSizeWithImage:self.imageV.image scale:scrollView.zoomScale];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageV;
}

//保证翻页时当前图片 恢复原大小
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    self.scrollView.zoomScale = 1;
}



@end
