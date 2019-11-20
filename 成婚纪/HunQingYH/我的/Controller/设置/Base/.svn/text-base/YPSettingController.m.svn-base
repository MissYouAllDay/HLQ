//
//  YPSettingController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPSettingController.h"
#import "YPChangePhoneController.h"
//#import "YPChangeNewPhoneController.h"
//#import "YPChangePwdController.h"
//#import "YPForgetController.h"//修改密码
//#import "YPFirstViewController.h"
#import "YPReLoginController.h"//登录
#import "YPReLoginController.h"
#import "YPContractController.h"//联系我们
#import "LCTabBarController.h"
#import "HRFeedBackViewController.h"//意见反馈
#import "YPReLoginForgetController.h"//18-08-11 修改密码
#import "WXApi.h"

@interface YPSettingController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPSettingController{
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
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        // Fallback on earlier versions
//
//    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editPWDPresentLoginVC) name:@"EditPWDAndPresentLoginVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhonePresentLoginVC) name:@"ChangePhoneAndPresentLoginVC" object:nil];
}

#pragma mark - 通知
- (void)editPWDPresentLoginVC{
    
    NSLog(@"修改密码完成!");
    
    YPReLoginController *login = [[YPReLoginController alloc]init];
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:loginNav animated:YES completion:nil];
    
}

- (void)changePhonePresentLoginVC{
    NSLog(@"修改手机号完成!");
    
    YPReLoginController *login = [[YPReLoginController alloc]init];
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:loginNav animated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EditPWDAndPresentLoginVC" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangePhoneAndPresentLoginVC" object:nil];
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
    titleLab.text = @"设置";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 4;
//    return 3;//18-08-11 去掉修改手机
    return 4;//18-08-16 添加绑定微信
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"绑定微信";
        cell.detailTextLabel.text = WeChatName_New;
        cell.detailTextLabel.textColor = GrayColor;
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"修改密码";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"联系客服";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"意见反馈";
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
        return  [self addFooterView];
    }else{
        return nil;
    }
}

- (UIView *)addFooterView{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:NavBarColor];
    [sureBtn setTitle:@"退出登录" forState:UIControlStateNormal];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //绑定微信/解除绑定
        NSString *str = WeChatType_New;
        if ([str integerValue] == 0) {//0未绑定，1已绑定
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"绑定微信", nil];
            sheet.tag = 1234;
            [sheet showInView:self.view];
        }else if ([str integerValue] == 1){
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"解除绑定", nil];
            sheet.tag = 4321;
            [sheet showInView:self.view];
        }
    }else if (indexPath.row == 1) {
        //修改密码
//        YPChangePwdController *pwd = [[YPChangePwdController alloc]init];
//        [self.navigationController pushViewController:pwd animated:YES];
        
        
//        YPForgetController *pwd = [[YPForgetController alloc]init];
        
        YPReLoginForgetController *pwd = [[YPReLoginForgetController alloc]init];
        pwd.titleStr = @"修改密码";
        [self.navigationController pushViewController:pwd animated:YES];
        
    }else if (indexPath.row == 2) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"联系客服" message:kefuTel delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
//        alert.tag = 1002;
//        [alert show];
        
        YPContractController *contract = [[YPContractController alloc]init];
        [self.navigationController presentViewController:contract animated:YES completion:nil];
        
    }else if (indexPath.row == 3) {
        
        //意见反馈
        HRFeedBackViewController *feedBackVC = [HRFeedBackViewController new];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && actionSheet.tag == 1234) {//1234 未绑定，4321已绑定
        NSLog(@"绑定");
        //微信授权
        [self authWeChat];
        
    }else if (buttonIndex == 0 && actionSheet.tag == 4321){
        NSLog(@"解除");
        [self UserJieBangWX];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    NSLog(@"退出登录");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定退出?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag =1001;
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            
            //注销->清除本地信息 2018-08-11
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"UserId_New"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Name_New"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Headportrait_New"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Profession_New"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Phone_New"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"FacilitatorId_New"];
            
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"region_New"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"regionname_New"];
            
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"WeChatName_New"];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"WeChatType_New"];
            
            //旧
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"isLogin"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"UserID"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"TrueName"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Profession"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Headportrait"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Phone"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"CorpID"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Age"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"StatusType"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"SupplierID"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"ModelID"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"RummeryID"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"IsRummeryInfo"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Region"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"BriefinTroduction"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Name"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"OwnedCompany"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Adress"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"CreateTime"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"IsSearch"];
//            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"SuppLierCreateTime"];
            
            [self.navigationController popViewControllerAnimated:NO];
      


        }

    }else  if (alertView.tag == 1002) {
        if (buttonIndex == 0) {
            
        }else{
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",kefuTel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        

    }
    
}

#pragma mark - 微信授权
- (void)authWeChat{
    
    if ([WXApi isWXAppInstalled]) {
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
                 
                 //18-08-16 绑定微信
                 [self UserBindingWXWithOpenID:user.uid Token:user.credential.token];
                 
             }
             
             else
             {
                 NSLog(@"%@",error);
                 [EasyShowTextView showErrorText:@"登录失败"];
             }
             
         }];

    }else {
        [EasyShowTextView showText:@"您未安装微信客户端"];
    }
}

#pragma mark - 网络请求
#pragma mark 用户绑定微信
- (void)UserBindingWXWithOpenID:(NSString *)openID Token:(NSString *)token{
    
    [EasyShowLodingView showLoding];

    NSString *url = @"/api/HQOAApi/UserBindingWX";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"OpenId"] = openID;
    params[@"Token"] = token;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"微信绑定成功!"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[object valueForKey:@"WeChatName"] forKey:@"WeChatName_New"];
            [[NSUserDefaults standardUserDefaults] setObject:[object valueForKey:@"WeChatType"] forKey:@"WeChatType_New"];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络请求错误, 请重试!" inView:self.view];
        
    }];
    
}

#pragma mark 用户解绑微信
- (void)UserJieBangWX{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UserJieBangWX";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"微信解绑成功!"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[object valueForKey:@"WeChatName"] forKey:@"WeChatName_New"];
            [[NSUserDefaults standardUserDefaults] setObject:[object valueForKey:@"WeChatType"] forKey:@"WeChatType_New"];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络请求错误, 请重试!" inView:self.view];
        
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
