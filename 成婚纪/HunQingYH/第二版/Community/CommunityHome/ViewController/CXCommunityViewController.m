//
//  CXCommunityViewController.m
//  HunQingYH
//
//  Created by apple on 2019/10/25.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXCommunityViewController.h"
#import "YPReFindController.h"  // 婚礼秀
// #import "YPHome190226HunQianBiKanController.h"  //  备婚指南（代码不兼容。懒得改了。凑合着看吧）
#import "CXCommuntySecoundView.h"             //  备婚指南

@interface CXCommunityViewController ()

/// 滚动图
@property (nonatomic, strong) UIScrollView *scrollView;
/// 滚动图
@property (nonatomic, strong) UIView *bgView;
/// 第一个视图
@property (nonatomic, strong) UIView *zeroView;     // 婚礼秀
/// 第二个视图
@property (nonatomic, strong) UIView *firstView;        // 精选
/** 选择器高度 */
@property (nonatomic, assign) CGFloat segBarHeight;
/// 导航栏
@property (nonatomic, strong) UIView *naviBar;

/// 婚礼秀按钮
@property (nonatomic, strong) UIButton *senderZero;

/// 精选按钮
@property (nonatomic, strong) UIButton *senderFirst;
/** scrollview偏移量 */
@property (nonatomic, assign) CGPoint contentOffset;

@end

@implementation CXCommunityViewController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    self.bgView.transform = CGAffineTransformMakeTranslation(self.contentOffset.x, 0);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segBarHeight = 0;
    self.view.backgroundColor = WhiteColor;
    self.scrollView.hidden = YES;
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.zeroView];
    [self.bgView addSubview:self.firstView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)];
        _scrollView.showsVerticalScrollIndicator = MACH_SEND_NOTIFY;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [_scrollView setBackgroundColor:[UIColor redColor]];
    }
    return _scrollView;
}

- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth * 2, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)];
    }
    return _bgView;
}

- (UIView *)zeroView {
    
    if (!_zeroView) {
        _zeroView = [[UIView alloc] initWithFrame:CGRectMake(0,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight)];
        YPReFindController *vc = [[YPReFindController alloc] init];
        vc.isSubViews = YES;
        vc.view.frame = _zeroView.bounds;
        _zeroView = vc.view;
        _zeroView.frame = CGRectMake(0,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight);
    }
    return _zeroView;
}

- (UIView *)firstView {
    
    if (!_firstView) {
        _firstView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, self.zeroView.top, self.zeroView.width, self.zeroView.height)];
//        YPHome190226HunQianBiKanController *vc = [[YPHome190226HunQianBiKanController alloc] init];
        CXCommuntySecoundView *view = [[CXCommuntySecoundView alloc] initWithFrame:_firstView.bounds];
        [_firstView addSubview: view];
    }
    return _firstView;
}

- (UIView *)naviBar {
    
    if (!_naviBar) {
        CGFloat itemW = (ScreenWidth - 100)/2;
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];

        UIImageView *centerImg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 1)/2, STATUS_BAR_HEIGHT, 1, 44)];
        centerImg.image = [UIImage imageNamed:@"centerLine"];
        centerImg.contentMode = UIViewContentModeCenter;
        
        UIButton *senderZero = [UIButton buttonWithType:UIButtonTypeCustom];
        senderZero.frame = CGRectMake(centerImg.left - itemW, centerImg.top, itemW, centerImg.height);
        [senderZero setTitle:@"婚礼秀" forState:UIControlStateNormal];
        [senderZero setTitleColor:RGB(245, 51, 118) forState:UIControlStateSelected];
        [senderZero setTitleColor:RGB(58, 58, 58) forState:UIControlStateNormal];
        [senderZero addTarget:self action:@selector(senderZeroAction:) forControlEvents:UIControlEventTouchUpInside];
        senderZero.selected = YES;

        UIButton *senderFirst = [UIButton buttonWithType:UIButtonTypeCustom];
       senderFirst.frame = CGRectMake(centerImg.right , centerImg.top, itemW, centerImg.height);
       [senderFirst setTitle:@"精选" forState:UIControlStateNormal];
       [senderFirst setTitleColor:RGB(245, 51, 118) forState:UIControlStateSelected];
       [senderFirst setTitleColor:RGB(58, 58, 58) forState:UIControlStateNormal];
       [senderFirst addTarget:self action:@selector(senderFirstAction:) forControlEvents:UIControlEventTouchUpInside];
      senderFirst.selected = NO;
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, _naviBar.height - 1, ScreenWidth, 1);
        layer.backgroundColor = LineColor.CGColor;
    
        [_naviBar addSubview:centerImg];
        [_naviBar addSubview:senderZero];
        [_naviBar addSubview:senderFirst];
        [_naviBar.layer addSublayer:layer];
        
        self.senderZero = senderZero;
        self.senderFirst = senderFirst;
    }
    return _naviBar;
}

- (void)senderZeroAction:(UIButton *)sender {
    sender.selected = YES;
    self.senderFirst.selected = NO;
    self.contentOffset =  CGPointMake(0, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = self.contentOffset;
        self.bgView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)senderFirstAction:(UIButton *)sender {
    sender.selected = YES;
    self.senderZero.selected = NO;
    self.contentOffset = CGPointMake(ScreenWidth, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = self.contentOffset;
        self.bgView.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
    }];
}


@end
