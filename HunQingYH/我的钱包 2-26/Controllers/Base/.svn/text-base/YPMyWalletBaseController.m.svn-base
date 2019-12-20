//
//  YPMyWalletBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletBaseController.h"
#import "YPMyWalletBalanceView.h"
#import "YPMyWalletYouHuiQuanView.h"
#import "YPMyWalletBalanceController.h"//余额
#import "YPMyWalletCouponController.h"//优惠券

@interface YPMyWalletBaseController ()

/**余额*/
@property (nonatomic, strong) YPMyWalletBalanceView *balanceView;
/**优惠券*/
@property (nonatomic, strong) YPMyWalletYouHuiQuanView *yhqView;

/**余额*/
@property (nonatomic, assign) CGFloat balance;
/**优惠券数量*/
@property (nonatomic, assign) NSInteger couponCount;

@end

@implementation YPMyWalletBaseController{
    UIView *_navView;
    UILabel *_title;
    UIButton *_yhqMaskBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self GetUserWallet];
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
    
//    UILabel *label = [[UILabel alloc]init];
//    label.text = @"暂无数据!";
//    label.textColor = GrayColor;
//    [self.view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//    }];
    
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
    
    if (!_title) {
        _title = [[UILabel alloc]init];
    }
    _title.text = @"我的钱包";
    _title.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(24);
    }];
    
    [self.view addSubview:self.balanceView];
    
    self.balanceView.balance.text = [NSString stringWithFormat:@"%.2f",self.balance];
    
    [self.balanceView.tiXianBtn addTarget:self action:@selector(tiXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_title.mas_bottom).mas_offset(40);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    [self.view addSubview:self.yhqView];
    
    self.yhqView.count.text = [NSString stringWithFormat:@"%zd",self.couponCount];
    
    if (!_yhqMaskBtn) {
        _yhqMaskBtn = [[UIButton alloc]init];
    }
    [_yhqMaskBtn addTarget:self action:@selector(yhqMaskBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.yhqView addSubview:_yhqMaskBtn];
    [_yhqMaskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.yhqView);
    }];
    [self.yhqView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.balanceView.mas_bottom).mas_offset(30);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tiXianBtnClick{
    NSLog(@"tiXianBtnClick");
    
    YPMyWalletBalanceController *balance = [[YPMyWalletBalanceController alloc]init];
    [self.navigationController pushViewController:balance animated:YES];
}

- (void)yhqMaskBtnClick{
    NSLog(@"yhqMaskBtnClick");
    
    YPMyWalletCouponController *coupon = [[YPMyWalletCouponController alloc]init];
    [self.navigationController pushViewController:coupon animated:YES];
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
            self.couponCount = [[object valueForKey:@"CouponCount"] integerValue];
            
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

#pragma mark - getter
- (YPMyWalletBalanceView *)balanceView{
    if (!_balanceView) {
        _balanceView = [YPMyWalletBalanceView yp_MyWalletBalanceView];
    }
    return _balanceView;
}

- (YPMyWalletYouHuiQuanView *)yhqView{
    if (!_yhqView) {
        _yhqView = [YPMyWalletYouHuiQuanView yp_MyWalletYouHuiQuanView];
    }
    return _yhqView;
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
