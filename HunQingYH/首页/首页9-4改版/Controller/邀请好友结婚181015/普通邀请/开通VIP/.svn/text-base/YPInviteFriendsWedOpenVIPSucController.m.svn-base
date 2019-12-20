//
//  YPInviteFriendsWedOpenVIPSucController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/16.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedOpenVIPSucController.h"
#import "YPInviteFriendsWedNormalController.h"

@interface YPInviteFriendsWedOpenVIPSucController ()

@end

@implementation YPInviteFriendsWedOpenVIPSucController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //    [self GetWeChatActivityList];
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
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IFW_openVIPSuc"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80+NAVIGATION_BAR_HEIGHT);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"申请提交成功，等待审核";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"开通VIP邀请权限";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = kFont(15);
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(-18);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeBtnClick{
    UIViewController *mineVC = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        //遍历
        if([controller isKindOfClass:[YPInviteFriendsWedNormalController class]]){
            //这里判断是否为你想要跳转的页面
            mineVC = controller;
            break;
        }
    }
    [self.navigationController popToViewController:mineVC  animated:YES];
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
