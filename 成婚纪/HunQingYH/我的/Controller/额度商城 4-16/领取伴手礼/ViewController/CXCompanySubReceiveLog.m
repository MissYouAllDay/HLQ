//
//  CXCompanySubReceiveLog.m
//  HunQingYH
//
//  Created by apple on 2019/10/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXCompanySubReceiveLog.h"
#import "CXCompanyReviceLogCell.h"
@interface CXCompanySubReceiveLog ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorFlowRecord *> *dataArr;
/** <#name#> */
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation CXCompanySubReceiveLog

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"领取记录";
    [self.view addSubview:self.tableView];
    self.pageIndex = 1;
    [self GetFacilitatorFlowRecord];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetFacilitatorFlowRecord];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetFacilitatorFlowRecord];
    }];
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 100;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXCompanyReviceLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXCompanyReviceLogCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXCompanyReviceLogCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CXCompanyReviceLogCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CXCompanyReviceLogCell" owner:nil options:nil] lastObject];
    
    [cell setSectionHeaderValue];
    return cell;
}

#pragma mark 获取服务商活动流水列表
- (void)GetFacilitatorFlowRecord{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorFlowRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"Type"] = @"0";//0所有,1线上,2线下
    
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    
    params[@"ActivityType"] =  @"3";//0伴手礼,1代收,2婚礼返还,3伴手礼和代收
    params[@"UserNamePhone"] =  @"";
    params[@"PayType"] = @"2";//0全部,1待支付,2已支付,3已打款

    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.dataArr removeAllObjects];
                
                self.dataArr = [YPGetFacilitatorFlowRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetFacilitatorFlowRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.dataArr addObjectsFromArray:newArray];
                }
                
            }
            
            if (self.dataArr.count > 0) {
                [self hidenEmptyView];
            }else{
                [self showNoDataEmptyView];
            }
            
            [self.tableView reloadData];
            [self endRefresh];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
- (NSMutableArray<YPGetFacilitatorFlowRecord *> *)dataArr {
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
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
        [self GetFacilitatorFlowRecord];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetFacilitatorFlowRecord];
    }];
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

@end
