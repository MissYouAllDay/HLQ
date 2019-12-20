//
//  YPHunJJTicketDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHunJJTicketDetailController.h"
#import "YPHunJJTicketVerifyView.h"
#import "HMScannerController.h"//二维码

@interface YPHunJJTicketDetailController ()

@end

@implementation YPHunJJTicketDetailController{
    UIView *_navView;
    YPHunJJTicketVerifyView *_verifyV;
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
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
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"门票验证";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!_verifyV) {
        _verifyV = [YPHunJJTicketVerifyView yp_ticketVerifyView];
    }
    [self.view addSubview:_verifyV];
    
//    NSString *cardName = [NSString stringWithFormat:@"https://u.wechat.com/%@",self.ticketModel.ATQR];
    NSString *cardName = self.ticketModel.ATQR;
    //https://u.wechat.com/MLwJjVQ0UeL0Qigha1ihSag
//    UIImage *avatar = [UIImage imageNamed:@"分享图标"];
    
    [HMScannerController cardImageWithCardName:cardName avatar:nil scale:0.2 completion:^(UIImage *image) {
        _verifyV.codeImgV.image = image;
    }];
    
    _verifyV.deadLine.text = self.ticketModel.Deadline;
    _verifyV.numLabel.text = self.ticketModel.ATNumber;
    _verifyV.buyTime.text = self.ticketModel.CreateTime;
    _verifyV.address.text = self.ticketModel.Place;
    if ([self.ticketModel.IsUse integerValue] == 0) {//0未使用 1已使用
        _verifyV.useState.text = @"未使用";
    }else{
        _verifyV.useState.text = @"已使用";
    }
    
    [_verifyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
