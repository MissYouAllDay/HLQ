//
//  YPChangePwdController.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/6.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPChangePwdController.h"
#import "YPSettingController.h"

@interface YPChangePwdController ()

@property (nonatomic, strong) JVFloatLabeledTextField *oriPwdTF;
@property (nonatomic, strong) JVFloatLabeledTextField *PSWNewTF;
@property (nonatomic, strong) JVFloatLabeledTextField *surePSWTF;

@end

@implementation YPChangePwdController{
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
    self.view.backgroundColor = WhiteColor;
    
    //原密码
    self.oriPwdTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.oriPwdTF.font = kNormalFont;
    self.oriPwdTF.secureTextEntry = YES;
    self.oriPwdTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"输入原密码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.oriPwdTF.floatingLabelFont = kMostSmallFont;
    self.oriPwdTF.floatingLabelTextColor = [UIColor brownColor];
    self.oriPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.oriPwdTF];
    self.oriPwdTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.oriPwdTF.keepBaseline = YES;
    [self.oriPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(30);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(35);
    }];
    
    UIView *div = [[UIView alloc]init];
    div.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div];
    div.translatesAutoresizingMaskIntoConstraints = NO;
    [div mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.oriPwdTF);
        make.top.mas_equalTo(self.oriPwdTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //新密码
    self.PSWNewTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.PSWNewTF.font = kNormalFont;
    self.PSWNewTF.secureTextEntry = YES;
    self.PSWNewTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"设置新密码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.PSWNewTF.floatingLabelFont = kMostSmallFont;
    self.PSWNewTF.floatingLabelTextColor = [UIColor brownColor];
    self.PSWNewTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.PSWNewTF];
    self.PSWNewTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.PSWNewTF.keepBaseline = YES;
    [self.PSWNewTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(div.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(35);
    }];
    
    UIView *div1 = [[UIView alloc]init];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.PSWNewTF);
        make.top.mas_equalTo(self.PSWNewTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //确认密码
    self.surePSWTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.surePSWTF.font = kNormalFont;
    self.surePSWTF.secureTextEntry = YES;
    self.surePSWTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"确认新密码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.surePSWTF.floatingLabelFont = kMostSmallFont;
    self.surePSWTF.floatingLabelTextColor = [UIColor brownColor];
    self.surePSWTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.surePSWTF];
    self.surePSWTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.surePSWTF.keepBaseline = YES;
    [self.surePSWTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.PSWNewTF);
        make.top.mas_equalTo(div1.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(35);
    }];
    
    UIView *div2 = [[UIView alloc]init];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    [div2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.surePSWTF);
        make.top.mas_equalTo(self.surePSWTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //提示信息
    UILabel *tip = [[UILabel alloc]init];
    tip.text = @"密码支持6-14位字符,建议数字、字母组合";
    tip.font = kNormalFont;
    tip.textColor = GrayColor;
    [self.view addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(div2.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.surePSWTF);
    }];
    
    //确定按钮
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setBackgroundColor:NavBarColor];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.surePSWTF);
        make.top.mas_equalTo(tip.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"修改密码";
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
- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.PSWNewTF.text.length == 0) {
        Alertmsg(@"请输入新密码", nil)
    }else if ([self.surePSWTF.text isEqualToString:self.PSWNewTF.text]){
        Alertmsg(@"请确定两次输入的密码一致", nil)
    }if (self.surePSWTF.text.length > 5 && self.surePSWTF.text.length < 14){
        Alertmsg(@"请确定输入的密码位数在指定范围内", nil)
    }else{
        
        //网络请求
//        [self resetPasswordRequest];
        
        [self.PSWNewTF resignFirstResponder];
        [self.surePSWTF resignFirstResponder];
    }
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
//- (void)resetPasswordRequest{
//    MBProgressHUD *hud = [MBProgressHUD wj_showActivityLoading:@"" toview:self.view];
//    NSString *url = @"/api/HQOAApi/ResetPassword";
//
//    __weak typeof(self) weakSelf = self;
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"Phone"] = self.phone;
//    NSString *pwd = [self.surePSWTF.text md5String];
//    params[@"NewPassword"] = pwd;
//    params[@"AuthCodeID"] = self.AuthCodeID;
//    params[@"Type"] = @"1";// 1重置登陆密码
//    params[@"UserType"] = @"1";//0公司、1供应商
//
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//        
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            [MBProgressHUD wj_showSuccess:@"设置新密码成功!" hideAfterDelay:1.0 toview:self.view];
////            Alertmsg(@"设置新密码成功", nil)
//            UIViewController *mineVC = nil;
//            for (UIViewController * controller in weakSelf.navigationController.viewControllers) {
//                //遍历
//                if([controller isKindOfClass:[YPSettingController class]]){
//                    //这里判断是否为你想要跳转的页面
//                    mineVC = controller;
//                    break;
//                }
//            }
//            [weakSelf.navigationController popToViewController:mineVC  animated:YES];
//
//        }else{
//
//            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:3.0 view:self.view];
//        }
//
//    } Failure:^(NSError *error) {
//
//        [MBProgressHUD wj_showError:@"网络错误，请稍后重试" hideAfterDelay:3.0 toview:self.view];
//    }];
//
//}

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
