//
//  YPPopCornVoucherController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPPopCornVoucherController.h"
#import "YPPopCornVoucherView.h"

@interface YPPopCornVoucherController ()

@end

@implementation YPPopCornVoucherController{
    UIView *_navView;
    YPPopCornVoucherView *_voucherView;
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
    
    [self setupNav];
    [self setupUI];
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
//    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:backBtn];
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 20));
//        make.left.mas_equalTo(_navView.mas_left);
//        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
//    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"爆米花兑换券";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(titleLab);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;

    if (!_voucherView) {
        _voucherView = [YPPopCornVoucherView yp_popCornVoucherView];
    }
    [self.view addSubview:_voucherView];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy年MM月dd日 HH:mm:ss";
    
    NSDate *date = [NSDate date];
    NSString *dateStr = [format stringFromDate:date];
    _voucherView.timeLabel.text = dateStr;
    
    [_voucherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - target
- (void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
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
