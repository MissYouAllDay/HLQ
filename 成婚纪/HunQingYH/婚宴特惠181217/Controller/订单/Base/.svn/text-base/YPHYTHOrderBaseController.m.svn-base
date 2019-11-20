//
//  YPHYTHOrderBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/3.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderBaseController.h"
#import "NinaPagerView.h"
#import "YPHYTHOrderListController.h"

static const NSInteger topViewH = 35;

@interface YPHYTHOrderBaseController ()

@property (nonatomic, strong) NinaPagerView *pageView;

@end

@implementation YPHYTHOrderBaseController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:254/255.0 green:226/255.0 blue:233/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"平台只支持微信支付";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    label.textColor = [UIColor colorWithRed:250/255.0 green:80/255.0 blue:120/255.0 alpha:1];
    [view addSubview:label];
    [self.view addSubview:view];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(view);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(topViewH);
    }];
    
    NSArray *titleArr = @[@"全部",@"待支付",@"已付款",@"已失效"];
    NSMutableArray *vcMarr=[NSMutableArray array];
    for (NSString *str in titleArr) {
        YPHYTHOrderListController *vc = [[YPHYTHOrderListController alloc]init];
        vc.typeStr = str;
        [vcMarr addObject:vc];
    }
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+topViewH, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-topViewH) WithTitles:titleArr WithObjects:vcMarr];
        self.pageView.titleFont = 16;
        self.pageView.underlineColor = RGB(250, 80, 120);
        self.pageView.selectBottomLinePer = 0.3;
        self.pageView.selectBottomLineHeight = 3;
        [self.view addSubview:self.pageView];
    }
    
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
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
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"订单";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
