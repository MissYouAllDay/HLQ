//
//  YPReLoginBindPhoneController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginBindPhoneController.h"
#import "XWCountryCodeController.h"
#import "YPReLoginSMSController.h"//验证码

@interface YPReLoginBindPhoneController ()

@end

@implementation YPReLoginBindPhoneController{
    UIView *_navView;
    NSString *_countryNum;//国家码
    UIButton *_countryNumBtn;
    UIButton *_loginBtn;
    UITextField *_phoneTF;
    
    FBShimmeringView *_shimmeringView;
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
    
    _countryNum = @"+86";
    
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
    titleLab.text = @"绑定手机号";
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
    subTitleLab.text = @"为了您的安全，首次登录还需绑定您的手机号";
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
    
    _countryNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_countryNumBtn setTitle:_countryNum forState:UIControlStateNormal];
    [_countryNumBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    _countryNumBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    [_countryNumBtn addTarget:self action:@selector(countryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_countryNumBtn];
    [_countryNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subTitleLab.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(subTitleLab);
        make.width.mas_equalTo(70);
    }];
    
    UIImageView *subImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"三角下标"]];
    [self.view addSubview:subImgV];
    [subImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_countryNumBtn.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(_countryNumBtn).mas_offset(10);
        make.width.height.mas_equalTo(10);
    }];
    
    _phoneTF = [[UITextField alloc]init];
    _phoneTF.font = kFont(24);
    _phoneTF.placeholder = @"输入手机号";
    _phoneTF.borderStyle = UITextBorderStyleNone;
    [_phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_countryNumBtn);
        make.left.mas_equalTo(subImgV.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(_phoneTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.enabled = NO;
    [_loginBtn setImage:[UIImage imageNamed:@"loginBtnBackG_enable"] forState:UIControlStateNormal];
    [_loginBtn setImage:[UIImage imageNamed:@"loginBtnBackG_enable"] forState:UIControlStateHighlighted];
    [_loginBtn setImage:[UIImage imageNamed:@"loginBtnBackG_disable"] forState:UIControlStateDisabled];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(20);
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

- (void)countryBtnClick{
    NSLog(@"countryBtnClick");
    
    XWCountryCodeController *countryCodeVC = [[XWCountryCodeController alloc] init];
    
    //block
    [countryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
        
        NSArray *arr = [countryCodeStr componentsSeparatedByString:@" "];
        _countryNum = arr[1];
        [_countryNumBtn setTitle:arr[1] forState:UIControlStateNormal];
    }];
    
    [self presentViewController:countryCodeVC animated:YES completion:nil];
}

- (void)loginBtnClick{
    NSLog(@"loginBtnClick");
       if ([self phoneNumberIsTrue:_phoneTF.text]) {
           YPReLoginSMSController *sms = [[YPReLoginSMSController alloc]init];
           sms.phoneStr = [NSString stringWithFormat:@"%@ %@",_countryNum,_phoneTF.text];
           sms.smsType = @"3";/**标识 登录:1 忘记密码:2 绑定手机号/微信登录:3*/
           sms.openId = self.openId;
           sms.tokenCode = self.tokenCode;
           [self.navigationController pushViewController:sms animated:YES];
       }else{
           [EasyShowTextView showText:@"请输入正确的手机号"];
       }
  
}

- (void)textFieldDidChange:(UITextField *)sender{
    if (sender == _phoneTF) {
         if (_phoneTF.text.length > 0 && _phoneTF.text.length == 11) {
            _loginBtn.enabled = YES;
        }else{
            _loginBtn.enabled = NO;
        }
    }
}
-(BOOL)phoneNumberIsTrue:(NSString *)mobile{
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        
        return NO;
        
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
        
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
