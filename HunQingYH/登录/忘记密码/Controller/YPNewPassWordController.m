//
//  YPNewPassWordController.m
//  com.ss.zhifu
//
//  Created by YanpengLee on 2017/4/6.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPNewPassWordController.h"
#import "YPSetPwdSuccessController.h"
#import "YPReLoginController.h"
#import "YPSettingController.h"

@interface YPNewPassWordController ()

@property (nonatomic, strong) JVFloatLabeledTextField *PSWNewTF;
@property (nonatomic, strong) JVFloatLabeledTextField *surePSWTF;
@property (nonatomic, strong) JVFloatLabeledTextField *YQCodeWTF;

@end

@implementation YPNewPassWordController{
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
        make.height.mas_equalTo(ScreenHeight-NAVIGATION_BAR_HEIGHT -15);
        make.left.right.mas_equalTo(self.view);
    }];
    
    UILabel *lab1 = [[UILabel alloc]init];
    if ([self.setType integerValue] == 1) {//忘记密码
        lab1.text = @"新密码:";
    }else if ([self.setType integerValue] == 2) {//注册
        lab1.text = @"密码:";
    }
  
    lab1.font = kBigFont;
    [view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
    }];
    
    //新密码
    self.PSWNewTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.PSWNewTF.font = kNormalFont;
    self.PSWNewTF.secureTextEntry = YES;
    if ([self.setType integerValue] == 1) {//忘记密码
        self.PSWNewTF.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入新密码", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    }else if ([self.setType integerValue] == 2) {//注册
        self.PSWNewTF.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入密码", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    }
   
    self.PSWNewTF.floatingLabelFont = kMostSmallFont;
    self.PSWNewTF.floatingLabelTextColor = [UIColor brownColor];
    self.PSWNewTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:self.PSWNewTF];
    self.PSWNewTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.PSWNewTF.keepBaseline = YES;
    [self.PSWNewTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(90);
        make.centerY.mas_equalTo(lab1).mas_offset(-6);
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
        make.top.mas_equalTo(self.PSWNewTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //确认密码
    UILabel *lab2 = [[UILabel alloc]init];
    lab2.text = @"确认密码:";
    lab2.font = kBigFont;
    [view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(div1.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(lab1);
    }];
    
    //确认密码
    self.surePSWTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.surePSWTF.font = kNormalFont;
    self.surePSWTF.secureTextEntry = YES;
    self.surePSWTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"确认密码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.surePSWTF.floatingLabelFont = kMostSmallFont;
    self.surePSWTF.floatingLabelTextColor = [UIColor brownColor];
    self.surePSWTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:self.surePSWTF];
    self.surePSWTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.surePSWTF.keepBaseline = YES;
    [self.surePSWTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.PSWNewTF);
        make.centerY.mas_equalTo(lab2).mas_offset(-6);
        make.height.mas_equalTo(35);
    }];
    
    UIView *div2 = [[UIView alloc]init];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    [div2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab2);
        make.right.mas_equalTo(view);
        make.top.mas_equalTo(self.surePSWTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    if ([self.setType integerValue] == 1) {//忘记密码
      
    }else if ([self.setType integerValue] == 2) {//注册
        
        //邀请码
        UILabel *lab3 = [[UILabel alloc]init];
        lab3.text = @"邀请码:";
        lab3.font = kBigFont;
        [view addSubview:lab3];
        [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(div2.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(lab1);
        }];
        
        //确认密码
        self.YQCodeWTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
        self.YQCodeWTF.font = kNormalFont;
        self.YQCodeWTF.secureTextEntry = YES;
        self.YQCodeWTF.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:NSLocalizedString(@"邀请码(选填)", @"")
                                        attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
        self.YQCodeWTF.floatingLabelFont = kMostSmallFont;
        self.YQCodeWTF.floatingLabelTextColor = [UIColor brownColor];
        self.YQCodeWTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [view addSubview:self.YQCodeWTF];
        self.YQCodeWTF.translatesAutoresizingMaskIntoConstraints = NO;
        self.YQCodeWTF.keepBaseline = YES;
        [self.YQCodeWTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.PSWNewTF);
            make.centerY.mas_equalTo(lab3).mas_offset(-6);
            make.height.mas_equalTo(35);
        }];
        
        UIView *div3 = [[UIView alloc]init];
        div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
        [view addSubview:div3];
        div3.translatesAutoresizingMaskIntoConstraints = NO;
        [div3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab2);
            make.right.mas_equalTo(view);
            make.top.mas_equalTo(self.YQCodeWTF.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(1);
        }];
    }
    
 
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    if ([self.setType integerValue] == 1) {//忘记密码
        titleLab.text = @"设置新密码";
    }else if ([self.setType integerValue] == 2) {//注册
          titleLab.text = @"设置密码";
    }
  
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
    
    //确定按钮
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 10;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

#pragma mark - 按钮点击事件
- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.PSWNewTF.text.length == 0) {
        Alertmsg(@"请输入新密码", nil)
    }else if (![self.surePSWTF.text isEqualToString:self.PSWNewTF.text]){
        Alertmsg(@"请确定两次输入的密码一致", nil)
    }else if (!(self.surePSWTF.text.length > 5 && self.surePSWTF.text.length < 14)){
        Alertmsg(@"请确定输入的密码位数在指定范围内", nil)
    }else {
//        if ([self.surePSWTF.text isEqualToString:self.PSWNewTF.text] && (self.surePSWTF.text.length > 5 && self.surePSWTF.text.length < 14))

        if ([self.setType integerValue] == 1) {//忘记密码
            //网络请求
            [self resetPasswordRequest];
        }else if ([self.setType integerValue] == 2) {//注册
            
            [self RegisterSupplier];
        }

        [self.PSWNewTF resignFirstResponder];
        [self.surePSWTF resignFirstResponder];
    }

//    YPSetPwdSuccessController *suc = [[YPSetPwdSuccessController alloc]init];
//    [self.navigationController pushViewController:suc animated:YES];
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 重置密码
- (void)resetPasswordRequest{
    
//    [[DLProgressHUD shareManager] showWithMessage:nil type:DLProgressHUDTypeLoading];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/ResetPassword";

//    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = self.phoneNo;
    NSString *pwd = [self.surePSWTF.text md5String];
    params[@"NewPassword"] = pwd;
    params[@"AuthCodeID"] = self.authCodeID;
    params[@"Type"] = @"1";//1重置登录密码
//    params[@"UserType"] = @"1";//0公司、1供应商  9.28 去掉

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

//            [[DLProgressHUD shareManager] showWithMessage:@"设置密码成功,请重新登录" type:DLProgressHUDTypeSuccess];
//            [[DLProgressHUD  shareManager ]dismissWithTime:1];
            
            [EasyShowTextView showText:@"设置密码成功,请重新登录"];

            if ([self.titleStr isEqualToString:@"忘记登录"]) {
                UIViewController *mineVC = nil;
                for (UIViewController * controller in self.navigationController.viewControllers) {
                    //遍历
                    if([controller isKindOfClass:[YPReLoginController class]]){
                        //这里判断是否为你想要跳转的页面
                        mineVC = controller;
                        break;
                    }
                }
                [self.navigationController popToViewController:mineVC  animated:YES];
                
            }else if ([self.titleStr isEqualToString:@"修改密码"]){
                
                UIViewController *mineVC = nil;
                for (UIViewController * controller in self.navigationController.viewControllers) {
                    //遍历
                    if([controller isKindOfClass:[YPSettingController class]]){
                        //这里判断是否为你想要跳转的页面
                        mineVC = controller;
                        break;
                    }
                }
                [self.navigationController popToViewController:mineVC  animated:YES];

                //通知 -- 返回后 弹出登录界面
                [[NSNotificationCenter defaultCenter] postNotificationName:@"EditPWDAndPresentLoginVC" object:nil];
            }
            
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

#pragma mark 注册
- (void)RegisterSupplier{
    
//    [[DLProgressHUD shareManager] showWithMessage:nil type:DLProgressHUDTypeLoading];
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/RegisterSupplier";
    
    //    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PhoneNo"] = self.phoneNo;
    NSString *pwd = [self.surePSWTF.text md5String];
    params[@"UserPwd"] = pwd;
    params[@"TrueName"] = self.shopName;//新人:姓名  供应商:店铺名/姓名
    params[@"Profession"] = self.profession;
    
    //所有职业都需要身份证
    if (self.idCardFrontID.length > 0 && self.idCardFanID.length > 0 && self.handIDCardID.length > 0) {
        
        if ([self.idCardFrontID isEqualToString:@"缺少参数"]) {
            params[@"FrontIDcard"] = @"";
        }else{
            params[@"FrontIDcard"] = self.idCardFrontID;
        }
        if ([self.idCardFanID isEqualToString:@"缺少参数"]) {
            params[@"negativeIDcard"] = @"";
        }else{
            params[@"negativeIDcard"] = self.idCardFanID;
        }
        if ([self.handIDCardID isEqualToString:@"缺少参数"]) {
            params[@"HandheldIDcard"] = @"";
        }else{
            params[@"HandheldIDcard"] = self.handIDCardID;
        }
        
    }else{
        params[@"FrontIDcard"] = @"";
        params[@"negativeIDcard"] = @"";
        params[@"HandheldIDcard"] = @"";
    }
    
    if (JiuDian(self.profession)) {//只有酒店有执照/地址
        params[@"Businesslicense"] = self.otherCardID;
        params[@"Adress"] = self.address;
    }else{
        params[@"Businesslicense"] = @"";
        params[@"Adress"] = @"";
    }
    
    params[@"Logo"] = self.iconID;
    
    if (CheShou(self.profession)) {//只有车手有驾照/车型
        params[@"Drivinglicense"] = self.otherCardID;
        params[@"ModelID"] = self.carModelID;
    }else{
        params[@"Drivinglicense"] = @"";
        params[@"ModelID"] = @"0";//没有传0
    }
    
    
    params[@"CorpID"] = @"0";//用户端不提供婚庆公司注册、传0
    params[@"Age"] = @"0";//选填 传0
    params[@"OwnedCompany"] = @"";//选填
    if (self.addressID.length > 0) {
        params[@"Region"] = self.addressID;
    }else{
        params[@"Region"] = @"";
    }
    
    params[@"AuthCodeID"] = self.authCodeID;
     params[@"YQCode"] = self.YQCodeWTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            UIViewController *mineVC = nil;
            for (UIViewController * controller in self.navigationController.viewControllers) {
                //遍历
                if([controller isKindOfClass:[YPReLoginController class]]){
                    //这里判断是否为你想要跳转的页面
                    mineVC = controller;
                    break;
                }
            }
            [self.navigationController popToViewController:mineVC  animated:YES];
            
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
