//
//  YPReLoginController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReLoginController.h"
#import "LCTabBarController.h"
#import "XWCountryCodeController.h"
#import "YPReLoginSMSController.h"//验证码
#import "YPReLoginPwdController.h"
#import "WXApi.h"
#import "YPReLoginBindPhoneController.h"

//shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//模型
#import "YPWXGetUserInfo.h"

#import "HRWebViewController.h"

@interface YPReLoginController ()

@property (nonatomic, strong) YPWXGetUserInfo *userInfo;

@end

@implementation YPReLoginController{
    UIView *_navView;
    NSInteger flag;//网络请求成功为1 不成功为0
    NSString *errorStr;//网络请求后中赋值
    NSString *_countryNum;//国家码
    UIButton *_countryNumBtn;
    UIButton *_loginBtn;
    UITextField *_phoneTF;
    
    UIButton *thirdBtn;
    UILabel *label_bottom;
    
    LCTabBarController *tabBarC;
    
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

#pragma mark - getter
- (YPWXGetUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [[YPWXGetUserInfo alloc]init];
    }
    return _userInfo;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _countryNum = @"+86";
    
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
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"登录婚礼桥";
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
    titleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//    [self.view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(view);
//        make.left.mas_equalTo(15);
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
    subTitleLab.text = @"登录以享受更多服务";
    subTitleLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    subTitleLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:subTitleLab];
    [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(15);
//        make.left.mas_equalTo(titleLab);
        make.top.mas_equalTo(_shimmeringView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(_shimmeringView).mas_offset(5);
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
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
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
        make.left.mas_equalTo(subTitleLab);
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
    
    UIButton *pwdBtn = [[UIButton alloc]init];
    [pwdBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
    [pwdBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
    pwdBtn.titleLabel.font = kFont(13);
    [pwdBtn addTarget:self action:@selector(pwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pwdBtn];
    [pwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginBtn.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(_loginBtn);
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

#pragma mark - 检测是否安装微信
- (void)monitorWeChat{
    
    if ([WXApi isWXAppInstalled]) {
        
        thirdBtn.hidden = NO;
        label_bottom.hidden = NO;
        
    }else {
//        [EasyShowTextView showText:@"您未安装微信客户端"];
        
        thirdBtn.hidden = YES;
        label_bottom.hidden = YES;
    }
    
}

#pragma mark - 按钮点击事件
- (void)backVC{
 
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (!tabBarC) {
        
        tabBarC = [[LCTabBarController alloc]init];
        
    }
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

- (void)textFieldDidChange:(UITextField *)sender{

    if (_phoneTF.text.length > 0) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }

}

- (void)loginBtnClick{
    NSLog(@"loginBtnClick");
    
//    YPReLoginSMSController *sms = [[YPReLoginSMSController alloc]init];
//    sms.smsType = @"1";/**标识 登录:1 忘记密码:2 绑定手机号/微信登录:3*/
//    [self.navigationController pushViewController:sms animated:YES];
    
//    if ([self phoneNumberIsTrue:_phoneTF.text]) {
    if (_phoneTF.text.length > 0) {//18-11-21
        YPReLoginSMSController *sms = [[YPReLoginSMSController alloc]init];
        sms.phoneStr = [NSString stringWithFormat:@"%@ %@",_countryNum,_phoneTF.text];
        sms.smsType = @"1";/**标识 登录:1 忘记密码:2 绑定手机号/微信登录:3*/
        [self.navigationController pushViewController:sms animated:YES];
    }else{
        [EasyShowTextView showText:@"请输入手机号"];
    }
   
}

- (void)pwdBtnClick{
    NSLog(@"pwdBtnClick");
    
    YPReLoginPwdController *pwd = [[YPReLoginPwdController alloc]init];
    [self.navigationController pushViewController:pwd animated:YES];
}

- (void)thirdBtnClick{
  
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
-(void)xiyilabelClick{
    HRWebViewController *weBVC = [[HRWebViewController alloc]init];
    weBVC.webUrl =@"http://www.chenghunji.com/capital/useragreement";
    weBVC.isShareBtn =NO;
    [self.navigationController pushViewController:weBVC animated:YES];
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

#pragma mark 省市区联级
- (void)GetAreaListRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetRegionList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RegionID"] = @"1";//省传1
 
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"省份：%@",object);
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
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.view];
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
                //登录->存储本地信息 2018-07-31
                [CXDataManager savaUserInfo:object];

                [EasyShowTextView showText:@"登录成功!" inView:self.view];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];

            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.view];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
    
}

@end
