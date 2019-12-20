//
//  YPReceiveAddressSucController.m
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPReceiveAddressSucController.h"
#import "YPReceiveGiftListController.h"

@interface YPReceiveAddressSucController ()

@end

@implementation YPReceiveAddressSucController{
    UIView *_navView;
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
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left).offset(10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"领取成功";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{

    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(60);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(175, 175));
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"我们争取在最短的时间内将奖品送到您手上";
    label1.textColor = GrayColor;
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"请耐心等待";
    label2.textColor = GrayColor;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).mas_offset(8);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:WhiteColor];
    [sureBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    
}

#pragma mark - target
- (void)backVC{
    
//    UIViewController *mineVC = nil;
//    for (UIViewController * controller in self.navigationController.viewControllers) {
//        //遍历
//        if([controller isKindOfClass:[YPReceiveGiftListController class]]){
//            //这里判断是否为你想要跳转的页面
//            mineVC = controller;
//            break;
//        }
//    }
//    [self.navigationController popToViewController:mineVC  animated:YES];
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
