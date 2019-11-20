//
//  YPFirstViewController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPFirstViewController.h"
#import "YPFirstBtnView.h"
//#import "YPReLoginController.h"
#import "YPRegisterController.h"
#import "YPRegistStep1Controller.h"//5-21 婚庆端注册

@interface YPFirstViewController ()

@end

@implementation YPFirstViewController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first-Backgroung"]];
    backImgV.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:backImgV];
    
    YPFirstBtnView *firstBtnView = [YPFirstBtnView firstView];
    [self.view addSubview:firstBtnView];
    [firstBtnView.loversBtn addTarget:self action:@selector(loversBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [firstBtnView.serviceBtn addTarget:self action:@selector(serviceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //11.13 修改 -- 5-21 修改为婚庆端注册
//    firstBtnView.companybtn.hidden = YES;
//    firstBtnView.companyTitle.hidden = YES;
//    firstBtnView.companyEnglish.hidden = YES;
//    firstBtnView.companyBack.hidden = YES;
    
    [firstBtnView.companybtn addTarget:self action:@selector(companybtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [firstBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(220);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(225);
    }];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.top.mas_equalTo(self.view).mas_offset(30);
    }];
    
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loversBtnClick{
    NSLog(@"loversBtnClick");
//    YPReLoginController *login = [[YPReLoginController alloc]init];
//    login.loginClass = @"1";//新婚燕尔
//    [self.navigationController pushViewController:login animated:YES];
    
    //11.13 修改
    YPRegisterController *regist = [[YPRegisterController alloc]init];
    regist.loginClass = @"1";//新婚燕尔
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)serviceBtnClick{
    NSLog(@"serviceBtnClick");
//    YPReLoginController *login = [[YPReLoginController alloc]init];
//    login.loginClass = @"2";//婚庆服务商
//    [self.navigationController pushViewController:login animated:YES];
    
    //11.13 修改
    YPRegisterController *regist = [[YPRegisterController alloc]init];
    regist.loginClass = @"2";//婚庆服务商
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)companybtnClick{
    NSLog(@"companybtnClick");
    
    //婚庆端注册
    //5-21 修改
    YPRegistStep1Controller *regist = [[YPRegistStep1Controller alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
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
