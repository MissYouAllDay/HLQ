//
//  YPReLoginSMSController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginSMSController.h"
#import "VertificationCodeInputView.h"
#import "YPReLoginIdentityController.h"//身份
#import "YPReLoginResetPWDController.h"//重置密码
#import "YPWXGetUserInfo.h"

@interface YPReLoginSMSController ()<getTextFieldContentDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) YPWXGetUserInfo *userInfo;

@end

@implementation YPReLoginSMSController{
    UIView *_navView;
    VertificationCodeInputView *_inputV;
//    UILabel *_timeLabel;
    UIButton *_timeBtn;
    NSInteger getGmstime;
    
    NSInteger _countdown;
    NSTimer *_countdownTimer;
    NSInteger _countdownBeginNumber;
    
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
    getGmstime =0;
    [self GetGMSCodeRequest];
//    [self setupTimer];
    
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
    titleLab.text = @"输入短信验证码";
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
    subTitleLab.text = [NSString stringWithFormat:@"验证码已发送至%@",self.phoneStr];
    subTitleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    subTitleLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:subTitleLab];
    [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(15);
        make.top.mas_equalTo(_shimmeringView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(titleLab);
    }];
    
    _inputV = [[VertificationCodeInputView alloc]initWithFrame:CGRectMake(24, 200, ScreenWidth-44, 60)];
    _inputV.delegate = self;
    /****** 设置验证码/密码的位数默认为四位 ******/
    _inputV.numberOfVertificationCode = 4;
    /*********验证码（显示数字）YES,隐藏形势 NO，数字形式**********/
    _inputV.secureTextEntry = NO;
    [self.view addSubview:_inputV];
//    [_inputV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(subTitleLab.mas_bottom).mas_offset(30);
//        make.left.mas_equalTo(titleLab);
//        make.right.mas_equalTo(-20);
//        make.height.mas_equalTo(60);
//    }];
    [_inputV becomeFirstResponder];
    
    _timeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeBtn.titleLabel.font =kFont(13);
    [_timeBtn setTitle:@"60S后可重新发送" forState:UIControlStateNormal];
    [_timeBtn setTitleColor: [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1] forState:UIControlStateNormal];
    _timeBtn.enabled =NO;
    _timeBtn.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_timeBtn];
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inputV.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-20, 20));
    }];
    
//    _timeLabel = [[UILabel alloc]init];
//    _timeLabel.text = @"60S后可重新发送";
//    _timeLabel.font = kFont(13);
//    _timeLabel.textColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
//    [self.view addSubview:_timeLabel];
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_inputV.mas_bottom).mas_offset(30);
//        make.centerX.mas_equalTo(self.view);
//    }];
//
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

#pragma mark - getTextFieldContentDelegate
- (void)returnTextFieldContent:(NSString *)content{
    NSLog(@"%@================验证码",content);
    
//    YPReLoginIdentityController *identity = [[YPReLoginIdentityController alloc]init];
//    identity.identityType = @"1";/**标识 绑定手机号/微信注册:1 手机号验证码注册:2*/
//    [self.navigationController pushViewController:identity animated:YES];
    
    if (content.length == _inputV.numberOfVertificationCode) {
        NSLog(@"enough");
        [_countdownTimer invalidate];
        [_inputV resignFirstResponder];

        /**标识 登录:1 忘记密码:2 绑定手机号/微信登录:3*/
        if ([self.smsType isEqualToString:@"1"]) {//登录
             //调用根据手机号验证码获取用户信息，返回用户信息不为空，直接进入，则跳转设置身份页面
            [self SMSCodeGetUserInfoRequest];
        }else if ([self.smsType isEqualToString:@"2"]){//重置密码

            [self VerificationSMSCodeWithType:@"resetpwd"];

        }else if ([self.smsType isEqualToString:@"3"]){//绑定手机号/微信登录
            NSLog(@"绑定手机号/微信登录");
            //先验证验证码,再选择身份
            [self VerificationSMSCodeWithType:@"wechat/bind"];
        }
    }
}

#pragma mark - Timer
- (void)setupTimer{
    
    _countdownBeginNumber = 60;
    _countdown = _countdownBeginNumber - 1;
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
    
}

- (void)startTimer{
    
    _countdown = _countdown-1;

//    _timeLabel.text = [NSString stringWithFormat:@"%zdS后可重新发送",_countdown];
    if(_countdown == 0){
        
       
        [_timeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [_timeBtn  setTitleColor:MainColor forState:UIControlStateNormal];
        _timeBtn.enabled =YES;
        [_timeBtn addTarget:self action:@selector(GetGMSCodeRequest) forControlEvents:UIControlEventTouchUpInside];
        _countdown = _countdownBeginNumber - 1;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
        
    }else{
         [_timeBtn setTitle:[NSString stringWithFormat:@"%zdS后可重新发送",_countdown] forState:UIControlStateNormal];
           [_timeBtn  setTitleColor: [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1] forState:UIControlStateNormal];
        _timeBtn.enabled =NO;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [_inputV resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 按钮点击事件
- (void)backVC{
    
    //18-11-06 返回确认-董
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"短信验证码可能有延迟, 确认返回并重新开始" message:nil delegate:self cancelButtonTitle:@"继续等待" otherButtonTitles:@"确认返回", nil];
    [alert show];
}

- (void)dealloc{
    _countdownTimer = nil;
    [_countdownTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取短信验证码
- (void)GetGMSCodeRequest{
    if (getGmstime !=0) {
          [EasyShowLodingView showLoding];
    }
 
    NSArray *arr = [_phoneStr componentsSeparatedByString:@" "];
    
    NSString *url = @"/api/HQOAApi/GetSMSCode";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = arr[1];
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
                if (getGmstime !=0) {
                     [EasyShowTextView showSuccessText:@"获取验证码成功"];
                }
            getGmstime++;
//
                [self setupTimer];//开启计时器
            //            if (_pageIndex == 1) {
            //
            //                [self.listMarr removeAllObjects];
            //
            //                self.listMarr = [YPGetWeddingPackageList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            //
            //                [thistableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            //                [self endRefresh];
            //
            //            }else{
            //                NSArray *newArray = [YPGetWeddingPackageList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            //
            //                if (newArray.count == 0) {
            //                    thistableView.mj_footer.state = MJRefreshStateNoMoreData;
            //                }else{
            //                    [self.listMarr addObjectsFromArray:newArray];
            //
            //                    [self endRefresh];
            //                    [thistableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            //                }
            //
            //            }
            
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

#pragma mark 根据手机号验证码获取用户信息
- (void)SMSCodeGetUserInfoRequest{
    
    [EasyShowLodingView showLoding];

    NSArray *arr = [_phoneStr componentsSeparatedByString:@" "];
    
    NSString *url = @"/api/HQOAApi/SMSCodeGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = arr[1];
    params[@"Code"] = _inputV.vertificationCode;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"用户信息：%@",[object objectForKey:@"UserId"]);
            
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
            
            if ([self.userInfo.UserId isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                
                //未注册-选择身份
                YPReLoginIdentityController *identity = [[YPReLoginIdentityController alloc]init];
                identity.identityType = @"2";/**标识 绑定手机号/微信注册:1 手机号验证码注册:2*/
                identity.wxphone = arr[1];
                identity.wxphoneCode = _inputV.vertificationCode;
                identity.tokenCode = self.tokenCode;
                [self.navigationController pushViewController:identity animated:YES];
                
            }else{
                
                [CXDataManager savaUserInfo:object];
                
                [EasyShowTextView showText:@"登录成功!" inView:self.view];
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

#pragma mark 验证短信验证码 - 绑定手机号/微信登录(注册)专用 -- 忘记密码/修改密码也用
- (void)VerificationSMSCodeWithType:(NSString *)type{
    
    [EasyShowLodingView showLoding];
    
    NSArray *arr = [_phoneStr componentsSeparatedByString:@" "];
    
    NSString *url = @"/api/HQOAApi/VerificationSMSCode";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = arr[1];
    params[@"Code"] = _inputV.vertificationCode;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if ([type isEqualToString:@"wechat/bind"]) {//微信注册/绑定手机号
                //未注册 -> 选择身份
                YPReLoginIdentityController *identity = [[YPReLoginIdentityController alloc]init];
                identity.identityType = @"1";/**标识 绑定手机号/微信注册:1 手机号验证码注册注册:2*/
                identity.wxopenId = self.openId;
                identity.wxphone = arr[1];
                identity.wxphoneCode = _inputV.vertificationCode;
                identity.tokenCode = self.tokenCode;
                [self.navigationController pushViewController:identity animated:YES];
                
            }else if ([type isEqualToString:@"resetpwd"]){//重置密码
                YPReLoginResetPWDController *reset = [[YPReLoginResetPWDController alloc]init];
                reset.Phone = arr[1];
                reset.PhoneCode = _inputV.vertificationCode;
                reset.inType = self.inType;// 3:添加账号中重置密码 其他无用
                [self.navigationController pushViewController:reset animated:YES];
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

#pragma mark - getter
- (YPWXGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPWXGetUserInfo alloc]init];
    }
    return _userInfo;
}

@end
