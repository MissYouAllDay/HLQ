//
//  HZPhotoBrowser.m
//  photoBrowser
//
//  Created by huangzhenyu on 15/6/23.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "HZPhotoBrowser.h"
#import "HZPhotoBrowserConfig.h"
#import "HZPhotoItemModel.h"

@interface HZPhotoBrowser() <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) BOOL hasShowedPhotoBrowser;
@property (nonatomic,strong) UILabel *indexLabel;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) UIButton *saveButton;//保存
@property (nonatomic, strong) UIButton *deleteBtn;//删除
@property (nonatomic, strong) UIButton *rejectBtn;//驳回
@property (nonatomic, strong) UILabel *rejectTagLabel;//不合格标志
@property (nonatomic, strong) UILabel *rejectReason;//不合格原因

@end

@implementation HZPhotoBrowser

- (void)viewDidLoad
{
    [super viewDidLoad];
    _hasShowedPhotoBrowser = NO;
    self.view.backgroundColor = kPhotoBrowserBackgrounColor;
    [self addScrollView];
    [self addToolbars];
    [self setUpFrames];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_hasShowedPhotoBrowser) {
        [self showPhotoBrowser];
    }
}

#pragma mark 重置各控件frame（处理屏幕旋转）
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self setUpFrames];
}

#pragma mark 设置各控件frame
- (void)setUpFrames
{
    CGRect rect = self.view.bounds;
    rect.size.width += kPhotoBrowserImageViewMargin * 2;
    _scrollView.bounds = rect;
    _scrollView.center = CGPointMake(kAPPWidth *0.5, kAppHeight *0.5);
    
    CGFloat y = 0;
    __block CGFloat w = kAPPWidth;
    CGFloat h = kAppHeight;
    
    //设置所有HZPhotoBrowserView的frame
    [_scrollView.subviews enumerateObjectsUsingBlock:^(HZPhotoBrowserView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = kPhotoBrowserImageViewMargin + idx * (kPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, kAppHeight);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    
    _indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    _indexLabel.center = CGPointMake(kAPPWidth * 0.5, 30);
    
    if ([self.isReject isEqualToString:@"Reject"]) {//是否 照片驳回
        //3-21 修改
        _deleteBtn.frame = CGRectMake(10, ScreenHeight-50, (ScreenWidth-10*2)/3.0, 50);
        _rejectBtn.frame = CGRectMake(CGRectGetWidth(_deleteBtn.frame)+10, ScreenHeight-50, CGRectGetWidth(_deleteBtn.frame), 50);
        _saveButton.frame = CGRectMake(CGRectGetWidth(_rejectBtn.frame)+CGRectGetWidth(_deleteBtn.frame)+10, ScreenHeight-50, CGRectGetWidth(_deleteBtn.frame), 50);
        
    }else if ([self.isReject isEqualToString:@"CustomerPortCorper"]){//CustomerPortCorper 用户端: 供应商 无不合格
        
        //3-26
        _deleteBtn.frame = CGRectMake(10, ScreenHeight-50, (ScreenWidth-10*2)/3.0, 50);
        _saveButton.frame = CGRectMake(CGRectGetWidth(_rejectBtn.frame)+CGRectGetWidth(_deleteBtn.frame)+10, ScreenHeight-50, CGRectGetWidth(_deleteBtn.frame), 50);
    }else{
        _saveButton.frame = CGRectMake(30, kAppHeight - 70, 55, 30);
    }
}

#pragma mark 显示图片浏览器
- (void)showPhotoBrowser
{
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    UIView *parentView = [self getParsentView:sourceView];
    CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:parentView];
    
    //如果是tableview，要减去偏移量
    if ([parentView isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)parentView;
        rect.origin.y =  rect.origin.y - tableview.contentOffset.y;
    }
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.frame = rect;
    tempImageView.image = [self placeholderImageForIndex:self.currentImageIndex];
    [self.view addSubview:tempImageView];
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;

    CGFloat placeImageSizeW = tempImageView.image.size.width;
    CGFloat placeImageSizeH = tempImageView.image.size.height;
    CGRect targetTemp;
    
    if (!kIsFullWidthForLandScape) {
        if (kAPPWidth < kAppHeight) {
            CGFloat placeHolderH = (placeImageSizeH * kAPPWidth)/placeImageSizeW;
            if (placeHolderH <= kAppHeight) {
                targetTemp = CGRectMake(0, (kAppHeight - placeHolderH) * 0.5 , kAPPWidth, placeHolderH);
            } else {
                targetTemp = CGRectMake(0, 0, kAPPWidth, placeHolderH);
            }
        } else {
            CGFloat placeHolderW = (placeImageSizeW * kAppHeight)/placeImageSizeH;
            if (placeHolderW < kAPPWidth) {
                targetTemp = CGRectMake((kAPPWidth - placeHolderW)*0.5, 0, placeHolderW, kAppHeight);
            } else {
                targetTemp = CGRectMake(0, 0, placeHolderW, kAppHeight);
            }
        }

    } else {
        CGFloat placeHolderH = (placeImageSizeH * kAPPWidth)/placeImageSizeW;
        if (placeHolderH <= kAppHeight) {
            targetTemp = CGRectMake(0, (kAppHeight - placeHolderH) * 0.5 , kAPPWidth, placeHolderH);
        } else {
            targetTemp = CGRectMake(0, 0, kAPPWidth, placeHolderH);
        }
    }
    
    _scrollView.hidden = YES;
    _indexLabel.hidden = YES;
    _saveButton.hidden = YES;
    //3-21 修改
    _deleteBtn.hidden = YES;
    _rejectBtn.hidden = YES;

    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    HZPhotoItemModel *itemModel = self.rejectArr[index];
    
    [UIView animateWithDuration:kPhotoBrowserShowDuration animations:^{
        tempImageView.frame = targetTemp;
    } completion:^(BOOL finished) {
        _hasShowedPhotoBrowser = YES;
        [tempImageView removeFromSuperview];
        _scrollView.hidden = NO;
        _indexLabel.hidden = NO;
        _saveButton.hidden = NO;
        //3-21 修改
        _deleteBtn.hidden = NO;
        
        if ([itemModel.isRejectStatus integerValue] == 2) {//照片视频 不合格判断 0未审核 1审核通过 2审核驳回
            _rejectBtn.hidden = YES;
        }else{
            _rejectBtn.hidden = NO;
        }
    }];
}

#pragma mark 添加scrollview
- (void)addScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.view.bounds;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.hidden = YES;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < self.imageCount; i++) {
        HZPhotoBrowserView *view = [[HZPhotoBrowserView alloc] init];
        view.imageview.tag = i;
        
        //处理单击
       
        view.singleTapBlock = ^(UITapGestureRecognizer *recognizer){
       
            [self.view removeFromSuperview];//待定
//            [strongSelf hidePhotoBrowser:recognizer];
        };
        
        [_scrollView addSubview:view];
    }
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
}

#pragma mark 添加操作按钮
- (void)addToolbars
{
    //序标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = [UIFont boldSystemFontOfSize:20];
    indexLabel.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    indexLabel.bounds = CGRectMake(0, 0, 100, 40);
    indexLabel.center = CGPointMake(kAPPWidth * 0.5, 30);
    indexLabel.layer.cornerRadius = 15;
    indexLabel.clipsToBounds = YES;
 
    if (self.imageCount > 1) {
        indexLabel.text = [NSString stringWithFormat:@"1/%ld", (long)self.imageCount];
        _indexLabel = indexLabel;
        [self.view addSubview:indexLabel];
    }

    if ([self.isReject isEqualToString:@"Reject"]) {//是 照片驳回
        //1.删除
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        deleteBtn.layer.borderWidth = 0.1;
        deleteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        deleteBtn.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        deleteBtn.layer.cornerRadius = 2;
        deleteBtn.clipsToBounds = YES;
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn = deleteBtn;
        [self.view addSubview:deleteBtn];
        
        //2.驳回
        UIButton *rejectBtn = [[UIButton alloc] init];
        [rejectBtn setTitle:@"不合格" forState:UIControlStateNormal];
        [rejectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rejectBtn.layer.borderWidth = 0.1;
        rejectBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        rejectBtn.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        rejectBtn.layer.cornerRadius = 2;
        rejectBtn.clipsToBounds = YES;
        [rejectBtn addTarget:self action:@selector(rejectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _rejectBtn = rejectBtn;
        [self.view addSubview:rejectBtn];
        
        // 3.保存按钮
        UIButton *saveButton = [[UIButton alloc] init];
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        saveButton.layer.borderWidth = 0.1;
        saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
        saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        saveButton.layer.cornerRadius = 2;
        saveButton.clipsToBounds = YES;
        [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        _saveButton = saveButton;
        [self.view addSubview:saveButton];
        
        
        int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
        HZPhotoItemModel *itemModel = self.rejectArr[index];
        HZPhotoBrowserView *currentView = _scrollView.subviews[index];
        
//        测试
//        if (index == 1 || index == 3) {
//            itemModel.isRejectStatus = @"2";
//        }
        
        if ([itemModel.isRejectStatus integerValue] == 2) {//照片视频 不合格判断 0未审核 1审核通过 2审核驳回
            
            _rejectBtn.hidden = YES;
            
            UILabel *rejectTag = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-115-15, ScreenHeight/2.0-60, 115, 40)];
            rejectTag.text = @"X 不合格";
            rejectTag.textColor = WhiteColor;
            rejectTag.textAlignment = NSTextAlignmentCenter;
            rejectTag.layer.cornerRadius = 20;
            rejectTag.clipsToBounds = YES;
            rejectTag.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
            rejectTag.font = [UIFont boldSystemFontOfSize:23];
            _rejectTagLabel = rejectTag;
            [currentView addSubview:rejectTag];
            
            if (itemModel.Reason.length > 0) {
                CGFloat reasonH = [self getHeighWithTitle:itemModel.Reason font:kBigFont width:ScreenWidth-20];
                UILabel *reason = [[UILabel alloc]initWithFrame:CGRectMake(10, ScreenHeight-reasonH-10-60, ScreenWidth-20, reasonH+10)];//-60 底部按钮高度
                reason.text = itemModel.Reason;
                reason.textColor = WhiteColor;
                reason.numberOfLines = 0;
                reason.layer.cornerRadius = 3;
                reason.clipsToBounds = YES;
                reason.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
                reason.font = kBigFont;
                _rejectReason = reason;
                [currentView addSubview:reason];
            }
        }else{
            _rejectBtn.hidden = NO;
        }
        
        
    }else if ([self.isReject isEqualToString:@"CustomerPortCorper"]){//CustomerPortCorper 用户端: 供应商 无不合格
        
        //1.删除
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        deleteBtn.layer.borderWidth = 0.1;
        deleteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        deleteBtn.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        deleteBtn.layer.cornerRadius = 2;
        deleteBtn.clipsToBounds = YES;
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn = deleteBtn;
        [self.view addSubview:deleteBtn];
        
        // 3.保存按钮
        UIButton *saveButton = [[UIButton alloc] init];
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        saveButton.layer.borderWidth = 0.1;
        saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
        saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        saveButton.layer.cornerRadius = 2;
        saveButton.clipsToBounds = YES;
        [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        _saveButton = saveButton;
        [self.view addSubview:saveButton];
        
        int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
        HZPhotoItemModel *itemModel = self.rejectArr[index];
        HZPhotoBrowserView *currentView = _scrollView.subviews[index];
        
        if ([itemModel.isRejectStatus integerValue] == 2) {//照片视频 不合格判断 0未审核 1审核通过 2审核驳回
            
            _rejectBtn.hidden = YES;
            
            UILabel *rejectTag = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-115-15, ScreenHeight/2.0-60, 115, 40)];
            rejectTag.text = @"X 不合格";
            rejectTag.textColor = WhiteColor;
            rejectTag.textAlignment = NSTextAlignmentCenter;
            rejectTag.layer.cornerRadius = 20;
            rejectTag.clipsToBounds = YES;
            rejectTag.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
            rejectTag.font = [UIFont boldSystemFontOfSize:23];
            _rejectTagLabel = rejectTag;
            [currentView addSubview:rejectTag];
            
            if (itemModel.Reason.length > 0) {
                CGFloat reasonH = [self getHeighWithTitle:itemModel.Reason font:kBigFont width:ScreenWidth-20];
                UILabel *reason = [[UILabel alloc]initWithFrame:CGRectMake(10, ScreenHeight-reasonH-10-60, ScreenWidth-20, reasonH+10)];//-60 底部按钮高度
                reason.text = itemModel.Reason;
                reason.textColor = WhiteColor;
                reason.numberOfLines = 0;
                reason.layer.cornerRadius = 3;
                reason.clipsToBounds = YES;
                reason.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
                reason.font = kBigFont;
                _rejectReason = reason;
                [currentView addSubview:reason];
            }
        }else{
            _rejectBtn.hidden = NO;
        }
        
    }else{
        // 3.保存按钮
        UIButton *saveButton = [[UIButton alloc] init];
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        saveButton.layer.borderWidth = 0.1;
        saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
        saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
        saveButton.layer.cornerRadius = 2;
        saveButton.clipsToBounds = YES;
        [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        _saveButton = saveButton;
        [self.view addSubview:saveButton];
    }
    
}

#pragma mark - 动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

#pragma mark 保存图像
- (void)saveImage
{
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    
    HZPhotoBrowserView *currentView = _scrollView.subviews[index];
    
    UIImageWriteToSavedPhotosAlbum(currentView.imageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = self.view.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}
#pragma mark 删除图片
- (void)deleteBtnClick{
    NSLog(@"deleteBtnClick");
    
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    self.deleteBlock(index);
    [self.view removeFromSuperview];//待定
}

#pragma mark 驳回图片
- (void)rejectBtnClick{
    NSLog(@"rejectBtnClick");
    
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    self.rejectBlock(index);
    [self.view removeFromSuperview];//待定
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.50f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 60);
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:21];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = @"保存失败";
    }   else {
        label.text = @"保存成功";
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];//待定
//    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:self animated:NO completion:nil];
}



#pragma mark 单击隐藏图片浏览器
- (void)hidePhotoBrowser:(UITapGestureRecognizer *)recognizer
{
    HZPhotoBrowserView *view = (HZPhotoBrowserView *)recognizer.view;
    UIImageView *currentImageView = view.imageview;
    
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    UIView *parentView = [self getParsentView:sourceView];
    CGRect targetTemp = [sourceView.superview convertRect:sourceView.frame toView:parentView];
    
    // 减去偏移量
    if ([parentView isKindOfClass:[UITableView class]]) {
        UITableView *tableview = (UITableView *)parentView;
        targetTemp.origin.y =  targetTemp.origin.y - tableview.contentOffset.y;
    }
    
    CGFloat appWidth;
    CGFloat appHeight;
    if (kAPPWidth < kAppHeight) {
        appWidth = kAPPWidth;
        appHeight = kAppHeight;
    } else {
        appWidth = kAppHeight;
        appHeight = kAPPWidth;
    }
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.image = currentImageView.image;
    if (tempImageView.image) {
        CGFloat tempImageSizeH = tempImageView.image.size.height;
        CGFloat tempImageSizeW = tempImageView.image.size.width;
        CGFloat tempImageViewH = (tempImageSizeH * appWidth)/tempImageSizeW;
        if (tempImageViewH < appHeight) {
            tempImageView.frame = CGRectMake(0, (appHeight - tempImageViewH)*0.5, appWidth, tempImageViewH);
        } else {
            tempImageView.frame = CGRectMake(0, 0, appWidth, tempImageViewH);
        }
    } else {
        tempImageView.backgroundColor = [UIColor whiteColor];
        tempImageView.frame = CGRectMake(0, (appHeight - appWidth)*0.5, appWidth, appWidth);
    }
    
    [self.view.window addSubview:tempImageView];
    
//    [self dismissViewControllerAnimated:NO completion:nil];

    [UIView animateWithDuration:kPhotoBrowserHideDuration animations:^{
        tempImageView.frame = targetTemp;
        
    } completion:^(BOOL finished) {
        [tempImageView removeFromSuperview];
    }];
}

#pragma mark 网络加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index
{
    HZPhotoBrowserView *view = _scrollView.subviews[index];
    if (view.beginLoadingImage) return;
    if ([self highQualityImageURLForIndex:index]) {
        [view setImageWithURL:[self highQualityImageURLForIndex:index] placeholderImage:[self placeholderImageForIndex:index]];
    } else {
        view.imageview.image = [self placeholderImageForIndex:index];
    }
    view.beginLoadingImage = YES;
}

#pragma mark 获取控制器的view
- (UIView *)getParsentView:(UIView *)view{
    if ([[view nextResponder] isKindOfClass:[UIViewController class]] || view == nil) {
        return view;
    }
    return [self getParsentView:view.superview];
}

#pragma mark 获取低分辨率（占位）图片
- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }
    return nil;
}

#pragma mark 获取高分辨率图片url
- (NSURL *)highQualityImageURLForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:highQualityImageURLForIndex:)]) {
        return [self.delegate photoBrowser:self highQualityImageURLForIndex:index];
    }
    return nil;
}


#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([self.isReject isEqualToString:@"Reject"] || [self.isReject isEqualToString:@"CustomerPortCorper"]) {//CustomerPortCorper 用户端: 供应商 无不合格
        int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
        HZPhotoItemModel *itemModel = self.rejectArr[index];
        HZPhotoBrowserView *currentView = _scrollView.subviews[index];

        //测试
//        if (index == 1 || index == 3) {
//            itemModel.isRejectStatus = @"2";
//        }
        
        if ([itemModel.isRejectStatus integerValue] == 2) {//照片视频 不合格判断 0未审核 1审核通过 2审核驳回
            
            _rejectBtn.hidden = YES;
            
            UILabel *rejectTag = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-115-15, ScreenHeight/2.0-60, 115, 40)];
            rejectTag.text = @"X 不合格";
            rejectTag.textColor = WhiteColor;
            rejectTag.textAlignment = NSTextAlignmentCenter;
            rejectTag.layer.cornerRadius = 20;
            rejectTag.clipsToBounds = YES;
            rejectTag.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
            rejectTag.font = [UIFont boldSystemFontOfSize:23];
            _rejectTagLabel = rejectTag;
            [currentView addSubview:rejectTag];
            
            if (itemModel.Reason.length > 0) {
                CGFloat reasonH = [self getHeighWithTitle:itemModel.Reason font:kBigFont width:ScreenWidth-20];
                UILabel *reason = [[UILabel alloc]initWithFrame:CGRectMake(10, ScreenHeight-reasonH-10-60, ScreenWidth-20, reasonH+10)];//-60 底部按钮高度
                reason.text = itemModel.Reason;
                reason.textColor = WhiteColor;
                reason.numberOfLines = 0;
                reason.layer.cornerRadius = 3;
                reason.clipsToBounds = YES;
                reason.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
                reason.font = kBigFont;
                _rejectReason = reason;
                [currentView addSubview:reason];
            }
        }else{
            _rejectBtn.hidden = NO;
        }
    }
    
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    
    _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1, (long)self.imageCount];
    long left = index - 2;
    long right = index + 2;
    left = left>0?left : 0;
    right = right>self.imageCount?self.imageCount:right;
    
    //预加载三张图片
    for (long i = left; i < right; i++) {
        [self setupImageOfImageViewForIndex:i];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int autualIndex = scrollView.contentOffset.x  / _scrollView.bounds.size.width;
    //设置当前下标
    self.currentImageIndex = autualIndex;
    
    //将不是当前imageview的缩放全部还原 (这个方法有些冗余，后期可以改进)
    for (HZPhotoBrowserView *view in _scrollView.subviews) {
        if (view.imageview.tag != autualIndex) {
            view.scrollview.zoomScale = 1.0;
        }
    }
}

#pragma mark 横竖屏设置
- (BOOL)shouldAutorotate
{
    return shouldSupportLandscape;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (shouldSupportLandscape) {
        return UIInterfaceOrientationMaskAll;
    } else{
        return UIInterfaceOrientationMaskPortrait;
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
