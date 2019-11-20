//
//  YPRegistStep1Controller.m
//  hunqing
//
//  Created by YanpengLee on 2017/5/12.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegistStep1Controller.h"
#import "YPCountButton.h"
#import "YPRegistStep2Controller.h"

@interface YPRegistStep1Controller ()<CountButtonDelegate>

@property (nonatomic, strong) JVFloatLabeledTextField *phoneTF;
@property (nonatomic, strong) JVFloatLabeledTextField *smsTF;
@property (nonatomic, strong) YPCountButton *smsBtn;

@end

@implementation YPRegistStep1Controller{
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"注册";
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

- (void)setupUI{
    
    self.view.backgroundColor = CHJ_bgColor;
    
    UIView *view1 = [[UIView alloc]init];
    view1.layer.borderColor = LightGrayColor.CGColor;
    view1.layer.borderWidth = 1;
    view1.backgroundColor = WhiteColor;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(_navView.mas_bottom).mas_offset(20);
         make.left.mas_equalTo(20);
         make.right.mas_equalTo(-20);
         make.height.mas_equalTo(45);
     }];
    
    self.phoneTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.phoneTF.font = kNormalFont;
    self.phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入注册手机号", @"") attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.phoneTF.floatingLabelFont = kMostSmallFont;
    self.phoneTF.floatingLabelTextColor = [UIColor brownColor];
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.phoneTF];
    self.phoneTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.phoneTF.keepBaseline = YES;
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(view1).mas_offset(10);
         make.centerY.mas_equalTo(view1);
         make.right.mas_equalTo(view1).mas_offset(-10);
     }];
    
    
    UIView *view2 = [[UIView alloc]init];
    view2.layer.borderColor = LightGrayColor.CGColor;
    view2.layer.borderWidth = 1;
    view2.backgroundColor = WhiteColor;
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(view1.mas_bottom).mas_offset(15);
         make.left.mas_equalTo(20);
         make.right.mas_equalTo(-120);
         make.height.mas_equalTo(45);
     }];
    
    self.smsTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.smsTF.font = kNormalFont;
    self.smsTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入验证码", @"") attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.smsTF.floatingLabelFont = kMostSmallFont;
    self.smsTF.floatingLabelTextColor = [UIColor brownColor];
    self.smsTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.smsTF];
    self.smsTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.smsTF.keepBaseline = YES;
    [self.smsTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view2).mas_offset(10);
        make.centerY.mas_equalTo(view2);
        make.right.mas_equalTo(view2).mas_offset(-10);
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
//    [self.smsBtn addTarget:self action:@selector(smsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.smsBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.smsBtn.titleLabel.font = kNormalFont;
    self.smsBtn.backgroundColor = NavBarColor;
    [self.view addSubview:self.smsBtn];
    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view2.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.top.bottom.mas_equalTo(view2);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:NavBarColor];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(view2.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(45);
    }];
    
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)smsBtnClick{
//    NSLog(@"smsBtnClick");
//
//    if (self.phoneTF.text.length == 0) {
//        Alertmsg(@"请输入手机号", nil)
//    }else{
//
//        //获取验证码
//        [self getSMSCodeRequest];
//    }
//}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.phoneTF.text.length == 0) {
        Alertmsg(@"请输入手机号", nil)
    }else if (self.smsTF.text.length == 0) {
        Alertmsg(@"请输入验证码", nil)
    }else{
        
        //验证验证码
        [self verifySMSCodeRequest];
    }
    
//    YPRegistStep2Controller *step2 = [[YPRegistStep2Controller alloc]init];
//    [self.navigationController pushViewController:step2 animated:YES];
}

#pragma mark - CountButtonDelegate
- (void)countButtonClicked{
    NSLog(@"CountButtonDelegate");
    
    self.smsBtn.tfText = self.phoneTF.text;
    
    
    if (self.phoneTF.text.length>0) {
        [self getSMSCodeRequest];
    }
}

#pragma mark - 网络请求
#pragma mark 获取验证码
- (void)getSMSCodeRequest{
        [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetSMSCode";

 
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserType"] = @"0"; //0员工、1供应商
    params[@"Phone"] = self.phoneTF.text;
    params[@"Type"] = @"0"; //0注册、 1重置登陆密码、2激活
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
              [EasyShowTextView showSuccessText:@"获取验证码成功!！"];
            
         
            
        }else{
            
           [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        

            

        }
        
    } Failure:^(NSError *error) {
        

         [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
   // 菊花不会自动消失，需要自己移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
        
    }];
    
}

#pragma mark 校验验证码
- (void)verifySMSCodeRequest{
    
        [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/VerifySMSCode";
    
 
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = self.phoneTF.text;
    params[@"Type"] = @"0"; //0注册、 1重置登陆密码、2激活
    params[@"SMSCode"] = self.smsTF.text;
    params[@"UserType"] = @"0";  //0员工、1供应商
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            YPRegistStep2Controller *step2VC = [[YPRegistStep2Controller alloc]init];
            step2VC.phone = self.phoneTF.text;
            step2VC.AuthCodeID = [object objectForKey:@"AuthCodeID"];
            [self.navigationController pushViewController:step2VC animated:YES];
            
        }else{
            
     [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
   
        }
        
    } Failure:^(NSError *error) {
       [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
   // 菊花不会自动消失，需要自己移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
        
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
