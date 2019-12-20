//
//  YPRegisterStep3Controller.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegisterStep3Controller.h"
#import "YPRegisterInputCell.h"
#import "YPRegisterProtocolCell.h"
#import "YPReLoginController.h"//登录

@interface YPRegisterStep3Controller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//协议选择状态
@property (nonatomic, assign) BOOL btnSelected;

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *emailTF;
@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UITextField *surePwdTF;

@end

@implementation YPRegisterStep3Controller{
    NSMutableString *_nameString;//上传的图片字符串
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
    
    self.title = @"注册信息";
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.backgroundColor = CHJ_bgColor;
    [self.view addSubview:self.tableView];
    
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

- (UIView *)addFooterView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    [self.view addSubview:view];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:NavBarColor];
    [sureBtn setTitle:@"注册" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(view).mas_offset(50);
        make.height.mas_equalTo(45);
    }];
    
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPRegisterInputCell *cell = [YPRegisterInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"昵称";
        cell.inputTF.placeholder = @"请输入昵称";
        self.nameTF = cell.inputTF;
        
    }else if (indexPath.row == 1) {
        cell.nameLabel.text = @"邮箱";
        cell.inputTF.placeholder = @"请输入邮箱(选填)";
        self.emailTF = cell.inputTF;
        
    }else if (indexPath.row == 2) {
        cell.nameLabel.text = @"密码";
        cell.inputTF.placeholder = @"请输入密码";
        cell.inputTF.secureTextEntry = YES;
        self.pwdTF = cell.inputTF;
        
    }else if (indexPath.row == 3) {
        cell.nameLabel.text = @"确认密码";
        cell.inputTF.placeholder = @"请再次输入密码";
        cell.inputTF.secureTextEntry = YES;
        self.surePwdTF = cell.inputTF;
        
    }else if (indexPath.row == 4) {
        YPRegisterProtocolCell *cell = [YPRegisterProtocolCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!self.btnSelected) {
            cell.selectBtn.selected = YES;
            self.btnSelected = cell.selectBtn.selected;
        }
        [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.protocolBtn addTarget:self action:@selector(xieyiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 100;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return [self addFooterView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 按钮点击事件
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.btnSelected = sender.selected;
}

- (void)xieyiBtnClick{
    NSLog(@"xieyiBtnClick");
}

- (void)sureBtnClick{
    NSLog(@"sureBtnClick");
    
    if (self.btnSelected == NO) {
        Alertmsg(@"请阅读商家协议,并同意", nil)
    }else if (self.nameTF.text.length == 0 || self.pwdTF.text.length == 0){
        Alertmsg(@"请填写必需的注册信息", nil)
    }else if (self.surePwdTF.text != self.pwdTF.text){
        Alertmsg(@"请确定两次填写的密码一致", nil)
    }else{

        //注册
        [self registerCorp];
    }
}

#pragma mark - 网络请求
#pragma mark 注册
- (void)registerCorp{
    
    [EasyShowLodingView showLoding];

    
    NSString *url = @"/api/Corp/RegisterCorp";

    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
   
    params[@"Orgcode"]      = self.origID;
    params[@"CorpName"]     = self.comName;
    params[@"CorpAlias"]    = self.comAlias;
    params[@"LicenseImg"]   = self.licenseID;
    params[@"Logo"]   = @"";
    params[@"ManagerName"]  = self.manName;
    params[@"UserTel"]      = self.manPhone;
    params[@"AreaID"]       = self.areaId;
    params[@"Address"]      = self.address;
    params[@"AuthCodeID"]   = self.AuthCodeID;
    params[@"UserName"]     = self.userName;
    NSString *pwd           = [self.surePwdTF.text md5String];
    params[@"UserPwd"]      = pwd;
    params[@"Nickname"]     = self.nameTF.text;
    params[@"Email"]        = self.emailTF.text;
    params[@"Phone"]        = self.phone;
    params[@"FrontIDcard"]   = @"";
    params[@"negativeIDcard"]   = @"";
    params[@"HandheldIDcard"]   = @"";

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注册成功,审核完成后可正常登录（1-5个工作日），我们会通知您，请耐心等待" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                UIViewController *mineVC = nil;
                for (UIViewController * controller in weakSelf.navigationController.viewControllers) {
                    //遍历
                    if([controller isKindOfClass:[YPReLoginController class]]){
                        //这里判断是否为你想要跳转的页面
                        mineVC = controller;
                        break;
                    }
                }
                [weakSelf.navigationController popToViewController:mineVC  animated:YES];
                
            }];
            [alertVC addAction:action];
            [weakSelf presentViewController:alertVC animated:YES completion:nil];
            
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
