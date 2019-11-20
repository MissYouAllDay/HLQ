//
//  YPChangeNewPhoneController.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/26.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPChangeNewPhoneController.h"
#import "YPCountButton.h"
#import "YPSettingController.h"
#import "YPReLoginController.h"

@interface YPChangeNewPhoneController ()<CountButtonDelegate>

@property (nonatomic, strong) JVFloatLabeledTextField *xinPhoneTF;
//@property (nonatomic, strong) JVFloatLabeledTextField *yanZhengMaTF;

//验证码
//@property (nonatomic, strong) YPCountButton *smsBtn;

@end

@implementation YPChangeNewPhoneController{
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
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *tip = [[UILabel alloc]init];
    tip.text = @"请输入新手机号";
    tip.font = kBigFont;
    tip.textColor = GrayColor;
    [self.view addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(20);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    view.layer.cornerRadius = 2;
    view.clipsToBounds = YES;
    view.layer.borderColor = NavBarColor.CGColor;
    view.layer.borderWidth = 1;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(tip.mas_bottom).mas_offset(30);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    
    //手机号
    self.xinPhoneTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
    self.xinPhoneTF.font = kNormalFont;
    //    self.xinPhoneTF.backgroundColor = WhiteColor;
    self.xinPhoneTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"新手机号", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.xinPhoneTF.floatingLabelFont = kMostSmallFont;
    self.xinPhoneTF.floatingLabelTextColor = [UIColor brownColor];
    self.xinPhoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:self.xinPhoneTF];
    self.xinPhoneTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.xinPhoneTF.keepBaseline = YES;
    [self.xinPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(35);
    }];
    
//    UIView *div1 = [[UIView alloc]init];
//    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
//    [self.view addSubview:div1];
//    div1.translatesAutoresizingMaskIntoConstraints = NO;
//    [div1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.xinPhoneTF);
//        make.top.mas_equalTo(self.xinPhoneTF.mas_bottom).mas_offset(10);
//        make.height.mas_equalTo(1);
//    }];
    
//    //验证码
//    self.yanZhengMaTF = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectZero];
//    self.yanZhengMaTF.font = kNormalFont;
//    self.yanZhengMaTF.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"验证码", @"")
//                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    self.yanZhengMaTF.floatingLabelFont = kMostSmallFont;
//    self.yanZhengMaTF.floatingLabelTextColor = [UIColor brownColor];
//    self.yanZhengMaTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.view addSubview:self.yanZhengMaTF];
//    self.yanZhengMaTF.translatesAutoresizingMaskIntoConstraints = NO;
//    self.yanZhengMaTF.keepBaseline = YES;
//    [self.yanZhengMaTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(30);
//        make.right.mas_equalTo(-120);
//        make.top.mas_equalTo(div1.mas_bottom).mas_offset(15);
//        make.height.mas_equalTo(35);
//    }];
//    
//    //验证码按钮
//    self.smsBtn = [YPCountButton buttonWithType:UIButtonTypeCustom];
//    self.smsBtn.countdownBeginNumber = 60;
//    self.smsBtn.normalStateImageName = nil;
//    self.smsBtn.normalStateBgImageName = nil;
//    self.smsBtn.highlightedStateImageName = nil;
//    self.smsBtn.highlightedStateBgImageName = nil;
//    self.smsBtn.selectedStateImageName = nil;
//    self.smsBtn.selectedStateBgImageName = nil;
//    self.smsBtn.delegate = self;
//    [self.smsBtn addTarget:self action:@selector(smsBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    self.smsBtn.titleLabel.font = kNormalFont;
//    self.smsBtn.backgroundColor = NavBarColor;
//    [self.view addSubview:self.smsBtn];
//    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.yanZhengMaTF.mas_right).mas_offset(5);
//        make.right.mas_equalTo(-30);
//        make.bottom.mas_equalTo(self.yanZhengMaTF);
//    }];
//    
//    UIView *div2 = [[UIView alloc]init];
//    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
//    [self.view addSubview:div2];
//    div2.translatesAutoresizingMaskIntoConstraints = NO;
//    [div2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(ScreenWidth);
//        make.top.mas_equalTo(self.yanZhengMaTF.mas_bottom).mas_offset(10);
//        make.height.mas_equalTo(1);
//    }];
    
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
    //设置导航栏右边完成
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

#pragma mark - target
- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    [self ReplacePhone];
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 修改手机号
- (void)ReplacePhone{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/ReplacePhone";
    
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"NewPhone"] = self.xinPhoneTF.text;
    params[@"WornPhone"] = self.wornPhone;
    params[@"AuthCodeID"] = self.authCodeID;
    params[@"UserType"] = @"1";//0公司、1供应商（用户）
    params[@"ObjectID"] = UserId_New;//相关对象ID
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
               [EasyShowTextView showSuccessText:@"修改成功!"];
       
            
            [[NSUserDefaults standardUserDefaults] setObject:self.xinPhoneTF.text forKey:@"Phone"];
            
            UIViewController *mineVC = nil;
            for (UIViewController * controller in weakSelf.navigationController.viewControllers) {
                //遍历
                if([controller isKindOfClass:[YPSettingController class]]){
                    //这里判断是否为你想要跳转的页面
                    mineVC = controller;
                    break;
                }
            }
            [weakSelf.navigationController popToViewController:mineVC  animated:YES];
            
            //通知 -- 返回后 弹出登录界面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangePhoneAndPresentLoginVC" object:nil];
            
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
