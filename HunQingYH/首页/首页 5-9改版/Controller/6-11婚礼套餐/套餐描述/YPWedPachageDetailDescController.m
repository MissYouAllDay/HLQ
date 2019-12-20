//
//  YPWedPachageDetailDescController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPachageDetailDescController.h"

@interface YPWedPachageDetailDescController ()

@end

@implementation YPWedPachageDetailDescController{
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
    [backBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
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
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"套餐概述";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = BlackColor;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
    }];
    
//    UILabel *descLabel = [[UILabel alloc]init];
//    if (self.descStr.length > 0) {
//        descLabel.text = self.descStr;
//    }else{
//        descLabel.text = @"无描述";
//    }
//    descLabel.font = kNormalFont;
//    descLabel.numberOfLines = 0;
//    descLabel.textColor = GrayColor;
//    [self.view addSubview:descLabel];
//    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(24);
//        make.left.mas_equalTo(titleLabel);
//        make.right.mas_equalTo(-18);
//        make.bottom.mas_greaterThanOrEqualTo(-10);
//    }];
    
    UITextView *tw = [[UITextView alloc]init];
    if (self.descStr.length > 0) {
        tw.text = self.descStr;
    }else{
        tw.text = @"无描述";
    }
    tw.editable = NO;
    tw.font = kNormalFont;
    tw.textColor = GrayColor;
    [self.view addSubview:tw];
    [tw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(24);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-18);
        make.bottom.mas_greaterThanOrEqualTo(-10);
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
