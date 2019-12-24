//
//  CXManagerHomeVC.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 我的 - - - - - - - - - - - - - - - - - -


#import "CXManagerHomeVC.h"
#import "ManageViewController.h"            //  管理
#import "YPKeYuan190513ViewController.h"    // 客源
#import "SliderMessageController.h"         // 消息

#import "YPMyKeYuan190311BaseController.h"  //我的客源

@interface CXManagerHomeVC ()<JXCategoryViewDelegate>

/// 滚动图
@property (nonatomic, strong) UIScrollView *scrollView;
/// 滚动图
@property (nonatomic, strong) UIView *bgView;
/// 第0个视图
@property (nonatomic, strong) UIView *zeroView;        // 客源申请
/// 第1个视图
@property (nonatomic, strong) UIView *defaFirstView;     // 商家汇总
/// 第1个视图
@property (nonatomic, strong) UIView *hotelFirstView;     // 宴会预订
/// 第二个视图
@property (nonatomic, strong) UIView  *secondView;      // 客源确认
/** 选择器高度 */
@property (nonatomic, assign) CGFloat segBarHeight;
/// 导航栏
@property (nonatomic, strong) UIView *naviBar;
/** scrollview偏移量 */
@property (nonatomic, assign) CGPoint contentOffset;

@property (nonatomic, strong) JXCategoryTitleView  *topTitleView;    // 顶部分割线
@property (nonatomic, strong) NSMutableArray  *segmentData;    // 导航栏选择器
@property (nonatomic, strong) UIButton  *rightButton;    // 我的客源

@end

@implementation CXManagerHomeVC

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
    [self navigationBarData];
    
    self.segBarHeight = 0;
    self.view.backgroundColor = WhiteColor;
    self.scrollView.hidden = YES;
    
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.bgView];
    
    [self.naviBar addSubview:self.topTitleView];
    
    [self.bgView addSubview:self.zeroView];
    [self.bgView addSubview:self.defaFirstView];
    [self.bgView addSubview:self.hotelFirstView];
    [self.bgView addSubview:self.secondView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

// MARK: - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    switch (index) {
        case 0: [self senderZeroAction]; break;
        case 1: [self senderFirstAction]; break;
        case 2: [self senderSecondAction]; break;
        default: break;
    }
}

// MARK: - Until
// 获取导航栏选择器的数据
- (void)navigationBarData {
    NSArray *array = @[@"客源申请",@"客源汇总",@"客源确认"];
    self.segmentData = [[NSMutableArray alloc] initWithArray:array];
    if (JiuDian(Profession_New)) {
        self.segmentData[1] = @"宴会预订";
        self.hotelFirstView.hidden = NO;
    }
}

// MARK: - 懒加载
- (JXCategoryTitleView *)topTitleView {
    
    if (!_topTitleView) {
        _topTitleView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(Line375(50), STATUSBAR_HEIGHT_S, [UIScreen mainScreen].bounds.size.width - Line375(100), 44)];
        _topTitleView.titles = self.segmentData;
        _topTitleView.delegate = self;
        _topTitleView.titleColorGradientEnabled = YES;
        _topTitleView.titleSelectedColor = [UIColor redColor];
        _topTitleView.titleLabelStrokeWidthEnabled = YES;
        _topTitleView.separatorLineShowEnabled = YES;
    
    }
    return _topTitleView;
}


- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [_scrollView setBackgroundColor:[UIColor redColor]];
    }
    return _scrollView;
}

- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth * 3, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UIView *)zeroView {
    
    if (!_zeroView) {
        _zeroView = [[UIView alloc] initWithFrame:CGRectMake(0, self.defaFirstView.top, self.defaFirstView.width, self.defaFirstView.height)];
        YPKeYuan190513ViewController *vc = [[YPKeYuan190513ViewController alloc] init];
        vc.view.frame = _zeroView.bounds;
        [_zeroView addSubview: vc.view];
        [_zeroView addSubview:self.rightButton];
    }
    return _zeroView;
}

- (UIView *)defaFirstView {
    
    if (!_defaFirstView) {
        _defaFirstView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight)];
        ManageViewController *vc = [[ManageViewController alloc] init];
        vc.isSubViews = YES;
        vc.view.frame = _defaFirstView.bounds;
        _defaFirstView = vc.view;
        _defaFirstView.frame = CGRectMake(ScreenWidth,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight);
    }
    return _defaFirstView;
}

- (UIView *)hotelFirstView {
    
    if (!_hotelFirstView) {
        _hotelFirstView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight)];
        ManageViewController *vc = [[ManageViewController alloc] init];
        vc.isSubViews = YES;
        vc.view.frame = _hotelFirstView.bounds;
        _hotelFirstView = vc.view;
        _hotelFirstView.hidden = YES;
        _hotelFirstView.frame = CGRectMake(ScreenWidth,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight);
    }
    return _hotelFirstView;
}

- (UIView *)secondView {
    
    if (!_secondView) {
        _secondView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth * 2 ,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight)];
        ManageViewController *vc = [[ManageViewController alloc] init];
        vc.isSubViews = YES;
        vc.view.frame = _secondView.bounds;
        _secondView = vc.view;
        _secondView.frame = CGRectMake(ScreenWidth * 2,self.segBarHeight, ScreenWidth, self.scrollView.height - self.segBarHeight);
    }
    return _secondView;
}
- (UIView *)naviBar {
    
    if (!_naviBar) {
        CGFloat itemW = (ScreenWidth - 200)/2;
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(Line375(18), (44 - 25)/2 + STATUS_BAR_HEIGHT, 25, 25);
        [leftBtn setImage:[UIImage imageNamed:@"1024"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.layer.cornerRadius = leftBtn.height/2;
        leftBtn.clipsToBounds = YES;
        
        UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(ScreenWidth - leftBtn.right, leftBtn.top, leftBtn.width, leftBtn.height);
        [rightBtn setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, _naviBar.height - 1, ScreenWidth, 1);
        layer.backgroundColor = LineColor.CGColor;
        
        [_naviBar addSubview:leftBtn];
        [_naviBar addSubview:rightBtn];
        [_naviBar.layer addSublayer:layer];
    }
    return _naviBar;
}
// MARK: - 导航栏点击事件
- (void)senderZeroAction{
    
    self.contentOffset =  CGPointMake(0, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = self.contentOffset;
        self.bgView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)senderFirstAction {
    self.contentOffset = CGPointMake(ScreenWidth, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = self.contentOffset;
        self.bgView.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
    }];
}

- (void)senderSecondAction {
    self.contentOffset = CGPointMake(ScreenWidth * 2, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = self.contentOffset;
        self.bgView.transform = CGAffineTransformMakeTranslation(-ScreenWidth * 2, 0);
    }];
}

//  头像点击事件
-(void)leftBtnClick{
    SliderMeViewController *mevc =[SliderMeViewController new];
    [self cw_showDefaultDrawerViewController:mevc];
}

// 消息点击事件
-(void)rightBtnClick{
    SliderMessageController *messageVC = [SliderMessageController new];
    [self.navigationController pushViewController:messageVC animated:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    NSLog(@"%@",touch.view);
}

// MARK: - 客源申请。 我的客源
// 由于点击事件被拦截，故此将内容放入此文件中
- (UIButton *)rightButton {
    
       if (!_rightButton) {
              _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 72,(44- 28)/2, 72, 28)];
          
          [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
          [_rightButton setTitleColor:WhiteColor forState:UIControlStateNormal];
          _rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
          [_rightButton setBackgroundColor:CHJ_RedColor];
          [_rightButton setTitle:@"我的客源" forState:UIControlStateNormal];
          
          CAShapeLayer *layer = [CXUtils maskRoundCornes:_rightButton withRadi:CGSizeMake(14, 14) withCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft];
          _rightButton.layer.mask = layer;
          _rightButton.layer.masksToBounds = YES;
       }
    return _rightButton;
    
}

- (void)rightButtonClick {
    
    YPMyKeYuan190311BaseController *my = [[YPMyKeYuan190311BaseController alloc]init];
    [self.navigationController pushViewController:my animated:YES];
}


@end
