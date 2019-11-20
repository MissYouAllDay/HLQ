//
//  YPLoginController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPLoginController.h"
#import <AudioToolbox/AudioToolbox.h>//提示音
#import "JVFloatLabeledTextField.h"//输入框
#import "HRLoginButton.h"//登录按钮
#import "YPRegisterController.h"//注册
#import "YPForgetController.h"//忘记密码
#import "YPLoginModel.h"//模型
#import "LCTabBarController.h"
#import "YPMeController.h"//我的
#import "YPFirstViewController.h"//11.13 选择身份

@interface YPLoginController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *userIcon;

@property (nonatomic, strong) JVFloatLabeledTextField *accountTF;
@property (nonatomic, strong) JVFloatLabeledTextField *pswTF;

//登录按钮
@property (nonatomic, strong) HRLoginButton *loginButton;

@property (nonatomic, strong) YPLoginModel *loginModel;

@end

@implementation YPLoginController{
    UIView *_navView;
    NSInteger flag;//网络请求成功为1 不成功为0
    NSString *errorStr;//网络请求后中赋值
    
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    [self setupNav];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    flag = 0;
    
    //头像
    self.userIcon = [[UIImageView alloc]init];
    [self.userIcon setImage:[UIImage imageNamed:@"loginLogo"]];
    [self.view addSubview:self.userIcon];
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.cornerRadius = 10;
//    self.userIcon.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
//    self.userIcon.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
//    self.userIcon.layer.shadowOpacity = 0.5;//不透明度
//    self.userIcon.layer.shadowRadius = 10.0;//半径

    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+10);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    //账号输入框
    self.accountTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.accountTF.delegate = self;
    self.accountTF.font = kNormalFont;
    self.accountTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"账号", @"")
                                    attributes:@{NSForegroundColorAttributeName: RGB(102, 102, 102)}];
    self.accountTF.floatingLabelFont = kMostSmallFont;
    self.accountTF.floatingLabelTextColor = [UIColor whiteColor];
    self.accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.accountTF];
    self.accountTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.accountTF.keepBaseline = YES;
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(self.userIcon.mas_bottom).mas_offset(30);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(45);
    }];
    
    UIView *div1 = [[UIView alloc]init];
    div1.backgroundColor = CHJ_bgColor;
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.accountTF);
        make.top.mas_equalTo(self.accountTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //密码输入框
    self.pswTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.pswTF.font = kNormalFont;
    self.pswTF.secureTextEntry = YES;
    self.pswTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"登录密码", @"")
                                    attributes:@{NSForegroundColorAttributeName: RGB(102, 102, 102)}];
    self.pswTF.floatingLabelFont = kMostSmallFont;
    self.pswTF.floatingLabelTextColor = [UIColor whiteColor];
    self.pswTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.pswTF];
    self.pswTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.pswTF.keepBaseline = YES;
    [self.pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.accountTF);
        make.top.mas_equalTo(div1.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(45);
    }];
    
    UIView *div2 = [[UIView alloc]init];
    div2.backgroundColor = CHJ_bgColor;
    [self.view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    [div2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.pswTF);
        make.top.mas_equalTo(self.pswTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];

    //登录按钮
    self.loginButton = [[HRLoginButton alloc] initWithFrame:CGRectMake(60, 370, ScreenWidth-120, 45)];
    [self.loginButton setBackgroundColor:MainColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    self.loginButton.layer.cornerRadius = 45/2;
    self.loginButton.clipsToBounds = YES;
    [self.view addSubview:self.loginButton];
    
    //11.13 修改
//    if ([self.loginClass isEqualToString:@"3"]) {
//
//        //婚庆公司 没有注册
//
//    }else{
        //创建账号 - 注册
        UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [firstBtn.titleLabel setFont:kNormalFont];
        [firstBtn setTitleColor:RGB(165, 172, 182) forState:UIControlStateNormal];
        [firstBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:firstBtn];
        [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.pswTF);
            make.top.mas_equalTo(div2.mas_bottom).mas_offset(100);
        }];
//    }
    
    //找回密码
    //忘记密码按钮
    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn.titleLabel setFont:kNormalFont];
    [forgetBtn setTitleColor:RGB(165, 172, 182) forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(div2.mas_bottom).mas_offset(100);
        make.left.mas_equalTo(self.pswTF);
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
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (!tabBarC) {
        
        tabBarC = [[LCTabBarController alloc]init];
        
    }
}

//登录
- (void)PresentViewController:(HRLoginButton *)button {
    
    if ([self.accountTF.text isEqualToString:@""]) {
        typeof(self) __weak weak = self;
        [button failedAnimationWithCompletion:^{
            
            [weak didPresentControllerButtonTouch];
            
        }];
        //震动提醒
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"账号不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if ([self.pswTF.text isEqualToString:@""]){
        typeof(self) __weak weak = self;
        [button failedAnimationWithCompletion:^{
            [weak didPresentControllerButtonTouch];
        }];
        //震动提醒
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        
        NSLog(@"进入登录请求阶段");
        
        //网络请求
        [self SupplierLogin];
        
        [self.accountTF resignFirstResponder];
        [self.pswTF resignFirstResponder];
        typeof(self) __weak weak = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (flag ==1) {
                //网络正常 或者是密码账号正确跳转动画
                [button succeedAnimationWithCompletion:^{
                    
                    [weak didPresentControllerButtonTouch];
                    
                }];
            } else {
                //网络错误 或者是密码不正确还原动画
                [button failedAnimationWithCompletion:^{
                    
                    [weak didPresentControllerButtonTouch];
                    
                }];
                //震动提醒
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:errorStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                
            }
        });
        
    }
    
    
}
- (void)didPresentControllerButtonTouch {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"loginSuccess" object:self];
}

//忘记密码
-(void)forgetBtnClick{
    NSLog(@"点击忘记密码");
    YPForgetController *forgetVC = [[YPForgetController alloc]init];
    forgetVC.titleStr = @"忘记密码";
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}

//注册
- (void)registerBtnClick{
    NSLog(@"点击了注册");
//    YPRegisterController *registerVC = [[YPRegisterController alloc]init];
//    registerVC.loginClass = self.loginClass;///1.新人 2.供应商 3.婚庆
//    [self.navigationController pushViewController:registerVC animated:YES];
    
    YPFirstViewController *first = [[YPFirstViewController alloc]init];
    [self.navigationController pushViewController:first animated:YES];
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField  == self.accountTF) {
        
        //点击换行  让下一个textField成为焦点 即passwordTextField成为焦点
        [self.pswTF becomeFirstResponder];
        
    }else if(textField == self.pswTF){
        [self.pswTF resignFirstResponder];
        
    }
    
    return YES;
}

#pragma mark - 网络请求
#pragma mark 供应商登录请求
- (void)SupplierLogin{
    NSString *url = @"/api/User/SupplierLogin";
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserName"] = self.accountTF.text;
    NSString *psw = self.pswTF.text;
    //密码加密
    NSString *pswMD5 = [psw md5String];
    params[@"Password"] = pswMD5;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            flag = 1;

            weakSelf.loginModel.UserID                  = [object objectForKey:@"UserID"];
            weakSelf.loginModel.Phone                   = [object objectForKey:@"Phone"];
            weakSelf.loginModel.TrueName                = [object objectForKey:@"TrueName"];
            weakSelf.loginModel.Profession              = [object objectForKey:@"Profession"];
            weakSelf.loginModel.Headportrait            = [object objectForKey:@"Headportrait"];
            weakSelf.loginModel.Age                     = [object objectForKey:@"Age"];
            weakSelf.loginModel.StatusType              = [object objectForKey:@"StatusType"];
            weakSelf.loginModel.CorpID                  = [object objectForKey:@"CorpID"];
            weakSelf.loginModel.SupplierID              = [object objectForKey:@"SupplierID"];
            weakSelf.loginModel.ModelID                 = [object objectForKey:@"ModelID"];
            weakSelf.loginModel.RummeryID               = [object objectForKey:@"RummeryID"];
            weakSelf.loginModel.IsRummeryInfo           = [object objectForKey:@"IsRummeryInfo"];
            weakSelf.loginModel.CreateTime              = [object objectForKey:@"CreateTime"];
            weakSelf.loginModel.Region                  = [object objectForKey:@"Region"];
            weakSelf.loginModel.BriefinTroduction       = [object objectForKey:@"BriefinTroduction"];
            weakSelf.loginModel.Name                    = [object objectForKey:@"Name"];
            weakSelf.loginModel.OwnedCompany            = [object objectForKey:@"OwnedCompany"];
            weakSelf.loginModel.Adress                  = [object objectForKey:@"Adress"];
            weakSelf.loginModel.IsSearch                = [object objectForKey:@"IsSearch"];
            weakSelf.loginModel.SuppLierCreateTime      = [object objectForKey:@"SuppLierCreateTime"];
            
            //存储个人信息
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"UserID"] forKey:@"UserID"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"TrueName"] forKey:@"TrueName"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Profession"] forKey:@"Profession"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Headportrait"] forKey:@"Headportrait"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Phone"] forKey:@"Phone"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"CorpID"] forKey:@"CorpID"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Age"] forKey:@"Age"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"StatusType"] forKey:@"StatusType"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"SupplierID"] forKey:@"SupplierID"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"ModelID"] forKey:@"ModelID"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"RummeryID"] forKey:@"RummeryID"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"IsRummeryInfo"] forKey:@"IsRummeryInfo"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Region"] forKey:@"Region"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"BriefinTroduction"] forKey:@"BriefinTroduction"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Name"] forKey:@"Name"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"OwnedCompany"] forKey:@"OwnedCompany"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"Adress"] forKey:@"Adress"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"CreateTime"] forKey:@"CreateTime"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"IsSearch"] forKey:@"IsSearch"];
            [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"SuppLierCreateTime"] forKey:@"SuppLierCreateTime"];
            
            
            
//            if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[LCTabBarController class]]) {//注销后重新登录
//
////                YPMeController *meVC = [[YPMeController alloc]init];
////
////                [self.navigationController pushViewController:meVC animated:YES];
//
//            }else{//未登录过
//                LCTabBarController *tabBarC = [[LCTabBarController alloc]init];
//                [UIApplication sharedApplication].keyWindow.rootViewController = tabBarC;
//            }

            if (!tabBarC) {
                tabBarC = [[LCTabBarController alloc]init];
            }
            
        }else{
            
            flag = 0;
            errorStr = [[object valueForKey:@"Message"] valueForKey:@"Inform"];
            
        }
        
    } Failure:^(NSError *error) {
        
//        [[DLProgressHUD shareManager] showWithMessage:@"网络请求失败" type:DLProgressHUDTypeError];
//        [[DLProgressHUD  shareManager ]dismissWithTime:3];

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
