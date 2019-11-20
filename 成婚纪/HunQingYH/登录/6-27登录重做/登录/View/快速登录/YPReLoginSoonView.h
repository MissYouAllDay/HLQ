//
//  YPReLoginSoonView.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YPCountButton.h"
#import "YPReCountButton.h"
#import "HRLoginButton.h"//登录按钮

typedef void(^SmsBlock)(YPReCountButton *smsBtn);
typedef void(^LoginBlock)(HRLoginButton *loginBtn);

@interface YPReLoginSoonView : UIView <CountButtonDelegate>

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *smsTF;
@property (nonatomic, strong) YPReCountButton *smsBtn;
//登录按钮
@property (nonatomic, strong) HRLoginButton *loginButton;

@property (nonatomic, copy) SmsBlock smsBlock;
@property (nonatomic, copy) LoginBlock loginBlock;

@end
