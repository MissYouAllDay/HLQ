//
//  YPReMyWalletAddBankController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPReMyWalletAddBankController.h"
#import "YPReMyWalletAddBankInputCell.h"
#import "HRTiXianViewController.h"//提现

@interface YPReMyWalletAddBankController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

/*******************************************************/
/**所属银行*/
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, strong) UITextField *bankNameTF;
/**账户名称*/
@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, strong) UITextField *accountNameTF;
/**银行开户账号*/
@property (nonatomic, copy) NSString *accountNum;
@property (nonatomic, strong) UITextField *accountNumTF;
/**账户开户行*/
@property (nonatomic, copy) NSString *bankAddress;
@property (nonatomic, strong) UITextField *bankAddressTF;
/**接受账户相关信息的手机号码*/
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, strong) UITextField *phoneNumTF;
/*******************************************************/

@end

@implementation YPReMyWalletAddBankController{
    UIView *_navView;
    UIButton *_submitBtn;
}

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
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
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
    titleLab.text = @"添加银行卡";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - UI
- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-62) style:UITableViewStylePlain];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
    }
    _submitBtn.enabled = NO;
    [_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateDisabled];
    [_submitBtn setTitleColor:RGBA(255, 207, 139, 1) forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = kFont(14);
    if (_submitBtn.isEnabled) {
        _submitBtn.backgroundColor = RGBA(51, 51, 51, 1);
    }else{
        _submitBtn.backgroundColor = RGBA(221, 221, 221, 1);
    }
    _submitBtn.layer.cornerRadius = 4;
    _submitBtn.clipsToBounds = YES;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_submitBtn];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-12);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPReMyWalletAddBankInputCell *cell = [YPReMyWalletAddBankInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.inputTF.delegate = self;
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"所属银行";
        cell.inputTF.placeholder = @"银行卡所属银行";
        self.bankNameTF = cell.inputTF;
        if (self.bankName.length > 0) {
            cell.inputTF.text = self.bankName;
        }
    }else if (indexPath.row == 1){
        cell.titleLabel.text = @"账户名称(公司全称)";
        cell.inputTF.placeholder = @"开户名称";
        self.accountNameTF = cell.inputTF;
        if (self.accountName.length > 0) {
            cell.inputTF.text = self.accountName;
        }
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"银行开户账号";
        cell.inputTF.placeholder = @"开户账号";
        self.accountNumTF = cell.inputTF;
        if (self.accountNum.length > 0) {
            cell.inputTF.text = self.accountNum;
        }
    }else if (indexPath.row == 3){
        cell.titleLabel.text = @"账户开户行";
        cell.inputTF.placeholder = @"开户行";
        self.bankAddressTF = cell.inputTF;
        if (self.bankAddress.length > 0) {
            cell.inputTF.text = self.bankAddress;
        }
    }else if (indexPath.row == 4){
        cell.titleLabel.text = @"接收账户相关信息的手机号码";
        cell.inputTF.placeholder = @"手机号码";
        self.phoneNumTF = cell.inputTF;
        if (self.phoneNum.length > 0) {
            cell.inputTF.text = self.phoneNum;
        }
    }else if (indexPath.row == 5){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc]init];
        label.text = @"添加成功后可前往“我的银行卡”查看";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(18);
            make.right.bottom.mas_equalTo(-18);
        }];
        return cell;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return 44;
    }else{
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.bankNameTF) {
        self.bankName = textField.text;
    }else if (textField == self.accountNameTF){
        self.accountName = textField.text;
    }else if (textField == self.accountNumTF){
        self.accountNum = textField.text;
    }else if (textField == self.bankAddressTF){
        self.bankAddress = textField.text;
    }else if (textField == self.phoneNumTF){
        self.phoneNum = textField.text;
    }
    if (self.bankName.length > 0 && self.accountName.length > 0 && self.accountNum.length > 0 && self.bankAddress.length > 0 && self.phoneNum.length > 0) {
        _submitBtn.enabled = YES;
        _submitBtn.backgroundColor = RGBA(51, 51, 51, 1);
    }else{
        _submitBtn.enabled = NO;
        _submitBtn.backgroundColor = RGBA(221, 221, 221, 1);
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    
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
    params[@"SourceType"] = @"0";//0银行卡,1支付宝
    params[@"Number"] = self.accountNum;
    params[@"AccountName"] = self.accountName;
    params[@"OpeningBank"] = self.bankAddress;
    params[@"Phone"] = self.phoneNum;
    params[@"AffiliatedBank"] = self.bankName;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加银行卡成功!" inView:self.tableView];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
