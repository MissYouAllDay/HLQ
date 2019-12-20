//
//  YPInviteFriendsWedVIPSucController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedVIPSucController.h"
#import "YPInviteFriendsWedVIPRecordController.h"

@interface YPInviteFriendsWedVIPSucController ()

@end

@implementation YPInviteFriendsWedVIPSucController{
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
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
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
    titleLab.text = @"VIP邀请";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IFW_VIPSuc"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(94+NAVIGATION_BAR_HEIGHT);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"邀请提交成功，等待审核";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV.mas_bottom).mas_offset(32);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *recordBtn = [[UIButton alloc]init];
    [recordBtn setTitle:@"查看我的邀请记录" forState:UIControlStateNormal];
    [recordBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    recordBtn.titleLabel.font = kFont(16);
    recordBtn.layer.cornerRadius = 2;
    recordBtn.clipsToBounds = YES;
    recordBtn.layer.borderWidth = 1;
    recordBtn.layer.borderColor = RGBS(221).CGColor;
    [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(48);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)recordBtnClick{
    YPInviteFriendsWedVIPRecordController *record = [[YPInviteFriendsWedVIPRecordController alloc]init];
    [self.navigationController pushViewController:record animated:YES];
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
