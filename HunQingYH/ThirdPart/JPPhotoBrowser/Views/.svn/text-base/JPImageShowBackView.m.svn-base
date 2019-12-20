//
//  JPMoreImageView.m
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import "JPImageShowBackView.h"
#import "JPPhotoBrowserController.h"

//控制图片底部显示范围 可自定义调节
#define ImageBackViewW [UIScreen mainScreen].bounds.size.width
//图片之间的间距
static  CGFloat ImageIntterMargin = 8;
//图片和底部View的上下左右间距
static  CGFloat ImageOutterMargin = 12;

@implementation JPImageShowBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self p_SetupImagesUI];
    }
    return self;
}

#pragma mark - 设置图片UI
- (void)p_SetupImagesUI{
    
    //配置当前底部View的背景色
    self.backgroundColor = [UIColor whiteColor];
    
    //超出边界的内容不显示
    self.clipsToBounds = YES;
    
    //行列数
    NSInteger count = 3;
    
    for (NSInteger i = 0; i < count*count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.hidden = YES;
        [self addSubview:imageV];
        
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        
        //计算行列
        NSInteger row = i / count;
        NSInteger col = i % count;
        
        //图片的宽高
        CGFloat imageWH = (ImageBackViewW - 2*ImageOutterMargin -2*ImageIntterMargin)/3;
        
        //计算x/y
        CGFloat imageX = col * (imageWH + ImageIntterMargin) + ImageOutterMargin;
        CGFloat imageY = row * (imageWH + ImageIntterMargin) + ImageOutterMargin;
        
        imageV.frame = CGRectMake(imageX, imageY, imageWH, imageWH);
        
        //记录tag值
        imageV.tag = i;
        
        //添加手势
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_TapImageView:)];
        [imageV addGestureRecognizer:tap];
    }
}

#pragma mark -设置图片
- (void)setSmallImageUrls:(NSArray<NSString *> *)smallImageUrls {
    
    _smallImageUrls = smallImageUrls;
    
    for (NSInteger i = 0; i < smallImageUrls.count; i++) {
        
        UIImageView *imageV;
        
        imageV = (UIImageView *)self.subviews[i];
        
        //四张图特殊处理
        if (i > 1 & smallImageUrls.count == 4) {
            imageV = (UIImageView *)self.subviews[i+1];
        }
        imageV.hidden = NO;
        
        //使用自定义下载
        [imageV jp_setImageWithURL:[NSURL URLWithString:smallImageUrls[i]] placeholderImage:nil];
    }
    
    self.jp_h = [self p_UpdateViewHeightWithImageCount:smallImageUrls.count].height;
    self.jp_w = [self p_UpdateViewHeightWithImageCount:smallImageUrls.count].width;
    
    if (smallImageUrls.count == 1) {
        
        UIImageView *firstImage = (UIImageView *)self.subviews.firstObject;
        firstImage.jp_w = self.jp_w - 2*ImageOutterMargin;
        firstImage.jp_h = self.jp_h - 2*ImageOutterMargin;
    }
}

#pragma mark -根据图片的个数更新View高度
- (CGSize)p_UpdateViewHeightWithImageCount:(NSInteger)imageCount{
    
    if (imageCount == 0) {
        
        return CGSizeMake(0, 0);
    }
    
    if (imageCount == 1) {
        
        return CGSizeMake(ImageBackViewW, ImageBackViewW*9/16.0);
    }
    
    //共几行
    NSInteger row = (imageCount - 1)/3 +1;
    
    //图片的宽高
    CGFloat imageWH = (ImageBackViewW - 2*ImageOutterMargin -2*ImageIntterMargin)/3;
    
    return CGSizeMake(ImageBackViewW, 2*ImageOutterMargin + row*imageWH +(row-1)*ImageIntterMargin);
}

#pragma mark -点击图片
- (void)p_TapImageView:(UIGestureRecognizer *)gesture{
    
    if (self.smallImageUrls.count != self.largeImageUrls.count) {
        
        NSLog(@"JPImageShowBackView.m -- 134行  大小图个数不对应");
        return;
    }
    
    UIImageView *imageV = (UIImageView *)gesture.view;
    
    NSInteger currentImageIndex = imageV.tag;
    //针对四张图片处理
    if (currentImageIndex > 2 && self.smallImageUrls.count == 4) {
        
        currentImageIndex -= 1;
    }
    //若有大图URL 可通过KVC从各个的Model中直接读取
//    NSArray *urls = [self.imageUrls valueForKey:@""];
    
    //将可见的ImageView集合
    NSMutableArray *imageViews = [NSMutableArray array];
    for (UIImageView *imageV in self.subviews) {
        
        if (!imageV.isHidden) {
            [imageViews addObject:imageV];
        }
    }
    
    JPPhotoBrowserController *photoController = [[JPPhotoBrowserController alloc] initWithImageUrls:self.largeImageUrls imageViews:imageViews index:currentImageIndex];
    //如果此处不指定自定义转场 那么会使用默认的转场
    photoController.modalPresentationStyle = UIModalPresentationCustom;
    [self.superController presentViewController:photoController animated:YES completion:nil];
    
    

}

@end
