//
//  YPReLoginController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginController.h"
#import <AudioToolbox/AudioToolbox.h>//提示音
#import <HMSegmentedControl.h>
#import "YPReLoginSoonView.h"
#import "YPReLoginPwdView.h"
#import "YPReLoginOtherWayView.h"
#import "LCTabBarController.h"
#import "YYKit.h"

@interface YPReLoginController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YPReLoginController{
    UIView *_navView;;
    
    __block NSInteger flag;//网络请求成功为1 不成功为0
    __block NSString *errorStr;//网络请求后中赋值
    
    __block YPReLoginSoonView *_soonV;
    __block YPReLoginPwdView *_pwdV;
    __block YPReLoginOtherWayView *_otherV;
    
    LCTabBarController *tabBarC;
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
    
    self.view.backgroundColor = WhiteColor;
    
    flag = 0;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
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

- (void)setupUI{
    
    [self.segment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = WhiteColor;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(300);
    }];
    
    //MARK: 快速登录
    if (!_soonV) {
        _soonV = [[YPReLoginSoonView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 400)];
    }
    
    typeof(_soonV) __weak WeakSoonV = _soonV;
    typeof(self) __weak weakSelf = self;
    typeof(errorStr) __weak ErrorStr = errorStr;
    
    _soonV.smsBlock = ^(YPReCountButton *smsBtn) {
        NSLog(@"smssmssms --- %@ --- %@",smsBtn.tfText,WeakSoonV.smsTF.text);
    };
    
    _soonV.loginBlock = ^(HRLoginButton *loginBtn) {
        
        if ([WeakSoonV.phoneTF.text isEqualToString:@""]) {
            
            [loginBtn failedAnimationWithCompletion:^{
                
                [weakSelf didPresentControllerButtonTouch];
                
            }];
            //震动提醒
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"手机号不能为空" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else if ([WeakSoonV.smsTF.text isEqualToString:@""]){

            [loginBtn failedAnimationWithCompletion:^{
                [weakSelf didPresentControllerButtonTouch];
            }];
            //震动提醒
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"验证码不能为空" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else{
            
            NSLog(@"进入登录请求阶段");
            
            //网络请求
//            [self SupplierLogin];
            
            [WeakSoonV.phoneTF resignFirstResponder];
            [WeakSoonV.smsTF resignFirstResponder];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (flag ==1) {
                    //网络正常 或者是密码账号正确跳转动画
                    [loginBtn succeedAnimationWithCompletion:^{
                        
                        [weakSelf didPresentControllerButtonTouch];
                        
                    }];
                } else {
                    //网络错误 或者是密码不正确还原动画
                    [loginBtn failedAnimationWithCompletion:^{
                        
                        [weakSelf didPresentControllerButtonTouch];
                        
                    }];
                    //震动提醒
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:ErrorStr delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                    
                }
            });
            
        }
    };
    
    [self.scrollView addSubview:_soonV];
    
    //MARK: 密码登录
    if (!_pwdV) {
        _pwdV = [[YPReLoginPwdView alloc]initWithFrame:CGRectMake(ScreenWidth - 100, 0, ScreenWidth - 100, 400)];
    }
    
    typeof(_pwdV) __weak WeakPwdV = _pwdV;
    _pwdV.loginBlock = ^(HRLoginButton *loginBtn) {
        
        if ([WeakPwdV.phoneTF.text isEqualToString:@""]) {
            
            [loginBtn failedAnimationWithCompletion:^{
                
                [weakSelf didPresentControllerButtonTouch];
                
            }];
            //震动提醒
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"手机号不能为空" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else if ([WeakPwdV.pwdTF.text isEqualToString:@""]){
            
            [loginBtn failedAnimationWithCompletion:^{
                [weakSelf didPresentControllerButtonTouch];
            }];
            //震动提醒
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else{
            
            NSLog(@"进入登录请求阶段");
            
            //网络请求
            //            [self SupplierLogin];
            
            [WeakPwdV.phoneTF resignFirstResponder];
            [WeakPwdV.pwdTF resignFirstResponder];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (flag ==1) {
                    //网络正常 或者是密码账号正确跳转动画
                    [loginBtn succeedAnimationWithCompletion:^{
                        
                        [weakSelf didPresentControllerButtonTouch];
                        
                    }];
                } else {
                    //网络错误 或者是密码不正确还原动画
                    [loginBtn failedAnimationWithCompletion:^{
                        
                        [weakSelf didPresentControllerButtonTouch];
                        
                    }];
                    //震动提醒
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:ErrorStr delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                    
                }
            });
            
        }
    };
    
    _pwdV.forgetBlock = ^{
        NSLog(@"忘记密码");
    };
    
    [self.scrollView addSubview:_pwdV];
    
    //MARK: 底部
    if (!_otherV) {
        _otherV = [YPReLoginOtherWayView yp_reLoginOtherWayView];
    }
    _otherV.btnClickBlock = ^(NSString *btnClass) {
        if ([btnClass isEqualToString:@"qq"]) {
            NSLog(@"qq");
        }else if ([btnClass isEqualToString:@"wechat"]){
            NSLog(@"wechat");
        }else if ([btnClass isEqualToString:@"protocol"]){
            NSLog(@"protocol");
        }
    };
    [self.view addSubview:_otherV];
    [_otherV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom).mas_offset(15);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX < (ScreenWidth - 100)) {
        [self.segment setSelectedSegmentIndex:0 animated:YES];
    }else{
        [self.segment setSelectedSegmentIndex:1 animated:YES];
    }
    
}

#pragma mark - target
- (void)segmentedControlChangedValue:(HMSegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        [self.scrollView scrollToLeft];
    }else{
        [self.scrollView scrollToRight];
    }
    
}

- (void)didPresentControllerButtonTouch {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"loginSuccess" object:self];
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (!tabBarC) {
        
        tabBarC = [[LCTabBarController alloc]init];
        
    }
}

#pragma mark - 网络请求
#pragma mark 获取验证码
- (void)getSMSCodeRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/GetSMSCode";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserType"] = @"1"; //0公司、1供应商
    params[@"Phone"] = _soonV.phoneTF.text;
    params[@"Type"] = @"0"; //0注册、 1重置登陆密码、2激活、3更换手机号
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"获取验证码成功"];
            
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

#pragma mark 校验验证码
- (void)verifySMSCodeRequest{
    
    //    [[DLProgressHUD shareManager] showWithMessage:nil type:DLProgressHUDTypeLoading];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/VerifySMSCode";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = _soonV.phoneTF.text;
    params[@"Type"] = @"0";//0注册、 1重置登陆密码、2激活、3更换手机号
    params[@"SMSCode"] = _soonV.smsTF.text;
    params[@"UserType"] = @"1";  //0公司、1供应商
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

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
- (HMSegmentedControl *)segment{
    if (!_segment) {
        _segment = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"快速登录",@"密码登录"]];
        _segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segment.selectionIndicatorColor = NavBarColor;
        _segment.titleTextAttributes = @{NSForegroundColorAttributeName:LightGrayColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:28]};
        _segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:BlackColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:28]};
        _segment.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 40);
    }
    return _segment;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake((ScreenWidth - 100)*2, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
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
