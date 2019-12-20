//
//  YPNewMarriedController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewMarriedController.h"
#import "ZJScrollPageView.h"
#import "YPNewMarriedAnPaiController.h"
#import "YPNewMarriedLiuChengController.h"

@interface YPNewMarriedController ()<ZJScrollPageViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;
@property (nonatomic, strong) ZJContentView *content;
@property (nonatomic, strong) YPNewMarriedAnPaiController *anpaiVC;
@property (nonatomic, strong) YPNewMarriedLiuChengController *liuchengVC;

@end

@implementation YPNewMarriedController{
    UIView *_navView;
    ZJScrollSegmentView *segment;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT) segmentView:segment parentViewController:self delegate:self];
    self.content = content;
    [self.view addSubview:self.content];
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    //segment
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = NO;
    style.segmentViewBounces = NO;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.showLine = YES;
    style.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    // 显示附加的按钮
    // 设置附加按钮的背景图片
    
    self.titles = @[@"人员安排",@"婚礼流程"];
    
    __weak typeof(self) weakSelf = self;
    segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(ScreenWidth/2.0-90, 20, 180, NAVIGATION_BAR_HEIGHT-20) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
        [weakSelf.content setContentOffSet:CGPointMake(weakSelf.content.bounds.size.width * index, 0.0) animated:YES];
    }];
    [_navView addSubview:segment];
//    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_navView).mas_offset(20);
//        make.bottom.mas_equalTo(_navView);
//        make.centerX.mas_equalTo(_navView);
//        make.width.mas_equalTo(ScreenWidth-40);
//    }];
//    
//    //设置导航栏右边通知
//    UIButton *addBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setImage:[UIImage imageNamed:@"add-red"] forState:UIControlStateNormal];
//    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:addBtn];
//    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
//        make.right.mas_equalTo(self.view).mas_offset(-15);
//        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
//    }];
    
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = self.childVcs[index];
    }
    return childVc;
}

-(CGRect)frameOfChildControllerForContainer:(UIView *)containerView {
    return  CGRectInset(containerView.bounds, 20, 20);
}

//#pragma mark - 按钮点击事件
//- (void)addBtnClick{
//    NSLog(@"addBtnClick");
//}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (YPNewMarriedAnPaiController *)anpaiVC{
    if (!_anpaiVC) {
        _anpaiVC = [[YPNewMarriedAnPaiController alloc]init];
        _anpaiVC.customerID = self.customerID;
    }
    return _anpaiVC;
}

- (YPNewMarriedLiuChengController *)liuchengVC{
    if (!_liuchengVC) {
        _liuchengVC = [[YPNewMarriedLiuChengController alloc]init];
        _liuchengVC.customerID = self.customerID;
    }
    return _liuchengVC;
}

- (NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *)childVcs{
    if (!_childVcs) {
        _childVcs = [NSArray arrayWithObjects:self.anpaiVC,self.liuchengVC, nil];
    }
    return _childVcs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
