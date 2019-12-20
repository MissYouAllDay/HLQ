//
//  YPMyWalletBalanceController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletBalanceController.h"
#import "YPMyWalletBalanceTiXianController.h"//提现
#import "YPMyWalletDailyDetailController.h"//明细

@interface YPMyWalletBalanceController ()

/**余额*/
@property (nonatomic, assign) CGFloat balance;

@end

@implementation YPMyWalletBalanceController{
    UIView *_navView;
    UILabel *title;
    UILabel *balance;
    UILabel *yuan;
    UIButton *tiXianBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetUserWallet];
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
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    [test setTitle:@"明细" forState:UIControlStateNormal];
    [test setTitleColor:GrayColor forState:UIControlStateNormal];
    [test addTarget:self action:@selector(testBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:test];
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).mas_offset(10);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!title) {
        title = [[UILabel alloc]init];
    }
    title.text = @"余额";
    title.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
    }];
    
    if (!balance) {
        balance = [[UILabel alloc]init];
    }
    balance.text = [NSString stringWithFormat:@"%.2f",self.balance];
    balance.font = [UIFont boldSystemFontOfSize:45];
    [self.view addSubview:balance];
    [balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).mas_offset(85);
        make.centerX.mas_equalTo(self.view);
    }];
    
    if (!yuan) {
        yuan = [[UILabel alloc]init];
    }
    yuan.text = @"元";
    yuan.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:yuan];
    [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(balance.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(balance);
    }];
    
    if (!tiXianBtn) {
        tiXianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [tiXianBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    [tiXianBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [tiXianBtn setBackgroundColor:[UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00]];
    [tiXianBtn addTarget:self action:@selector(tiXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiXianBtn];
    tiXianBtn.layer.cornerRadius = 22.5;
    tiXianBtn.clipsToBounds = YES;
    [tiXianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(balance.mas_bottom).mas_offset(90);
    }];
    
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)testBtnClick{
    NSLog(@"明细");
    
    YPMyWalletDailyDetailController *detail = [[YPMyWalletDailyDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tiXianBtnClick{
    NSLog(@"tiXianBtnClick");
    
    YPMyWalletBalanceTiXianController *tiXian = [[YPMyWalletBalanceTiXianController alloc]init];
    [self.navigationController pushViewController:tiXian animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取我的钱包
- (void)GetUserWallet{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUserWallet";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.balance     = [[object valueForKey:@"Balance"] floatValue];
            
            [self setupUI];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
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
