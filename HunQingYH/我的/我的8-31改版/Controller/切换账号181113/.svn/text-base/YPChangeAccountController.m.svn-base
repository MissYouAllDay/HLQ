//
//  YPChangeAccountController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/13.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPChangeAccountController.h"
#import "YPChangeAccountListCell.h"
#import "YPChangeAccountAddCell.h"
#import "YPReLoginPwdController.h"//密码登录-添加账号

@interface YPChangeAccountController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPChangeAccountController{
    UIView *_navView;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
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
    titleLab.text = @"切换账号";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPChangeAccountListCell *cell = [YPChangeAccountListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.changeBtn.userInteractionEnabled = NO;
    
    if (indexPath.row == 0) {
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:Headportrait_New] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.titleName.text = UserName_New;
        cell.phoneLabel.text = UserPhone_New;
        cell.changeBtn.selected = NO;
    }else{
        NSString *phone = UserPhone_Second;
        
        NSLog(@"11111 %@\n%@\n%@\n%@\n",[NSString stringWithFormat:@"%@",UserName_Second],[NSString stringWithFormat:@"%@",Headportrait_Second],[NSString stringWithFormat:@"%@",UserPhone_Second],[NSString stringWithFormat:@"%@",Password_Second]);
        
        if (phone.length > 0) {//18-11-13 没有密码时也显示,但是切换时提示重新登录
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:Headportrait_Second] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            cell.titleName.text = UserName_Second;
            cell.phoneLabel.text = UserPhone_Second;
            cell.changeBtn.selected = YES;
        }else{
            YPChangeAccountAddCell *cell = [YPChangeAccountAddCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.addBtn.userInteractionEnabled = NO;
            return cell;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 144;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        NSString *phone = UserPhone_Second;
        if (phone.length > 0) {
            return 70;
        }else{
            return 0.1;
        }
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        NSString *phone = UserPhone_Second;
        if (phone.length > 0) {
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = WhiteColor;
            UIButton *clear = [[UIButton alloc]init];
            [clear setTitle:@"清除本地登录记录" forState:UIControlStateNormal];
            [clear setTitleColor:RGBS(199) forState:UIControlStateNormal];
            clear.titleLabel.font = kFont(14);
            [clear addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:clear];
            [clear mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(50);
                make.centerX.mas_equalTo(view);
            }];
            return view;
        }else{
            return nil;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        NSString *phone = UserPhone_Second;
        NSString *pwd = Password_Second;
        if (phone.length > 0 && pwd.length > 0) {
            //登录
            NSLog(@"登录");
            [self PhoneGetUserInfo];
        }else{
            if (phone.length > 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"该账号已失效,请重新登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                [alert show];
            }else{
                //添加账号
                YPReLoginPwdController *pwd = [[YPReLoginPwdController alloc]init];
                pwd.inType = @"2";/**进入方式: 1:修改密码 2:添加账号 3:添加账号中重置密码*/
                [self.navigationController pushViewController:pwd animated:YES];
            }
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //重新登录
        YPReLoginPwdController *pwd = [[YPReLoginPwdController alloc]init];
        pwd.inType = @"2";/**进入方式: 1:修改密码 2:添加账号 3:添加账号中重置密码*/
        [self.navigationController pushViewController:pwd animated:YES];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearClick{
    NSLog(@"clearClick");
    
    [EasyShowTextView showText:@"清除成功!" inView:self.view];
    
    //将第二账号清空
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Name_Second"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Headportrait_Second"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Phone_Second"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Password_Second"];
    [self.tableView reloadData];
}

#pragma mark - 网络请求
#pragma mark 根据手机号密码获取用户信息
- (void)PhoneGetUserInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/PhoneGetUserInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Phone"] = UserPhone_Second;
    params[@"PassWord"] = Password_Second;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            [EasyShowTextView showText:@"切换账号成功!" inView:self.view];
            
            [[NSUserDefaults standardUserDefaults]setObject:UserName_New forKey:@"Name_Second"];
            [[NSUserDefaults standardUserDefaults]setObject:Headportrait_New forKey:@"Headportrait_Second"];
            [[NSUserDefaults standardUserDefaults]setObject:UserPhone_New forKey:@"Phone_Second"];
            
            //18-11-13 存储密码
            //先拿到之前的当前账号密码
            NSString *prePWD = Password_New;
            //先把之前的第二账号密码存储为当前账号密码
            [[NSUserDefaults standardUserDefaults] setObject:Password_Second forKey:@"Password_New"];
            //再把之前的当前账号密码存储为第二账号密码
            [[NSUserDefaults standardUserDefaults]setObject:prePWD forKey:@"Password_Second"];
            
            NSLog(@"123 %@\n%@\n%@\n%@\n%@\n",[NSString stringWithFormat:@"%@",UserName_New],[NSString stringWithFormat:@"%@",Headportrait_New],[NSString stringWithFormat:@"%@",UserPhone_New],[NSString stringWithFormat:@"%@",Password_New],[NSString stringWithFormat:@"%@",Headportrait_Second]);
            
            [CXDataManager savaUserInfo:object];

            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        //        [self showNetErrorEmptyView];
        
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
