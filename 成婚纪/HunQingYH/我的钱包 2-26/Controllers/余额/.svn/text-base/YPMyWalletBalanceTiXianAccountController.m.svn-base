//
//  YPMyWalletBalanceTiXianAccountController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletBalanceTiXianAccountController.h"

@interface YPMyWalletBalanceTiXianAccountController ()

@property (nonatomic, strong) JVFloatLabeledTextField *inputTF;

@end

@implementation YPMyWalletBalanceTiXianAccountController{
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
    [backBtn setImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal];
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
    title.text = @"请输入支付宝账号";
    title.font = [UIFont boldSystemFontOfSize:32];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(25);
    }];
    
    self.inputTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.inputTF.font = kBiggistFont;
    self.inputTF.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"输入账号", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    
    self.inputTF.floatingLabelFont = kNormalFont;
    self.inputTF.floatingLabelTextColor = [UIColor brownColor];
    self.inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.inputTF];
    self.inputTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputTF.keepBaseline = YES;
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(title.mas_bottom).mas_offset(75);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(45);
    }];
    
    UIView *div1 = [[UIView alloc]init];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.inputTF);
        make.right.mas_equalTo(self.inputTF);
        make.top.mas_equalTo(self.inputTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00]];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    saveBtn.layer.cornerRadius = 22.5;
    saveBtn.clipsToBounds = YES;
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.inputTF.mas_bottom).mas_offset(70);
    }];
    
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick{
    NSLog(@"saveBtnClick");
    
    if (self.inputTF.text.length > 0) {
        if ([self.accountDelete respondsToSelector:@selector(yp_tixianAccount:)]) {
            [self.accountDelete yp_tixianAccount:self.inputTF.text];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [EasyShowTextView showText:@"请输入支付宝账号" inView:self.view];
    }

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
