//
//  YPReLoginPwdView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRLoginButton.h"//登录按钮

typedef void(^LoginBlock)(HRLoginButton *loginBtn);
typedef void(^ForgetBlock)();

@interface YPReLoginPwdView : UIView

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *pwdTF;
//登录按钮
@property (nonatomic, strong) HRLoginButton *loginButton;
@property (nonatomic, strong) UIButton *forgetBtn;

@property (nonatomic, copy) LoginBlock loginBlock;
@property (nonatomic, copy) ForgetBlock forgetBlock;

@end
