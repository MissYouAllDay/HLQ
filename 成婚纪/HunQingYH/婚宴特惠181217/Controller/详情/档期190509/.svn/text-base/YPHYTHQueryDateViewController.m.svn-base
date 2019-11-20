//
//  YPHYTHQueryDateViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/9.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHQueryDateViewController.h"
#import "NinaPagerView.h"
#import "YPHYTHQueryDateSubViewController.h"

@interface YPHYTHQueryDateViewController ()

@property (nonatomic, strong) NinaPagerView *pageView;
@property (nonatomic, strong) NSMutableArray *tingMarr;

@end

@implementation YPHYTHQueryDateViewController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).mas_offset(18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    NSMutableArray *vcMarr=[NSMutableArray array];
    
    for (NSString *str in self.tingMarr) {
        YPHYTHQueryDateSubViewController *vc = [[YPHYTHQueryDateSubViewController alloc]init];
        [vcMarr addObject:vc];
    }
    
    if (!self.pageView) {
        self.pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) WithTitles:self.tingMarr WithObjects:vcMarr];
        self.pageView.titleFont = 15;
        self.pageView.underlineColor = RGB(236, 67, 86);
        [self.view addSubview:self.pageView];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (NSMutableArray *)tingMarr{
    if (!_tingMarr) {
        _tingMarr = [NSMutableArray arrayWithArray:@[@"坤悦厅",@"签约厅",@"坤悦厅",@"签约厅"]];
    }
    return _tingMarr;
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
