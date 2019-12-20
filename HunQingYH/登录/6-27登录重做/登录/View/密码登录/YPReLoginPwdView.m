//
//  YPReLoginPwdView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginPwdView.h"

@implementation YPReLoginPwdView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = WhiteColor;
    
    //手机号
    if (!self.phoneTF) {
        self.phoneTF = [[UITextField alloc]init];
        self.phoneTF.placeholder = @"请输入手机号码";
        self.phoneTF.font = [UIFont systemFontOfSize:20];
        self.phoneTF.borderStyle = UITextBorderStyleNone;
        [self addSubview:self.phoneTF];
        [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    
    UIView *div1 = [[UIView alloc]init];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTF);
        make.right.mas_equalTo(self.phoneTF);
        make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(2);
    }];
    
    //密码
    if (!self.pwdTF) {
        self.pwdTF = [[UITextField alloc]init];
        self.pwdTF.placeholder = @"请输入密码";
        self.pwdTF.font = [UIFont systemFontOfSize:20];
        self.pwdTF.borderStyle = UITextBorderStyleNone;
        [self addSubview:self.pwdTF];
        [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(div1.mas_bottom).mas_offset(35);
            make.left.right.mas_equalTo(div1);
        }];
    }
    
    UIView *div2 = [[UIView alloc]init];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    [div2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(div1);
        make.top.mas_equalTo(self.pwdTF.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(2);
    }];
    
    //登录按钮
    if (!self.loginButton) {
        self.loginButton = [[HRLoginButton alloc] initWithFrame:CGRectMake(20, 220, ScreenWidth-150, 45)];
    }
    self.loginButton.centerX = self.centerX;
    [self.loginButton setBackgroundColor:WhiteColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:BlackColor forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginButton];
    self.loginButton.layer.cornerRadius = 45/2;
    self.loginButton.clipsToBounds = YES;
    self.loginButton.layer.borderColor = LightGrayColor.CGColor;
    self.loginButton.layer.borderWidth = 1;
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(div2.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(div2);
        make.width.mas_equalTo(ScreenWidth-150);
        make.height.mas_equalTo(45);
    }];
    
    //忘记密码
    if (!self.forgetBtn) {
        self.forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loginButton.frame)+25, 70, 25)];
    }
    self.forgetBtn.x = CGRectGetMaxX(self.loginButton.frame)-70;
    [self.forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = kNormalFont;
    [self.forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(25);
        make.right.mas_equalTo(self.loginButton);
    }];
}

#pragma mark - target
- (void)PresentViewController:(HRLoginButton *)sender{
    
    if (self.loginBlock) {
        self.loginBlock(sender);
    }
    
}

- (void)forgetBtnClick{
    if (self.forgetBlock) {
        self.forgetBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
