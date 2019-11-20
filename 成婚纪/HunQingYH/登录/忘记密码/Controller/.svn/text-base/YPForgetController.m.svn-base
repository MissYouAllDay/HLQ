//
//  YPForgetController.m
//  com.ss.zhifu
//
//  Created by YanpengLee on 2017/4/5.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPForgetController.h"
#import "YPNewPassWordController.h"//设置新密码
#import "YPCountButton.h"

@interface YPForgetController ()<UIAlertViewDelegate,CountButtonDelegate>

@property (nonatomic, strong) JVFloatLabeledTextField *phoneTF;
@property (nonatomic, strong) JVFloatLabeledTextField *yanZhengMaTF;

//验证码
@property (nonatomic, strong) YPCountButton *smsBtn;

@end

@implementation YPForgetController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNav];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(100);
        make.left.right.mas_equalTo(self.view);
    }];
    
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.text = @"手机号";
    lab1.font = kBigFont;
    [view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
    }];
    
    //手机号
    self.phoneTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.phoneTF.font = kNormalFont;
    //    self.phoneTF.backgroundColor = WhiteColor;
    self.phoneTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入绑定手机号", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.phoneTF.floatingLabelFont = kMostSmallFont;
    self.phoneTF.floatingLabelTextColor = [UIColor brownColor];
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:self.phoneTF];
    self.phoneTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneTF.keepBaseline = YES;
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.centerY.mas_equalTo(lab1).mas_offset(-8);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(35);
    }];
    
    UIView *div1 = [[UIView alloc]init];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab1);
        make.right.mas_equalTo(view);
        make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //验证码
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.text = @"验证码";
    lab2.font = kBigFont;
    [view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(div1.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(lab1);
    }];
    
    self.yanZhengMaTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.yanZhengMaTF.font = kNormalFont;
    self.yanZhengMaTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入验证码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.yanZhengMaTF.floatingLabelFont = kMostSmallFont;
    self.yanZhengMaTF.floatingLabelTextColor = [UIColor brownColor];
    self.yanZhengMaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:self.yanZhengMaTF];
    self.yanZhengMaTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.yanZhengMaTF.keepBaseline = YES;
    [self.yanZhengMaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTF);
        make.right.mas_equalTo(-120);
        make.centerY.mas_equalTo(lab2).mas_offset(-8);
        make.height.mas_equalTo(35);
    }];
    
    //验证码按钮
    self.smsBtn = [YPCountButton buttonWithType:UIButtonTypeCustom];
    self.smsBtn.countdownBeginNumber = 60;
    self.smsBtn.normalStateImageName = nil;
    self.smsBtn.normalStateBgImageName = nil;
    self.smsBtn.highlightedStateImageName = nil;
    self.smsBtn.highlightedStateBgImageName = nil;
    self.smsBtn.selectedStateImageName = nil;
    self.smsBtn.selectedStateBgImageName = nil;
    self.smsBtn.delegate = self;
    [self.smsBtn addTarget:self action:@selector(smsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.smsBtn.titleLabel.font = kNormalFont;
    self.smsBtn.backgroundColor = NavBarColor;
    [view addSubview:self.smsBtn];
    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yanZhengMaTF.mas_right).mas_offset(5);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(lab2);
    }];
    
    //不能接收短信
    UIButton *notBtn = [[UIButton alloc] init];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"该手机号无法接收短信?"];
    [str addAttribute:NSUnderlineStyleAttributeName
                value:@(NSUnderlineStyleSingle)
                range:(NSRange){0,[str length]}];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:RGB(165, 172, 182)  range:NSMakeRange(0,[str length])];
    
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:RGB(165, 172, 182) range:(NSRange){0,[str length]}];
    [notBtn setAttributedTitle:str forState:UIControlStateNormal];
    notBtn.titleLabel.font = kFont(15);
    [notBtn addTarget:self action:@selector(notBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notBtn];
    
    [notBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(view.mas_bottom).mas_offset(20);
    }];

    
    //下一步
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setBackgroundColor:NavBarColor];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.clipsToBounds = YES;
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(notBtn.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
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
- (void)nextBtnClick{
    NSLog(@"nextBtnClick");

//    YPNewPassWordController *newPsw = [[YPNewPassWordController alloc]init];
////    newPsw.titleStr = self.titleStr;
////    newPsw.phone = self.phoneTF.text;
////    newPsw.AuthCodeID = [object objectForKey:@"AuthCodeID"];
//    [self.navigationController pushViewController:newPsw animated:YES];
    
    if (self.phoneTF.text.length == 0) {
        Alertmsg(@"请输入手机号/用户名", nil)
    }else if (self.phoneTF.text.length != 11){
        Alertmsg(@"请输入正确格式手机号", nil)
    }else if (self.yanZhengMaTF.text.length == 0){
        Alertmsg(@"请输入验证码", nil)
    }else{
        NSLog(@"下一步");
    
        [self.phoneTF resignFirstResponder];
        [self.yanZhengMaTF resignFirstResponder];
    
        [self verifySMSCodeRequest];
        
    }
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)smsBtnClick{
    NSLog(@"smsBtnClick");
    
    if (self.phoneTF.text.length == 0) {
        Alertmsg(@"请输入手机号", nil)
    }else{

        //获取验证码
        [self getSMSCodeRequest];
    }
}

- (void)notBtnClick{
    NSLog(@"notBtnClick");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",kefuTel]]];
}

#pragma mark - CountButtonDelegate
- (void)countButtonClicked{
    NSLog(@"CountButtonDelegate");
    
    self.smsBtn.tfText = self.phoneTF.text;
}

#pragma mark - 网络请求
#pragma mark 获取验证码
- (void)getSMSCodeRequest{
    
//    [[DLProgressHUD shareManager] showWithMessage:nil type:DLProgressHUDTypeLoading];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSMSCode";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserType"] = @"1"; //0公司、1供应商
    params[@"Phone"] = self.phoneTF.text;
//    if ([self.titleStr isEqualToString:@"忘记密码"]) {
//        params[@"Type"] = @"0"; //0注册、 1重置登陆密码、2激活、3更换手机号
//    }else if ([self.titleStr isEqualToString:@"修改密码"]) {
//        params[@"Type"] = @"1"; //0注册、 1重置登陆密码、2激活、3更换手机号
//    }
    
    //08-07 修改 忘记密码/修改密码 都传1
    params[@"Type"] = @"1"; //0注册、 1重置登陆密码、2激活、3更换手机号
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            [[DLProgressHUD shareManager] showWithMessage:@"获取验证码成功" type:DLProgressHUDTypeSuccess];
//            [[DLProgressHUD  shareManager ]dismissWithTime:1];
            
            [EasyShowTextView showText:@"获取验证码成功"];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
//            [[DLProgressHUD shareManager] showWithMessage:[[object valueForKey:@"Message"] valueForKey:@"Inform"] type:DLProgressHUDTypeError];
//            [[DLProgressHUD  shareManager ]dismissWithTime:2];
        }
        
    } Failure:^(NSError *error) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
//        [[DLProgressHUD shareManager] showWithMessage:@"网络请求失败,请重试!" type:DLProgressHUDTypeError];
//        [[DLProgressHUD  shareManager ]dismissWithTime:2];
        
    }];
    
}

#pragma mark 校验验证码
- (void)verifySMSCodeRequest{
    
//    [[DLProgressHUD shareManager] showWithMessage:nil type:DLProgressHUDTypeLoading];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/VerifySMSCode";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = self.phoneTF.text;
    
//    if ([self.titleStr isEqualToString:@"忘记密码"]) {
//        params[@"Type"] = @"0"; //0注册、 1重置登陆密码、2激活、3更换手机号
//    }else if ([self.titleStr isEqualToString:@"修改密码"]) {
//        params[@"Type"] = @"1"; //0注册、 1重置登陆密码、2激活、3更换手机号
//    }
    
    //08-07 修改 忘记密码/修改密码 都传1
    params[@"Type"] = @"1"; //0注册、 1重置登陆密码、2激活、3更换手机号
    
    params[@"SMSCode"] = self.yanZhengMaTF.text;
    params[@"UserType"] = @"1";  //0公司、1供应商
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            [[DLProgressHUD  shareManager ]dismissWithTime:0.5];
            
            YPNewPassWordController *newPsw = [[YPNewPassWordController alloc]init];
            newPsw.titleStr = self.titleStr;
            newPsw.setType = @"1";//忘记密码 / 修改密码
            newPsw.phoneNo = self.phoneTF.text;
            newPsw.authCodeID = [object objectForKey:@"AuthCodeID"];
            [self.navigationController pushViewController:newPsw animated:YES];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
//            [[DLProgressHUD shareManager] showWithMessage:[[object valueForKey:@"Message"] valueForKey:@"Inform"] type:DLProgressHUDTypeError];
//            [[DLProgressHUD  shareManager ]dismissWithTime:3];
        }
        
    } Failure:^(NSError *error) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
//        [[DLProgressHUD shareManager] showWithMessage:@"网络请求失败" type:DLProgressHUDTypeError];
//        [[DLProgressHUD  shareManager ]dismissWithTime:3];
        
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
