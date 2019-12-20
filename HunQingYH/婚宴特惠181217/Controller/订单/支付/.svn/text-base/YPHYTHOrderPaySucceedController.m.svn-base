//
//  YPHYTHOrderPaySucceedController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderPaySucceedController.h"
#import "YPHYTHOrderPaySucceedView.h"
#import "YPHYTHOrderBaseController.h"

@interface YPHYTHOrderPaySucceedController ()

@end

@implementation YPHYTHOrderPaySucceedController{
    UIView *_navView;
    YPHYTHOrderPaySucceedView *_sucV;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    
    if (!_sucV) {
        _sucV = [YPHYTHOrderPaySucceedView yp_orderPaySucceedView];
    }
    [self.view addSubview:_sucV];
    _sucV.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.12].CGColor;
    _sucV.layer.shadowOffset = CGSizeMake(0,0);
    _sucV.layer.shadowOpacity = 1;
    _sucV.layer.shadowRadius = 8;
    [_sucV.doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sucV.afterBtn addTarget:self action:@selector(afterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sucV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
    }];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
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
    titleLab.text = @"支付";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - target
- (void)backVC{
    [self afterBtnClick];
}

- (void)doneBtnClick{
    [self UpdatePreferentialOrderUndertakeTypeWithType:@"1"];
}

- (void)afterBtnClick{
    [self UpdatePreferentialOrderUndertakeTypeWithType:@"0"];
}

#pragma mark - 网络请求
#pragma mark 承办婚礼状态修改
- (void)UpdatePreferentialOrderUndertakeTypeWithType:(NSString *)type{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpdatePreferentialOrderUndertakeType";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.recordID;
    params[@"Type"] = type;//0不承办,1承办
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showText:@"预约成功，客服稍后将会联系您" inView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *mineVC = nil;
            for (UIViewController * controller in self.navigationController.viewControllers) {
                //遍历
                if([controller isKindOfClass:[YPHYTHOrderBaseController class]]){
                    //这里判断是否为你想要跳转的页面
                    mineVC = controller;
                    break;
                }
            }
            [self.navigationController popToViewController:mineVC  animated:YES];
        });
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络请求错误,请稍后重试!" inView:self.view];
        
    }];
    
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
