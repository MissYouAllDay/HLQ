//
//  JPPhotoBrowserController.m
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import "JPPhotoBrowserController.h"
#import "JPPhotoShowController.h"
#import "JPPhotoBrowserAnimator.h"

@interface JPPhotoBrowserController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,JPPhotoShowControllerDelegate>

/** JPPhotoBrowserAnimator *animator */
@property(nonatomic,strong) JPPhotoBrowserAnimator *animator;
/** 大图Urls */
@property(nonatomic,strong)NSArray <NSString *>*imageUrls;

/** imageViews */
@property(nonatomic,strong)NSArray <UIImageView *>*imageViews;

/** 当前点击的图片序号 */
@property(nonatomic,assign)NSInteger currentImageIndex;

/** tiplabel */
@property(nonatomic,strong) UILabel *tipLabel;

@end

@implementation JPPhotoBrowserController
{
    JPPhotoShowController   *_currentPhotoShowController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self p_SetupPageUI];
 
    self.animator.currentImageView = _currentPhotoShowController.imageV;
}

- (instancetype)initWithImageUrls:(NSArray<NSString *> *)imageUrls imageViews:(NSArray<UIImageView *> *)imageViews index:(NSInteger)currentImageIndex {
    
    self = [super init];
    if (self) {
        self.imageUrls = imageUrls;
        self.imageViews = imageViews;
        self.currentImageIndex = currentImageIndex;
        //自定义转场
        self.animator.animationImageView = self.imageViews[self.currentImageIndex];
        self.transitioningDelegate = self.animator;
    }
    return self;
}

- (JPPhotoBrowserAnimator *)animator{
    
    if (!_animator) {
        
        _animator = [[JPPhotoBrowserAnimator alloc] init];
    }
    return _animator;
}

/** 设置分页控制器 */
- (void)p_SetupPageUI {
    //UIPageViewControllerTransitionStyleScroll滑动换页  UIPageViewControllerNavigationOrientationHorizontal横向滚动  UIPageViewControllerOptionInterPageSpacingKey页间距
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{@"UIPageViewControllerOptionInterPageSpacingKey":@20}];
    
    JPPhotoShowController *showController = [[JPPhotoShowController alloc] initWithImageUrl:self.imageUrls[self.currentImageIndex] PlaceholderImage:self.imageViews[self.currentImageIndex].image SelectedIndex:self.currentImageIndex];
    _currentPhotoShowController = showController;
    showController.delegate = self;
    //设置show为page的子控制器
    [pageViewController setViewControllers:@[showController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    //将分页控制器添加为当前的子控制器
    [self.view addSubview:pageViewController.view];
    [self addChildViewController:pageViewController];
    [pageViewController didMoveToParentViewController:self];
    
    //代理
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    
    //设置手势
    self.view.gestureRecognizers = pageViewController.gestureRecognizers;
    
    //顶部提示
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.frame = CGRectMake(0, STATUS_BAR_HEIGHT+20, self.view.bounds.size.width, 25);
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.hidden = !self.imageUrls.count;
    self.tipLabel.font = [UIFont boldSystemFontOfSize:18];
    self.tipLabel.textColor = [UIColor whiteColor];
    [self p_SetTipLabelCount:self.currentImageIndex];
    [self.view addSubview:self.tipLabel];
    
    //保存
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-70, self.view.bounds.size.height-45, 50, 25)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.borderWidth = 1;
    saveBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(p_SaveImage) forControlEvents:UIControlEventTouchUpInside];
}

/** setlabelcount */
- (void)p_SetTipLabelCount:(NSInteger)index {
    
    NSInteger allCount = self.imageUrls.count;
    
    NSString *countStr = [NSString stringWithFormat:@"%ld / %zd",index+1,allCount];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:countStr];
    
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} range:NSMakeRange(0, 1)];
    
    self.tipLabel.attributedText = attributedStr;
}

/** 保存图片 */
- (void)p_SaveImage {
    
    UIImageWriteToSavedPhotosAlbum(_currentPhotoShowController.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *saveStr = @"";
    
    if (error == nil) {
        saveStr = @"保存成功";
    }else {
        saveStr = @"保存失败";
    }
    
    NSLog(@"%@", saveStr);
}

/**
 返回前一页控制器

 @param pageViewController pageViewController description
 @param viewController 当前显示的控制器
 @return 返回前一页控制器 返回Nil 就是到头了
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    //取出当前控制器的序号
    JPPhotoShowController *currentCtrl = (JPPhotoShowController *)viewController;
    NSInteger index = currentCtrl.selectIndex;
    //判断是否已经滑动到最前面一页
    if (index <= 0) {
        return nil;
    }
    index --;
    JPPhotoShowController *beforeCtrl = [[JPPhotoShowController alloc] initWithImageUrl:self.imageUrls[index] PlaceholderImage:self.imageViews[index].image SelectedIndex:index];
    beforeCtrl.delegate = self;
    return beforeCtrl;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    //取出当前控制器的序号
    JPPhotoShowController *currentCtrl = (JPPhotoShowController *)viewController;
    NSInteger index = currentCtrl.selectIndex;
    //判断是否已经滑动到最后面一页
    if (index >= self.imageUrls.count-1) {
        return nil;
    }
    index ++;
    JPPhotoShowController *afterCtrl = [[JPPhotoShowController alloc] initWithImageUrl:self.imageUrls[index] PlaceholderImage:self.imageViews[index].image SelectedIndex:index];
    afterCtrl.delegate = self;
    return afterCtrl;

}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    // viewControllers[0] 是当前显示的控制器，随着分页控制器的滚动，调整数组的内容次序
    // 始终保证当前显示的控制器的下标是 0
    // 一定注意，不要使用 childViewControllers
    
    JPPhotoShowController *showController = (JPPhotoShowController *)pageViewController.viewControllers[0];
    _currentPhotoShowController = showController;
    self.currentImageIndex = showController.selectIndex;
    
    //提示
    [self p_SetTipLabelCount:self.currentImageIndex];
}

/**
 单击图片 退出浏览
 */
- (void)tapImage {
    
    //退出时一定要给转场代理重新赋值当前的图片
    self.animator.animationImageView = self.imageViews[self.currentImageIndex];
    self.animator.currentImageView = _currentPhotoShowController.imageV;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
