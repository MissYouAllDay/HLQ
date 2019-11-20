//
//  YPInviteFriendsWedVIPRecordController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedVIPRecordController.h"
//#import "YPInviteFriendsWedVIPRecordView.h"
#import "YPInviteFriendsWedVIPRecordCell.h"
#import "YPInviteFriendsWedVIPRecordSubCell.h"
#import "WSTableviewTree.h"
#import "YPGetHistoryInvitationRecord.h"
#import "YPInviteFriendsWedVIPController.h"

@interface YPInviteFriendsWedVIPRecordController ()<WSTableViewDelegate>

@property (nonatomic, strong) WSTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArrM;
@property (nonatomic, strong) NSMutableArray<YPGetHistoryInvitationRecord *> *recordMarr;

@end

@implementation YPInviteFriendsWedVIPRecordController{
    UIView *_navView;
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetHistoryInvitationRecord];
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
    self.view.backgroundColor = WhiteColor;
    
    _pageIndex = 1;

    [self setupNav];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[WSTableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.WSTableViewDelegate = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _pageIndex = 1;
//        [self GetHistoryInvitationRecord];
//    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _pageIndex ++;
//        [self GetHistoryInvitationRecord];
//    }];
}

- (void)setupNav{
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    titleLab.text = @"邀请记录";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSourceArrM count];
    
}

- (NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath{
//    WSTableviewDataModel *dataModel = self.dataSourceArrM[indexPath.row];
//    NSLog(@"%zd",[dataModel.secondLevelArrM count]);
//    return [dataModel.secondLevelArrM count]+1;
    
    YPGetHistoryInvitationRecord *record = self.recordMarr[indexPath.row];
    return record.MakeMoneyData.count > 0 ? record.MakeMoneyData.count+1 : 0;
    
}

- (BOOL)tableView:(WSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath{
    WSTableviewDataModel *dataModel = self.dataSourceArrM[indexPath.row];
    return dataModel.shouldExpandSubRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSTableviewDataModel *dataModel = self.dataSourceArrM[indexPath.row];
    YPGetHistoryInvitationRecord *record = self.recordMarr[indexPath.row];
    
    YPInviteFriendsWedVIPRecordCell *cell = [YPInviteFriendsWedVIPRecordCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (dataModel.firstLevelStr.length > 0) {
        cell.titleLabel.text = record.Name;
    }else{
        cell.titleLabel.text = @"无姓名";
    }
    if (record.Phone.length > 0) {
        cell.phoneLabel.text = record.Phone;
    }else{
        cell.phoneLabel.text = @"无手机号";
    }
    if (record.AuditStatus.integerValue == 0) {//0未审核,1已审核,2审核失败
        cell.tagLabel.text = @"审核中";
        cell.tagLabel.textColor = RGBS(153);
    }else if (record.AuditStatus.integerValue == 1){
        cell.tagLabel.text = @"审核通过";
        cell.tagLabel.textColor = RGBA(253, 156, 39, 1);
    }else if (record.AuditStatus.integerValue == 2){
        cell.tagLabel.text = @"审核未通过";
        cell.tagLabel.textColor = RGBS(153);
    }
    cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",record.Money];
    
    if (record.MakeMoneyData.count > 0) {
        cell.arrowImgV.hidden = NO;
    }else{
        cell.arrowImgV.hidden = YES;
    }
    
    cell.expandable = dataModel.expandable;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.subRow == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBA(247, 248, 252, 1);
        UILabel *label = [[UILabel alloc]init];
        label.text = @"奖励金来源";
        label.font = kFont(12);
        label.textColor = RGBA(153, 153, 153, 1);
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(30);
        }];
        return cell;
    }else{
        WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
        YPGetHistoryInvitationRecord *record = self.recordMarr[indexPath.row];
        NSLog(@"%zd",indexPath.subRow);
        YPYPGetHistoryInvitationRecordMakeMoneyData *data = record.MakeMoneyData[indexPath.subRow-1];
        
        YPInviteFriendsWedVIPRecordSubCell *cell = [YPInviteFriendsWedVIPRecordSubCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBA(247, 248, 252, 1);
        cell.titleLabel.text = [dataModel object_get_fromSecondLevelArrMWithIndex:indexPath.subRow-1];
        cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",data.monry];
        return cell;
    }
}

- (CGFloat)tableView:(WSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSTableviewDataModel *dataModel = _dataSourceArrM[indexPath.row];
    dataModel.shouldExpandSubRows = !dataModel.shouldExpandSubRows;

    WSTableViewCell *cell = (WSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(isExpandable)]){
        if (cell.isExpandable){
            [cell accessoryViewAnimation];
        }
    }
}

- (void)tableView:(WSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - target
- (void)backVC{
    UIViewController *mineVC = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        //遍历
        if([controller isKindOfClass:[YPInviteFriendsWedVIPController class]]){
            //这里判断是否为你想要跳转的页面
            mineVC = controller;
            break;
        }
    }
    [self.navigationController popToViewController:mineVC  animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取历史邀请记录(个人版)
- (void)GetHistoryInvitationRecord{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHistoryInvitationRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
//    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"50";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.recordMarr removeAllObjects];
                
                self.recordMarr = [YPGetHistoryInvitationRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

                for (YPGetHistoryInvitationRecord *record in self.recordMarr) {
                    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                    dataModel.firstLevelStr = record.Name;
                    dataModel.shouldExpandSubRows = NO;
                    for (YPYPGetHistoryInvitationRecordMakeMoneyData *data in record.MakeMoneyData) {
                         [dataModel object_add_toSecondLevelArrM:data.Meno];
                    }
                    [self.dataSourceArrM addObject:dataModel];
                }
                
            }else{
                NSArray *newArray = [YPGetHistoryInvitationRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.recordMarr addObjectsFromArray:newArray];
                    
                    WSTableviewDataModel *dataModel = [[WSTableviewDataModel alloc] init];
                    
                    for (YPGetHistoryInvitationRecord *record in newArray) {
                        dataModel.firstLevelStr = record.Name;
                        dataModel.shouldExpandSubRows = NO;
                        for (YPYPGetHistoryInvitationRecordMakeMoneyData *data in record.MakeMoneyData) {
                            [dataModel object_add_toSecondLevelArrM:data.Meno];
                        }
                        [self.dataSourceArrM addObject:dataModel];
                    }
                }
                
            }
            
            [self setupUI];
            [self endRefresh];
            
            if (self.recordMarr.count > 0) {
                [self hidenEmptyView];
            }else{
                [self showNoDataEmptyView];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [self showNetErrorEmptyView];
        
    }];
    
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetHistoryInvitationRecord];
    }];
    
}

-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetHistoryInvitationRecord];
    }];
    
}

-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSMutableArray<YPGetHistoryInvitationRecord *> *)recordMarr{
    if (!_recordMarr) {
        _recordMarr = [NSMutableArray array];
    }
    return _recordMarr;
}

- (NSMutableArray *)dataSourceArrM{
    if (!_dataSourceArrM) {
        _dataSourceArrM = [NSMutableArray array];
    }
    return _dataSourceArrM;
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
