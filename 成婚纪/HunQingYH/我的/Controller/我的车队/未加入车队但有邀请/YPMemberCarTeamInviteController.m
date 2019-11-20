//
//  YPMemberCarTeamInviteController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMemberCarTeamInviteController.h"
#import "YPMemberCarTeamInviteCell.h"
#import "YPMyCarNewTeamController.h"
#import "YPGetUserInviteList.h"

@interface YPMemberCarTeamInviteController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetUserInviteList *> *listMarr;

@end

@implementation YPMemberCarTeamInviteController{
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
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
    [self GetUserInviteList];
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
    titleLab.text = @"我的车队";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [createBtn setTitle:@"创建车队" forState:UIControlStateNormal];
    [createBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:createBtn];
    [createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    createBtn.layer.cornerRadius = 2;
    createBtn.clipsToBounds = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetUserInviteList *list = self.listMarr[indexPath.section];
    
    YPMemberCarTeamInviteCell *cell = [YPMemberCarTeamInviteCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLabel.text = list.UserNmae;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.Logo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    cell.titleLabel.text = list.Name;
    
    cell.refuseBtn.tag = indexPath.section + 1000;
    cell.acceptBtn.tag = indexPath.section + 2000;
    
    [cell.refuseBtn addTarget:self action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.acceptBtn addTarget:self action:@selector(acceptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YPGetUserInviteList *list = self.listMarr[section];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = list.CreateTime;
    label.textColor = GrayColor;
    label.font = kNormalFont;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(view);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refuseBtnClick:(UIButton *)sender{
    
    NSLog(@"refuse %zd",sender.tag);
    
    YPGetUserInviteList *list = self.listMarr[sender.tag - 1000];
    [self FiredAndAgreedTeamWithRelaID:list.RelaID AndSupplierID:list.SupplierID AndType:@"3"];//0同意、1开除、3拒绝
    
}

- (void)acceptBtnClick:(UIButton *)sender{
    
    NSLog(@"accept %zd",sender.tag);
    
    YPGetUserInviteList *list = self.listMarr[sender.tag - 2000];
    [self FiredAndAgreedTeamWithRelaID:list.RelaID AndSupplierID:list.SupplierID AndType:@"0"];//0同意、1开除、3拒绝
}

- (void)createBtnClick{
    NSLog(@"创建车队");
    
    YPMyCarNewTeamController *newTeam = [[YPMyCarNewTeamController alloc]init];
    [self.navigationController yp_pushViewController:newTeam animated:YES];
}

#pragma mark - 网络请求
#pragma mark 车手查看邀请信息
- (void)GetUserInviteList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUserInviteList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"Type"] = @"1";//1邀请、2申请
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetUserInviteList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
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

#pragma mark 开除或同意车队成员
- (void)FiredAndAgreedTeamWithRelaID:(NSString *)relaID AndSupplierID:(NSString *)supplierID AndType:(NSString *)type{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/FiredAndAgreedTeam";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"RelaID"] = relaID;
    params[@"TeamType"] = type;//0同意、1开除、3拒绝
    params[@"RejectedWhy"] = @"";
    params[@"SupplierID"] = supplierID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"操作成功!"];
            if ([type integerValue] == 0) {//同意返回重新进入
                [self.navigationController popViewControllerAnimated:YES];
            }else{//否则刷新
                [self GetUserInviteList];
            }
            
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
- (NSMutableArray<YPGetUserInviteList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
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
