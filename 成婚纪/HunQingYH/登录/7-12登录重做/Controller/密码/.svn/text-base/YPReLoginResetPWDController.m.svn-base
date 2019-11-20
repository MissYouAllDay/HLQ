//
//  YPReLoginResetPWDController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/13.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginResetPWDController.h"
#import "YPReLoginPwdController.h"//密码登录
#import "PasswordStrengthIndicatorView.h"//密码强度

@interface YPReLoginResetPWDController ()

@end

@implementation YPReLoginResetPWDController{
    UIView *_navView;
    UIButton *_loginBtn;
    UITextField *_pwdTF;
    
    FBShimmeringView *_shimmeringView;
    PasswordStrengthIndicatorView *_indicatorView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:250/255.0 green:80/255.0 blue:120/255.0 alpha:1];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"设置新密码";
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
    titleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//    [self.view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(view);
//        make.left.mas_equalTo(view.mas_right).mas_offset(15);
//    }];
    
    if (!_shimmeringView) {
        _shimmeringView = [[FBShimmeringView alloc] init];
    }
    _shimmeringView.shimmering = YES;
    _shimmeringView.contentView = titleLab;
    [self.view addSubview:_shimmeringView];
    [_shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(view.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *subTitleLab = [[UILabel alloc] init];
    subTitleLab.text = @"设置6-16位字母、数字密码，有助于您的账号安全";
    subTitleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    subTitleLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    subTitleLab.numberOfLines = 2;
    [self.view addSubview:subTitleLab];
    [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(15);
        make.top.mas_equalTo(_shimmeringView.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(titleLab);
    }];
    
    _pwdTF = [[UITextField alloc]init];
    _pwdTF.font = kFont(24);
    _pwdTF.placeholder = @"密码";
    _pwdTF.secureTextEntry = YES;
    _pwdTF.borderStyle = UITextBorderStyleNone;
    [_pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_pwdTF];
    [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.right.mas_equalTo(-50);
        make.top.mas_equalTo(subTitleLab.mas_bottom).mas_offset(20);
    }];
    
    UIButton *changeBtn = [[UIButton alloc]init];
    [changeBtn setImage:[UIImage imageNamed:@"pwd_look"] forState:UIControlStateNormal];
    [changeBtn setImage:[UIImage imageNamed:@"pwd_unlook"] forState:UIControlStateSelected];
    [changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_pwdTF);
        make.right.mas_equalTo(-20);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(_pwdTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    if (!_indicatorView) {
        _indicatorView = [[PasswordStrengthIndicatorView alloc]init];
    }
    [self.view addSubview:_indicatorView];
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(line);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.enabled = NO;
    [_loginBtn setImage:[UIImage imageNamed:@"upAndLogin"] forState:UIControlStateNormal];
    [_loginBtn setImage:[UIImage imageNamed:@"upAndLogin"] forState:UIControlStateHighlighted];
    [_loginBtn setImage:[UIImage imageNamed:@"upAndLogin_un"] forState:UIControlStateDisabled];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_indicatorView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(line);
    }];
    
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
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(_navView).mas_offset(15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidChange:(UITextField *)sender{

    if (sender == _pwdTF) {
        if (_pwdTF.text.length > 0) {
            _loginBtn.enabled = YES;
        }else{
            _loginBtn.enabled = NO;
        }
        
        //密码强度
        if (sender.text.length < 1) {
            _indicatorView.status = PasswordStrengthIndicatorViewStatusNone;
        }else if (sender.text.length < 6) {
            _indicatorView.status = PasswordStrengthIndicatorViewStatusWeak;
        }else if (sender.text.length < 11) {
            _indicatorView.status = PasswordStrengthIndicatorViewStatusFair;
        }else{
            _indicatorView.status = PasswordStrengthIndicatorViewStatusStrong;
        }
        
    }
}

- (void)changeBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = _pwdTF.text;
        _pwdTF.text = @""; // 这句代码可以防止切换的时候光标偏移
        _pwdTF.secureTextEntry = NO;
        _pwdTF.text = tempPwdStr;
        
    } else { // 暗文
        
        NSString *tempPwdStr = _pwdTF.text;
        _pwdTF.text = @"";
        _pwdTF.secureTextEntry = YES;
        _pwdTF.text = tempPwdStr;
    }
}

- (void)loginBtnClick{
    NSLog(@"loginBtnClick");

    [self UpdatePassWord];

}

#pragma mark - 网络请求
#pragma mark 忘记密码/修改密码
- (void)UpdatePassWord{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpdatePassWord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Phone"] = self.Phone;
    NSString *md5 = [_pwdTF.text md5String];
    params[@"Newpassword"] = md5;
    params[@"PhoneCode"] = self.PhoneCode;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            //密码修改成功
            [EasyShowTextView showText:@"密码修改成功, 请登录!" inView:self.view];
            
            YPReLoginPwdController *pwd = [[YPReLoginPwdController alloc]init];
            if (self.inType.integerValue == 3) {
                pwd.inType = @"3";/**进入方式: 1:修改密码 2:添加账号 3:添加账号中重置密码*/
            }else{
                pwd.inType = @"1";/**进入方式: 1:修改密码 2:添加账号 3:添加账号中重置密码*/
            }
            [self.navigationController pushViewController:pwd animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        //        [self showNetErrorEmptyView];
        
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
