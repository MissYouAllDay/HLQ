//
//  YPChangePhoneController.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/6.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPChangePhoneController.h"
#import "YPCountButton.h"
#import "YPChangeNewPhoneController.h"//添加新手机号

@interface YPChangePhoneController ()<CountButtonDelegate>

@property (nonatomic, strong) JVFloatLabeledTextField *yanZhengMaTF;

//验证码
@property (nonatomic, strong) YPCountButton *smsBtn;

@property (nonatomic, copy) NSString *phone;

@end

@implementation YPChangePhoneController{
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
    
    NSString *phone = [self.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
    
    UILabel *tip = [[UILabel alloc]init];
    tip.text = [NSString stringWithFormat:@"请输入手机 %@ 收到的短信验证码",phone];
    tip.font = kFont(15);
    tip.textColor = TextNormalColor;
    [self.view addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(20);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    view.layer.cornerRadius = 2;
    view.clipsToBounds = YES;
    view.layer.borderColor = GrayColor.CGColor;
    view.layer.borderWidth = 1;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-135);
        make.top.mas_equalTo(tip.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(40);
    }];
    
    //验证码
    self.yanZhengMaTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.yanZhengMaTF.font = kNormalFont;
    self.yanZhengMaTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"验证码", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.yanZhengMaTF.floatingLabelFont = kMostSmallFont;
    self.yanZhengMaTF.floatingLabelTextColor = [UIColor brownColor];
    self.yanZhengMaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:self.yanZhengMaTF];
    self.yanZhengMaTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.yanZhengMaTF.keepBaseline = YES;
    [self.yanZhengMaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
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
    [self.view addSubview:self.smsBtn];
    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.yanZhengMaTF.mas_right).mas_offset(5);
        make.left.mas_equalTo(view.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-30);
        make.top.bottom.mas_equalTo(view);
    }];
    
    UIView *div1 = [[UIView alloc]init];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(self.yanZhengMaTF.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    
    //不能接收短信
    UIButton *nextBtn = [[UIButton alloc] init];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"原手机号不能接收短信?"];
    [str addAttribute:NSUnderlineStyleAttributeName
                value:@(NSUnderlineStyleSingle)
                range:(NSRange){0,[str length]}];
    //此时如果设置字体颜色要这样
    [str addAttribute:NSForegroundColorAttributeName value:TextNormalColor  range:NSMakeRange(0,[str length])];
    
    //设置下划线颜色...
    [str addAttribute:NSUnderlineColorAttributeName value:TextNormalColor range:(NSRange){0,[str length]}];
    [nextBtn setAttributedTitle:str forState:UIControlStateNormal];
    nextBtn.titleLabel.font =kFont(15);
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(div1.mas_bottom).mas_offset(50);
//        make.height.mas_equalTo(45);
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
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"更换手机号";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    

    
    //设置导航栏右边下一步
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [doneBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

#pragma mark - 按钮点击事件
- (void)nextBtnClick{
    NSLog(@"不能接收手机号");
    
    //联系客服
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",kefuTel]]];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    if (self.yanZhengMaTF.text.length == 0) {

        [EasyShowTextView showText:@"请输入验证码!"];
    }else{
        //验证验证码
        [self verifySMSCodeRequest];
    }
    
//    YPChangeNewPhoneController *newPhone = [[YPChangeNewPhoneController alloc]init];
//    newPhone.wornPhone = self.phone;
//    [self.navigationController pushViewController:newPhone animated:YES];
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)smsBtnClick{
    NSLog(@"smsBtnClick");
    
    //获取验证码
    [self getSMSCodeRequest];
}

#pragma mark - CountButtonDelegate
- (void)countButtonClicked{
    NSLog(@"CountButtonDelegate");
    
    self.smsBtn.tfText = self.phone;
}

#pragma mark - 网络请求
#pragma mark 获取验证码
- (void)getSMSCodeRequest{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSMSCode";
    
//    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserType"] = @"1"; //0公司、1供应商
    params[@"Phone"] = self.phone;
    params[@"Type"] = @"3"; //0注册、 1重置登陆密码、2激活、3更换手机号
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"获取验证码成功"];
         
            
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
    
    [EasyShowLodingView showLoding];

    
    NSString *url = @"/api/HQOAApi/VerifySMSCode";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Phone"] = self.phone;
    params[@"Type"] = @"3";//0注册、 1重置登陆密码、2激活、3更换手机号
    params[@"SMSCode"] = self.yanZhengMaTF.text;
    params[@"UserType"] = @"1";  //0公司、1供应商
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showSuccessText:@"验证通过!"];

            YPChangeNewPhoneController *newPhone = [[YPChangeNewPhoneController alloc]init];
            newPhone.wornPhone = self.phone;
            newPhone.authCodeID = [object valueForKey:@"AuthCodeID"];
            [self.navigationController pushViewController:newPhone animated:YES];
            
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
- (NSString *)phone{
    if (!_phone) {
        _phone = UserPhone_New;
    }
    return _phone;
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
