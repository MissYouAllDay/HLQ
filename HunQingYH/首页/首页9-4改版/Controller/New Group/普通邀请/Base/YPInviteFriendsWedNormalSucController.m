//
//  YPInviteFriendsWedNormalSucController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/16.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedNormalSucController.h"
#import <ASGradientLabel.h>

@interface YPInviteFriendsWedNormalSucController ()

@end

@implementation YPInviteFriendsWedNormalSucController{
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

- (void)setupUI{
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IFWNormal_Suc"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54+NAVIGATION_BAR_HEIGHT);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"恭喜您";
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
    }];
    
    ASGradientLabel *numberLabel = [[ASGradientLabel alloc]init];
    numberLabel.text = [NSString stringWithFormat:@"%@",self.rankStr];
    numberLabel.font = [UIFont systemFontOfSize:48 weight:UIFontWeightHeavy];
    numberLabel.colors = @[(id)RGBA(255, 163, 89, 1).CGColor, (id)RGBA(255, 93, 118, 1).CGColor];
    numberLabel.startPoint = CGPointMake(0, 0);
    numberLabel.endPoint = CGPointMake(1, 0);
    numberLabel.locations = @[@0 ,@1];
    [self.view addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(-30);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"您是第";
    label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(numberLabel.mas_left).mas_offset(-18);
        make.bottom.mas_equalTo(numberLabel.mas_bottom).mas_offset(-5);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"位邀请TA的人";
    label3.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    label3.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberLabel.mas_right).mas_offset(18);
        make.bottom.mas_equalTo(numberLabel.mas_bottom).mas_offset(-5);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"一旦ta通过审核，您即可获得奖励";
    label4.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    label4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numberLabel.mas_bottom).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *continueBtn = [[UIButton alloc]init];
    [continueBtn setTitle:@"继续邀请" forState:UIControlStateNormal];
    [continueBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    continueBtn.titleLabel.font = kFont(16);
    continueBtn.layer.cornerRadius = 2;
    continueBtn.clipsToBounds = YES;
    continueBtn.layer.borderWidth = 1;
    continueBtn.layer.borderColor = RGBS(221).CGColor;
    [continueBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label4.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(48);
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
    titleLab.text = @"邀请成功";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

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
