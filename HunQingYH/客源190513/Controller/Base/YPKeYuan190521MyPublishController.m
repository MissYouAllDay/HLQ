//
//  YPKeYuan190521MyPublishController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/21.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190521MyPublishController.h"
#import "YPGetUserJSJTableList.h"
#import "YPKeYuan190521MyPubulishCell.h"
#import "YPGetHistoryInvitationRecord.h"

@interface YPKeYuan190521MyPublishController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetUserJSJTableList *> *listMarr;
@property (nonatomic, strong) NSMutableArray<YPGetHistoryInvitationRecord *> *recordMarr;

@end

@implementation YPKeYuan190521MyPublishController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (_type == 1) {
        [self GetUserJSJTableList];
    }else{
        [self GetHistoryInvitationRecord];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    if (_type == 1) {
        titleLab.text = @"我的发布";
    }else{
        titleLab.text = @"推荐记录";
    }
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_type == 1) {
        return self.listMarr.count;
    }else{
        return self.recordMarr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 1) {
        YPGetUserJSJTableList *list = self.listMarr[indexPath.section];
        
        YPKeYuan190521MyPubulishCell *cell = [YPKeYuan190521MyPubulishCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = list.Name;
        cell.phoneLabel.text = list.Phone;
        cell.timeLabel.text = list.Weddtime;
        cell.zhuoshu.text = list.TablesNumber;
        cell.canbiao.text = list.MealMark;
        cell.area.text = list.AreaId;
        cell.deleteBtn.hidden = YES;
        cell.deleteBtn.tag = indexPath.section + 1000;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        YPGetHistoryInvitationRecord *list = self.recordMarr[indexPath.section];
        
        YPKeYuan190521MyPubulishCell *cell = [YPKeYuan190521MyPubulishCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = list.Name;
        cell.phoneLabel.text = list.Phone;
        cell.timeLabel.text = list.MarriagePeriod;
        cell.zhuoshu.text = list.TableNumber;
        cell.canbiao.text = list.MealMark;
        cell.area.text = list.Area;
        cell.deleteBtn.hidden = YES;
//        cell.deleteBtn.tag = indexPath.section + 1000;
//        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    if (_type == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)deleteBtnClick:(UIButton *)sender{
    
}

#pragma mark - 网络请求
#pragma mark 新人查看历史预定列表
- (void)GetUserJSJTableList{
    
    NSString *url = @"/api/HQOAApi/GetUserJSJTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            self.listMarr = [YPGetUserJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.tableView reloadData];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
    }];
    
}

#pragma mark 获取历史邀请记录(个人版)
- (void)GetHistoryInvitationRecord{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHistoryInvitationRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"50";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.recordMarr removeAllObjects];
            
            self.recordMarr = [YPGetHistoryInvitationRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
