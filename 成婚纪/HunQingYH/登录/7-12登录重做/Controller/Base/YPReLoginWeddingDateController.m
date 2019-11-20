//
//  YPReLoginWeddingDateController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/1.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPReLoginWeddingDateController.h"
#import "YPReLoginWeddingDateHeadView.h"
#import "YPReLoginRegistSucController.h"//18-11-06 注册成功

@interface YPReLoginWeddingDateController ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) NSString *dateStr;

@end

@implementation YPReLoginWeddingDateController{
    UIView *_navView;
    YPReLoginWeddingDateHeadView *_headView;
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
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    
    if (!_headView) {
        _headView = [YPReLoginWeddingDateHeadView yp_ReLoginWeddingDateHeadView];
    }
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(120);
    }];
    
    if (!self.datePicker) {
        self.datePicker = [[UIDatePicker alloc]init];
    }
    //设置地区: zh-中国
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置当前显示时间
    [self.datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最小时间（此处为当前时间）
    [self.datePicker setMinimumDate:[NSDate date]];
    //监听DataPicker的滚动
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headView.mas_bottom);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(230);
        make.width.mas_equalTo(ScreenWidth-80);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"婚期";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self.datePicker);
    }];
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setImage:[UIImage imageNamed:@"startWed"] forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"startWed"] forState:UIControlStateHighlighted];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.datePicker.mas_bottom).mas_offset(50);
        make.centerX.mas_equalTo(self.view);
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

    UIButton *doneBtn = [[UIButton alloc]init];
    [doneBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [doneBtn setTitleColor:RGBS(153) forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
    }];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    /**标识 绑定手机号/微信注册:1 手机号验证码注册注册:2*/
    if ([self.identityType isEqualToString:@"1"]) {
        [self WXRegisterWithIdentity:YongHu_New AndDate:@""];
    }else if ([self.identityType isEqualToString:@"2"]){
        [self PhoneCodeRegisterWithIdentity:YongHu_New AndDate:@""];
    }
}

- (void)dateChange:(UIDatePicker *)sender{
    NSLog(@"%@",[sender.date stringWithFormat:@"yyyy年MM月dd日"]);
    self.dateStr = [sender.date stringWithFormat:@"yyyy-MM-dd"];
}

- (void)startBtnClick{
    NSLog(@"startBtnClick");
    /**标识 绑定手机号/微信注册:1 手机号验证码注册注册:2*/
    if ([self.identityType isEqualToString:@"1"]) {
        [self WXRegisterWithIdentity:YongHu_New AndDate:self.dateStr];
    }else if ([self.identityType isEqualToString:@"2"]){
        [self PhoneCodeRegisterWithIdentity:YongHu_New AndDate:self.dateStr];
    }
}

#pragma mark - 网络请求
#pragma mark 微信注册用户信息
- (void)WXRegisterWithIdentity:(NSString *)identity AndDate:(NSString *)date{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/WXRegister";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"OpenId"] = self.wxopenId;
    params[@"Phone"] = self.wxphone;
    
    params[@"Identity"] = identity;
    
    params[@"PhoneCode"] = self.wxphoneCode;
    
    ///18-08-10 添加 微信Access_token
    params[@"Token"] = self.tokenCode;
    
    ///18-11-02 婚期
    params[@"Wedding"] = date;
    //18-11-05 地区
    params[@"AreaId"] = self.areaID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //注册成功
            [EasyShowTextView showText:@"注册成功!" inView:self.view];
            
            [self WXGetUserInfo];//18-08-16 获取信息--窦
            
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

#pragma mark 手机号验证码注册用户
- (void)PhoneCodeRegisterWithIdentity:(NSString *)identity AndDate:(NSString *)date{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/PhoneCodeRegister";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Phone"] = self.wxphone;
    
    params[@"Identity"] = identity;
    
    //    params[@"PassWord"] = @"";//07-31 手机号验证码注册不需要密码
    
    params[@"PhoneCode"] = self.wxphoneCode;
    
    ///18-11-02 婚期
    params[@"Wedding"] = date;
    //18-11-05 地区
    params[@"AreaId"] = self.areaID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //注册成功
            
            [EasyShowTextView showText:@"注册成功!" inView:self.view];
            
            [self SMSCodeGetUserInfoRequest];
            
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

#pragma mark 根据微信Id获取用户信息
- (void)WXGetUserInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/WXGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"OpenId"] = self.wxopenId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"已注册-主页");
            [CXDataManager savaUserInfo:object];
            
            [EasyShowTextView showText:@"登录成功!" inView:self.view];
            
            //18-11-06 注册成功
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil userInfo:@{@"professionType":YongHu_New}];
            }];
            
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

#pragma mark 根据手机号验证码获取用户信息
- (void)SMSCodeGetUserInfoRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/SMSCodeGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = self.wxphone;
    params[@"Code"] = self.wxphoneCode;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"用户信息：%@",[object objectForKey:@"UserId"]);
            
            [CXDataManager savaUserInfo:object];
            
            [EasyShowTextView showText:@"登录成功!" inView:self.view];
            
            //18-11-06 注册成功
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistSuccess" object:nil userInfo:@{@"professionType":YongHu_New}];
            }];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
