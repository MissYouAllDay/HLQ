//
//  YPAddAnliController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/2.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddAnliController.h"
#import "YPAddAnliBtnView.h"
#import "YPAddAnliDetailController.h"
#import "HRAddAnLiViewController.h"
@interface YPAddAnliController ()

@end

@implementation YPAddAnliController{
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
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
    titleLab.text = @"我的案例";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
 
    
}

- (void)setupUI{
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    YPAddAnliBtnView *addView = [YPAddAnliBtnView addAnliBtnView];
    [self.view addSubview:addView];
    [addView.videoBtn addTarget:self action:@selector(videoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addView.imgBtn addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(200);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(130);
    }];
    
}

#pragma mark - target
- (void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - target
- (void)videoBtnClick{
    
    HRAddAnLiViewController *detail = [[HRAddAnLiViewController alloc]init];
    detail.type = @"上传视频";
    detail.leixingStr =@"1";
    [self.navigationController yp_pushViewController:detail animated:YES];
}

- (void)imgBtnClick{
    
    HRAddAnLiViewController *detail = [[HRAddAnLiViewController alloc]init];
    detail.type = @"上传图片";
     detail.leixingStr =@"1";
    [self.navigationController yp_pushViewController:detail animated:YES];
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
