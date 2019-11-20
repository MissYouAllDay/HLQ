//
//  YPReLoginPwdController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginPwdController.h"
#import "YPReLoginForgetController.h"//忘记密码
#import "YPWXGetUserInfo.h"

#import "WXApi.h"
#import "YPReLoginBindPhoneController.h"
#import "YPReMeController.h"

@interface YPReLoginPwdController ()

@property (nonatomic, strong) YPWXGetUserInfo *userInfo;

@end

@implementation YPReLoginPwdController{
    UIView *_navView;
    NSInteger flag;//网络请求成功为1 不成功为0
    NSString *errorStr;//网络请求后中赋值
    UIButton *_loginBtn;
    UITextField *_phoneTF;
    UITextField *_pwdTF;
    
    UIButton *thirdBtn;
    UILabel *label_bottom;
    
    FBShimmeringView *_shimmeringView;
    
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

    [self setupNav];
    [self setupUI];
    
    [self monitorWeChat];
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
    
//    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.text = @"登录婚礼桥";
//    titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
//    titleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//    [self.view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(view);
//        make.left.mas_equalTo(view.mas_right).mas_offset(15);
//    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    if (self.inType.integerValue == 2) {//18-11-13 添加账号
        titleLab.text = @"添加账号并登录";
    }else{
        titleLab.text = @"登录婚礼桥";
    }
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
    titleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
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
    
    _phoneTF = [[UITextField alloc]init];
    _phoneTF.font = kFont(24);
    _phoneTF.placeholder = @"手机号";
    _phoneTF.borderStyle = UITextBorderStyleNone;
    [_phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.right.mas_equalTo(-20);
//        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(30);
        make.top.mas_equalTo(_shimmeringView.mas_bottom).mas_offset(25);
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
        make.top.mas_equalTo(line.mas_bottom).mas_offset(20);
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
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(_pwdTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.enabled = NO;
    [_loginBtn setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];
    [_loginBtn setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateHighlighted];
    [_loginBtn setImage:[UIImage imageNamed:@"loginBtn_unselect"] forState:UIControlStateDisabled];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(line2);
    }];
    
    //18-11-13
    if (self.inType.integerValue == 2) {//添加账号 - 不显示验证码登录
        
    }else{
        UIButton *smsBtn = [[UIButton alloc]init];
        [smsBtn setTitle:@"手机验证码登录" forState:UIControlStateNormal];
        [smsBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
        smsBtn.titleLabel.font = kFont(13);
        [smsBtn addTarget:self action:@selector(smsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:smsBtn];
        [smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginBtn.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(_loginBtn);
        }];
    }
    
    UIButton *forgetBtn = [[UIButton alloc]init];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = kFont(13);
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginBtn.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(_loginBtn);
    }];
    
    if (!thirdBtn) {
        thirdBtn = [[UIButton alloc]init];
    }
    [thirdBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [thirdBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateHighlighted];
    [thirdBtn addTarget:self action:@selector(thirdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        make.centerX.mas_equalTo(self.view);
    }];
    
    if (!label_bottom) {
        label_bottom = [[UILabel alloc]init];
    }
    label_bottom.text = @"第三方登录";
    label_bottom.font = kFont(13);
    label_bottom.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:label_bottom];
    [label_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(thirdBtn.mas_top).mas_offset(-17);
        make.centerX.mas_equalTo(self.view);
    }];
    
    //用户协议
    UILabel *xyDesLab  = [[UILabel alloc]init];
    xyDesLab.text = @"登录即表示您同意";
    xyDesLab.font =kFont(11);
    xyDesLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:xyDesLab];
    [xyDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thirdBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(50);
        
    }];
    UILabel *xieyiLab = [[UILabel alloc]init];
    NSString *textStr = @"《用户服务使用协议》和《隐私协议》";
    xieyiLab.font =kFont(11);
    xieyiLab.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSUnderlineColorAttributeName : [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    xieyiLab.attributedText =attribtStr;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xiyilabelClick)];
    
    [xieyiLab addGestureRecognizer:gestureRecognizer];
    xieyiLab.userInteractionEnabled = YES;
    [self.view addSubview:xieyiLab];
    
    [xieyiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(xyDesLab.mas_right);
        make.centerY.mas_equalTo(xyDesLab);
    }];
}
-(void)xiyilabelClick{
    HRWebViewController *weBVC = [[HRWebViewController alloc]init];
    weBVC.webUrl =@"http://www.chenghunji.com/capital/useragreement";
    weBVC.isShareBtn =NO;
    [self.navigationController pushViewController:weBVC animated:YES];
}
#pragma mark - 检测是否安装微信
- (void)monitorWeChat{
    
    if ([WXApi isWXAppInstalled]) {
        
        //18-11-13
        if (self.inType.integerValue == 2) {//添加账号 - 不显示三方登录
            thirdBtn.hidden = YES;
            label_bottom.hidden = YES;
        }else{
            thirdBtn.hidden = NO;
            label_bottom.hidden = NO;
        }
        
    }else {
        //        [EasyShowTextView showText:@"您未安装微信客户端"];
        
        thirdBtn.hidden = YES;
        label_bottom.hidden = YES;
    }
    
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
    
    [self PhoneGetUserInfo];
}

- (void)smsBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forgetBtnClick{
    NSLog(@"forgetBtnClick");
    
    YPReLoginForgetController *forget = [[YPReLoginForgetController alloc]init];
    forget.titleStr = @"忘记密码?";
    if (self.inType.integerValue == 2) {//2: 添加账号
        forget.inType = @"3";// 3:添加账号中重置密码
    }
    [self.navigationController pushViewController:forget animated:YES];
}

- (void)textFieldDidChange:(UITextField *)sender{
    if ((_phoneTF.text.length > 0) && (_pwdTF.text.length > 0)) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
}

- (void)thirdBtnClick{
    NSLog(@"thirdBtnClick");
    
    if ([WXApi isWXAppInstalled]) {
        //        SendAuthReq *req = [[SendAuthReq alloc] init];
        //        req.scope = @"snsapi_userinfo";
        //        req.state = @"App";
        //        [WXApi sendReq:req];
        //         NSLog(@"安装了微信客户端");
        
        if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]) {
            NSLog(@"微信已经授权");
            //取消授权
            [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
        }
        
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 //                             [EasyShowTextView showSuccessText:@"登录成功"];
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 
                 [self WXGetUserInfoWithOpenID:user.uid AndToken:user.credential.token];//18-08-10 微信Access_token
                 
             }
             
             else
             {
                 NSLog(@"%@",error);
                 [EasyShowTextView showErrorText:@"登录失败"];
             }
             
         }];
        
        
        
    }else {
//        [EasyShowTextView showText:@"您未安装微信客户端"];
    }
}

#pragma mark - 网络请求
#pragma mark 根据手机号密码获取用户信息
- (void)PhoneGetUserInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/PhoneGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Phone"] = _phoneTF.text;
    NSString *md5 = [_pwdTF.text md5String];
    params[@"PassWord"] = md5;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.userInfo.UserId = [object objectForKey:@"UserId"];
            self.userInfo.Name = [object objectForKey:@"Name"];
            self.userInfo.Headportrait = [object objectForKey:@"Headportrait"];
            self.userInfo.Profession = [object objectForKey:@"Profession"];
            self.userInfo.Phone = [object objectForKey:@"Phone"];
            self.userInfo.FacilitatorId = [object objectForKey:@"FacilitatorId"];
            
            self.userInfo.Address = [object objectForKey:@"Address"];
            self.userInfo.Abstract = [object objectForKey:@"Abstract"];
            self.userInfo.Identity = [object objectForKey:@"Identity"];
            self.userInfo.region = [object objectForKey:@"region"];
            self.userInfo.regionname = [object objectForKey:@"regionname"];
            self.userInfo.IsMotorcade = [object objectForKey:@"IsMotorcade"];
            self.userInfo.IsNews = [object objectForKey:@"IsNews"];
            self.userInfo.CaptainID = [object objectForKey:@"CaptainID"];
            self.userInfo.ModelID = [object objectForKey:@"ModelID"];
            self.userInfo.FollowNumber = [[object objectForKey:@"FollowNumber"] integerValue];
            self.userInfo.FansNumber = [[object objectForKey:@"FansNumber"] integerValue];
            self.userInfo.StatusType = [object objectForKey:@"StatusType"];
            
            self.userInfo.Wedding = [object valueForKey:@"Wedding"];
            
            //登录成功
            //2:添加账号 3:添加账号中重置密码成功后重新登录
            if (self.inType.integerValue == 2 || self.inType.integerValue == 3) {
                //18-11-13 添加账号并存储第二账号
                [EasyShowTextView showText:@"添加并登录成功!" inView:self.view];
                
                [[NSUserDefaults standardUserDefaults]setObject:UserName_New forKey:@"Name_Second"];
                [[NSUserDefaults standardUserDefaults]setObject:Headportrait_New forKey:@"Headportrait_Second"];
                [[NSUserDefaults standardUserDefaults]setObject:UserPhone_New forKey:@"Phone_Second"];
                [[NSUserDefaults standardUserDefaults]setObject:Password_New forKey:@"Password_Second"];
                NSLog(@"%@\n%@\n%@\n%@\n%@\n",[NSString stringWithFormat:@"%@",UserName_New],[NSString stringWithFormat:@"%@",Headportrait_New],[NSString stringWithFormat:@"%@",UserPhone_New],[NSString stringWithFormat:@"%@",Password_New],[NSString stringWithFormat:@"%@",Headportrait_Second]);
                
            }else{
                [EasyShowTextView showText:@"登录成功!" inView:self.view];
            }
            
            [CXDataManager savaUserInfo:object];
   
            //18-11-13 存储密码 -- 只在密码登录界面存储
            [[NSUserDefaults standardUserDefaults] setObject:md5 forKey:@"Password_New"];
            
            if ([self.inType integerValue] == 1 || [self.inType integerValue] == 2 || [self.inType integerValue] == 3) {
                //修改密码进入 / 添加账号进入 / 添加账号重置密码后重新登录
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
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

#pragma mark 根据微信Id获取用户信息
- (void)WXGetUserInfoWithOpenID:(NSString *)openID AndToken:(NSString *)token{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/WXGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"OpenId"] = openID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //            NSLog(@"根据微信Id获取用户信息：%@",object);
            self.userInfo = [YPWXGetUserInfo mj_objectWithKeyValues:object];

            if ([self.userInfo.UserId isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {//未注册-绑定手机号
                NSLog(@"未注册-绑定手机号");
                //登录成功
                YPReLoginBindPhoneController *bdVC = [YPReLoginBindPhoneController new];
                // TODO: 传值
                bdVC.openId = openID;
                bdVC.phone = _phoneTF.text;
                bdVC.tokenCode = token;//18-08-10 微信Access_token
                [self.navigationController pushViewController:bdVC animated:YES];
            }else{//已注册-首页
                //已注册-主页
                NSLog(@"已注册-主页");
                [CXDataManager savaUserInfo:object];
                [EasyShowTextView showText:@"登录成功!" inView:self.view];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
    
}

#pragma mark - getter
- (YPWXGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPWXGetUserInfo alloc]init];
    }
    return _userInfo;
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
