//
//  HRAddZFBController.m
//  HunQingYH
//
//  Created by Hiro on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "HRAddZFBController.h"
#import "HRTiXianQueRenController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "HRTiXianViewController.h"//提现

@interface HRAddZFBController ()<UITextFieldDelegate>{
    UIView *_navView;
    UIButton *btn;
    
}
/**输入框*/
@property (nonatomic, strong) JVFloatLabeledTextField *inPutTextField;
/**18-11-20 姓名输入框*/
@property (nonatomic, strong) JVFloatLabeledTextField *nameTextField;

@end

@implementation HRAddZFBController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =WhiteColor;
 // TODO:
    self.ZFBCountStr =@"";
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"添加支付宝账户";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    
}
-(void)setupUI{
    
//    self.inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, NAVIGATION_BAR_HEIGHT+30, ScreenWidth-40, 50)];
//    self.inPutTextField.delegate =self;
//    self.inPutTextField.placeholder =@"请输入支付宝账户";
//    self.inPutTextField.text =self.ZFBCountStr;
//    self.inPutTextField.font =kFont(22);
//    [self.view addSubview:self.inPutTextField];
    
    self.inPutTextField = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(20, NAVIGATION_BAR_HEIGHT+30, ScreenWidth-40, 50)];
    self.inPutTextField.font = kFont(22);
    self.inPutTextField.text = self.ZFBCountStr;
    self.inPutTextField.delegate = self;
    self.inPutTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入支付宝账户", @"") attributes:@{NSForegroundColorAttributeName: RGBS(199)}];
    self.inPutTextField.floatingLabelFont = kSmallFont;
    self.inPutTextField.floatingLabelTextColor = [UIColor brownColor];
    self.inPutTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.inPutTextField];
    self.inPutTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.inPutTextField.keepBaseline = YES;
    [self.inPutTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT+36);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(50);
    }];
    
    UIView *lineview1 = [[UIView alloc]init];
    lineview1.backgroundColor =CHJ_bgColor;
    [self.view addSubview:lineview1];
    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inPutTextField.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.inPutTextField);
        make.height.mas_equalTo(1);
    }];

    self.nameTextField = [[JVFloatLabeledTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.inPutTextField.frame)+20, ScreenWidth-40, 50)];
    self.nameTextField.font = kFont(22);
    self.nameTextField.text = self.ZFBNameStr;
    self.nameTextField.delegate = self;
    self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"请输入支付宝真实姓名", @"") attributes:@{NSForegroundColorAttributeName: RGBS(199)}];
    self.nameTextField.floatingLabelFont = kSmallFont;
    self.nameTextField.floatingLabelTextColor = [UIColor brownColor];
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nameTextField];
    self.nameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameTextField.keepBaseline = YES;
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineview1.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(50);
    }];
    
    UIView *lineview2 = [[UIView alloc]init];
    lineview2.backgroundColor =CHJ_bgColor;
    [self.view addSubview:lineview2];
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextField.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.nameTextField);
        make.height.mas_equalTo(1);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
//
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    btn = [[UIButton alloc]init];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    if ([self.ZFBCountStr isEqualToString:@""]) {
        [btn setTitleColor:RGBA(187, 187, 187, 1) forState:UIControlStateNormal];
        btn.backgroundColor = RGBA(221, 221, 221, 1);
        btn.userInteractionEnabled =NO;
    }else{
        [btn setTitleColor:RGBA(255, 207, 139, 1) forState:UIControlStateNormal];
        btn.backgroundColor = RGBA(51, 51, 51, 1);
         btn.userInteractionEnabled =YES;

    }
    btn.titleLabel.font = kFont(16);
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-12);
    }];
}
#pragma mark ------uitextfieldDelegate ----
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.inPutTextField) {
        self.ZFBCountStr =textField.text;
    }else if (textField == self.nameTextField){
        self.ZFBNameStr = textField.text;
    }
    if (self.ZFBCountStr.length > 0 && self.ZFBNameStr.length > 0) {
        [btn setTitleColor:RGBA(255, 207, 139, 1) forState:UIControlStateNormal];
        btn.backgroundColor = RGBA(51, 51, 51, 1);
        btn.userInteractionEnabled = YES;
    }else{
        [btn setTitleColor:RGBA(187, 187, 187, 1) forState:UIControlStateNormal];
        btn.backgroundColor = RGBA(221, 221, 221, 1);
        btn.userInteractionEnabled = NO;
    }
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)submitBtnClick{
    [self CreateFacilitatorAccountNumberInfo];
}

#pragma mark - 网络请求
#pragma mark 添加提现账号信息
- (void)CreateFacilitatorAccountNumberInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateFacilitatorAccountNumberInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (YongHu(Profession_New)) {
        params[@"FacilitatorId"] = UserId_New;
        params[@"Type"] = @"1";//1新人,2服务商
    }else{
        params[@"FacilitatorId"] = FacilitatorId_New;
        params[@"Type"] = @"2";//1新人,2服务商
    }
    params[@"SourceType"] = @"1";//0银行卡,1支付宝
    params[@"Number"] = self.ZFBCountStr;
    params[@"AccountName"] = self.ZFBNameStr;
    params[@"OpeningBank"] = @"";
    params[@"Phone"] = @"";
    params[@"AffiliatedBank"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加支付宝账号成功!" inView:self.view];
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.typeStr.integerValue == 1) {//更改账号
                    UIViewController *mineVC = nil;
                    for (UIViewController * controller in weakSelf.navigationController.viewControllers) {
                        //遍历
                        if([controller isKindOfClass:[HRTiXianViewController class]]){
                            //这里判断是否为你想要跳转的页面
                            mineVC = controller;
                            break;
                        }
                    }
                    [weakSelf.navigationController popToViewController:mineVC  animated:YES];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            });
            
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

@end
