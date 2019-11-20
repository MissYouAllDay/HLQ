//
//  YPMyWalletTiXianSucController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletTiXianSucController.h"
#import "YPMyWalletBalanceController.h"

@interface YPMyWalletTiXianSucController ()

@end

@implementation YPMyWalletTiXianSucController{
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
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];

}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"提现申请已提交";
    title.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"提现_suc"]];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).mas_offset(55);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00]];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    doneBtn.layer.cornerRadius = 22.5;
    doneBtn.clipsToBounds = YES;
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(90);
    }];
    
}
#pragma mark - target
- (void)backVC{
    UIViewController *mineVC = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        //遍历
        if([controller isKindOfClass:[YPMyWalletBalanceController class]]){
            //这里判断是否为你想要跳转的页面
            mineVC = controller;
            break;
        }
    }
    [self.navigationController popToViewController:mineVC  animated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    UIViewController *mineVC = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        //遍历
        if([controller isKindOfClass:[YPMyWalletBalanceController class]]){
            //这里判断是否为你想要跳转的页面
            mineVC = controller;
            break;
        }
    }
    [self.navigationController popToViewController:mineVC  animated:YES];
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
