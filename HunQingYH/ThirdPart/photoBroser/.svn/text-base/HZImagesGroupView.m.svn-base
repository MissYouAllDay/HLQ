//
//  HZImagesGroupView.m
//  photoBrowser
//
//  Created by huangzhenyu on 15/6/23.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "HZImagesGroupView.h"
#import "HZPhotoBrowser.h"
#import "UIButton+WebCache.h"
#import "HZPhotoItemModel.h"

#define kImagesMargin 5

@interface HZImagesGroupView() <HZPhotoBrowserDelegate>

@property (strong , nonatomic) NSMutableArray *points;

@end

@implementation HZImagesGroupView

- (NSMutableArray*) points
{
    if (_points==nil) {
        _points=[[NSMutableArray alloc] init];
    }
    return _points;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        // 清除图片缓存，便于测试
        [[SDWebImageManager sharedManager].imageCache clearMemory];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        [btn removeFromSuperview];
        
    }];
        
#define Margin 10
#define itemMargin 5
    
    CGFloat w,h;
    
    //部落分类详情页 多张图片展示的视图大小不同
    if (self.blClassImgsFrame.size.width) {
        w = (self.blClassImgsFrame.size.width-itemMargin*2)/3.0f;
        h = w;
    }else{
        
        if ([self.isFullWidth isEqualToString:@"FullWidth"]) {
            w = (ScreenWidth-itemMargin*2)/3.0f;
            h = w;
        }else{
            w = (ScreenWidth-(Margin+itemMargin)*2-Margin*2)/3.0f;//为了适配宴会厅图片 多删Margin*2
            h = w;
        }
    }
    
    [photoItemArray enumerateObjectsUsingBlock:^(HZPhotoItemModel *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        
        //让图片不变形，以适应按钮宽高，按钮中图片部分内容可能看不到
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.clipsToBounds = YES;
        
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片占位"]];
        
//        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"whiteplaceholder"]];
        
        btn.tag = idx;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //照片视频 不合格判断 0未审核 1审核通过 2审核驳回
        if ([obj.isRejectStatus integerValue] == 2) {
//            UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PV_reject"]];
//            imageV.frame = btn.bounds;
////            imageV.contentMode = UIViewContentModeScaleAspectFill;
////            [btn addSubview:imageV];
//
//            [btn addSubview:imageV];
//            btn.layer.mask = [self addRejectLayerWithW:w AndH:h];
            

            [btn.layer  addSublayer:[self addRejectLayerWithW:w AndH:h]];
            btn.alpha = 0.7;
            

            
        
       
            
        }else{
            btn.alpha = 1.0;
        }

    }];
    
    
    long imageCount = self.photoItemArray.count;
    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    
    //    CGFloat w = 80;
    //    CGFloat h = 80;

    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        long rowIndex = idx / perRowImageCount;
        int columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + kImagesMargin);
        CGFloat y = rowIndex * (h + kImagesMargin);
        btn.frame = CGRectMake(x, y, w, h);
    }];
    
    if (self.blClassImgsFrame.size.width) {
        self.frame = CGRectMake(0, 0, self.blClassImgsFrame.size.width, totalRowCount * (kImagesMargin + h));
    }else{
        //为了适配宴会厅图片 多删 Margin*2
        self.frame = CGRectMake(0, 0, ScreenWidth-4*Margin, totalRowCount * (kImagesMargin + h));
    }
    
    if ([self.imgsGroupDelegate respondsToSelector:@selector(frameWithImagesGroupView:)]) {
        [self.imgsGroupDelegate frameWithImagesGroupView:self.frame];
    }

    
}

- (CAShapeLayer *)addRejectLayerWithW:(CGFloat)w AndH:(CGFloat)h{
    
//    CGPoint point1 = CGPointMake(20, 20);
//    CGPoint point2 = CGPointMake(w*0.5, h*0.5);
//    CGPoint point3 = CGPointMake(w-20, 20);
//    CGPoint point4 = CGPointMake(20, h-20);
//    CGPoint point5 = CGPointMake(w*0.5, h*0.5);
//    CGPoint point6 = CGPointMake(w-20, h-20);
    CGPoint point1 = CGPointMake(40, 40);
    CGPoint point2 = CGPointMake(w*0.5, h*0.5);
    CGPoint point3 = CGPointMake(w-40, 40);
    CGPoint point4 = CGPointMake(40, h-40);
    CGPoint point5 = CGPointMake(w*0.5, h*0.5);
    CGPoint point6 = CGPointMake(w-40, h-40);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
//    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = 8.0f;
    layer.fillColor = [UIColor blackColor].CGColor;// 默认为blackColor
    layer.strokeColor = [UIColor whiteColor].CGColor;
//    layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f].CGColor;
    
    return layer;
    
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    
//}

- (void)buttonClick:(UIButton *)button
{
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self; // 原图的父控件
    browserVc.imageCount = self.photoItemArray.count; // 图片总数
    browserVc.currentImageIndex = (int)button.tag;
    browserVc.delegate = self;
    
    //3-21 添加 照片视频判断是否驳回 Reject
    browserVc.isReject = self.isReject;
    browserVc.rejectArr = self.photoItemArray;
    
    //删除回调
    browserVc.deleteBlock = ^(NSInteger index) {
        self.deleteBlock(index);
    };
    //驳回回调
    browserVc.rejectBlock = ^(NSInteger index) {
        self.rejectBlock(index);
    };
    
    [browserVc show];

}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}
@end
