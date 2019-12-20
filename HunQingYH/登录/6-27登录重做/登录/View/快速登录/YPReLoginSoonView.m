//
//  YPReLoginSoonView.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginSoonView.h"

@implementation YPReLoginSoonView

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
    
    //验证码按钮
    if (!self.smsBtn) {
        self.smsBtn = [YPReCountButton buttonWithType:UIButtonTypeCustom];
    }
    self.smsBtn.countdownBeginNumber = 60;
    self.smsBtn.delegate = self;
    
    [self.smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.smsBtn.titleLabel.font = kSmallFont;
    self.smsBtn.backgroundColor = WhiteColor;
    [self addSubview:self.smsBtn];
    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(div1);
        make.top.mas_equalTo(div1.mas_bottom).mas_offset(28);
        make.width.mas_equalTo(90);
    }];
    
    //验证码
    if (!self.smsTF) {
        self.smsTF = [[UITextField alloc]init];
        self.smsTF.placeholder = @"请输入验证码";
        self.smsTF.font = [UIFont systemFontOfSize:20];
        self.smsTF.borderStyle = UITextBorderStyleNone;
        [self addSubview:self.smsTF];
        [self.smsTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(div1.mas_bottom).mas_offset(35);
            make.left.mas_equalTo(div1);
            make.right.mas_equalTo(self.smsBtn.mas_left).mas_offset(5);
        }];
    }
    
    UIView *div2 = [[UIView alloc]init];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    [self addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    [div2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(div1);
        make.top.mas_equalTo(self.smsTF.mas_bottom).mas_offset(15);
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
}

#pragma mark - target
- (void)PresentViewController:(HRLoginButton *)sender{
    
    if (self.loginBlock) {
        self.loginBlock(sender);
    }
    
}

#pragma mark - CountButtonDelegate
- (void)countButtonClicked{
    NSLog(@"CountButtonDelegate");
    
    self.smsBtn.tfText = self.phoneTF.text;
    if (self.phoneTF.text.length>0) {
        self.smsBlock(self.smsBtn);
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
