//
//  YPInviteFriendsWedNormalRecordController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedNormalRecordController.h"
#import "YPInviteFriendsWedNormalRecordCell.h"
#import "YPGetHistoryInvitationRecord.h"

@interface YPInviteFriendsWedNormalRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetHistoryInvitationRecord *> *recordMarr;

@end

@implementation YPInviteFriendsWedNormalRecordController{
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
    [self setupUI];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetHistoryInvitationRecord];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetHistoryInvitationRecord];
    }];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recordMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPGetHistoryInvitationRecord *recordModel = self.recordMarr[indexPath.row];
    
    YPInviteFriendsWedNormalRecordCell *cell = [YPInviteFriendsWedNormalRecordCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (recordModel.Ranking.integerValue == 1) {
        [cell.numberImgV setImage:[UIImage imageNamed:@"No1"]];
        cell.numberLabel.hidden = YES;
        cell.numberImgV.hidden = NO;
        
        //只有前三有价钱标识 -- 18-10-18 郝
        cell.priceLabel.hidden = NO;
        cell.priceState.hidden = NO;
        cell.priceLabel.text = recordModel.Money;
        if (recordModel.IsMakeMoney.integerValue == 0) {//0未打款,1已打款
            cell.priceState.text = @"¥ 待打款";
        }else if (recordModel.IsMakeMoney.integerValue == 1){
            cell.priceState.text = @"¥ 已打款";
        }
    }else if (recordModel.Ranking.integerValue == 2){
        [cell.numberImgV setImage:[UIImage imageNamed:@"No2"]];
        cell.numberLabel.hidden = YES;
        cell.numberImgV.hidden = NO;
        
        //只有前三有价钱标识 -- 18-10-18 郝
        cell.priceLabel.hidden = NO;
        cell.priceState.hidden = NO;
        cell.priceLabel.text = recordModel.Money;
        if (recordModel.IsMakeMoney.integerValue == 0) {//0未打款,1已打款
            cell.priceState.text = @"¥ 待打款";
        }else if (recordModel.IsMakeMoney.integerValue == 1){
            cell.priceState.text = @"¥ 已打款";
        }
    }else if (recordModel.Ranking.integerValue == 3){
        [cell.numberImgV setImage:[UIImage imageNamed:@"No3"]];
        cell.numberLabel.hidden = YES;
        cell.numberImgV.hidden = NO;
        
        //只有前三有价钱标识 -- 18-10-18 郝
        cell.priceLabel.hidden = NO;
        cell.priceState.hidden = NO;
        cell.priceLabel.text = recordModel.Money;
        if (recordModel.IsMakeMoney.integerValue == 0) {//0未打款,1已打款
            cell.priceState.text = @"¥ 待打款";
        }else if (recordModel.IsMakeMoney.integerValue == 1){
            cell.priceState.text = @"¥ 已打款";
        }
    }else{
        cell.numberLabel.text = [NSString stringWithFormat:@"%zd",recordModel.Ranking.integerValue];
        cell.numberLabel.hidden = NO;
        cell.numberImgV.hidden = YES;
        
        //只有前三有价钱标识 -- 18-10-18 郝
        cell.priceLabel.hidden = YES;
        cell.priceState.hidden = YES;
    }
    if (recordModel.Name.length > 0) {
        cell.titleLabel.text = recordModel.Name;
    }else{
        cell.titleLabel.text = @"无姓名";
    }
    if (recordModel.Phone.length > 0) {
        cell.phoneLabel.text = recordModel.Phone;
    }else{
        cell.phoneLabel.text = @"无手机号";
    }
    if (recordModel.AuditStatus.integerValue == 0) {//0未审核,1已审核,2审核失败
        cell.tagLabel.text = @"审核中";
        cell.tagLabel.textColor = RGBS(153);
    }else if (recordModel.AuditStatus.integerValue == 1){
        cell.tagLabel.text = @"审核通过";
        cell.tagLabel.textColor = RGBA(253, 156, 39, 1);
    }else if (recordModel.AuditStatus.integerValue == 2){
        cell.tagLabel.text = @"审核未通过";
        cell.tagLabel.textColor = RGBS(153);
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取历史邀请记录(个人版)
- (void)GetHistoryInvitationRecord{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHistoryInvitationRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.recordMarr removeAllObjects];
                
                self.recordMarr = [YPGetHistoryInvitationRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                [self.tableView reloadData];
                [self endRefresh];
            }else{
                NSArray *newArray = [YPGetHistoryInvitationRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.recordMarr addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [self.tableView reloadData];
                }
                
            }
            
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
        //        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
