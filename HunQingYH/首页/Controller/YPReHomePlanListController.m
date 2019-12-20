//
//  YPReHomePlanListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/8.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomePlanListController.h"
#import "YPReFangAnCell.h"
//#import "YPFADetailController.h"
#import "YPReHomePlanDetailController.h"//1-10 方案详情
#import "YPGetWebPlanList.h"

@interface YPReHomePlanListController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,LLNoDataViewTouchDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 方案模型
 */
@property (nonatomic, strong) NSMutableArray<YPGetWebPlanList *> *planList;

@end

@implementation YPReHomePlanListController{
    UIView *_navView;
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetWebPlanList];
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
    
    _pageIndex = 1;
    
    [self setupNav];
    [self setupUI];
    
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
    titleLab.text = @"方案展示";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetWebPlanList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetWebPlanList];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.planList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPGetWebPlanList *plan = self.planList[indexPath.section];
    
    YPReFangAnCell *cell = [YPReFangAnCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.webPlanList = plan;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetWebPlanList *plan = self.planList[indexPath.section];
    YPReHomePlanDetailController *detail = [[YPReHomePlanDetailController alloc]init];
    detail.planID = plan.PlanId;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 285;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取人婚礼策划方案
- (void)GetWebPlanList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/GetWebPlanList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.planList removeAllObjects];
                
                self.planList = [YPGetWebPlanList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                [self.tableView reloadData];
                [self endRefresh];
            }else{
                NSArray *newArray = [YPGetWebPlanList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.planList addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [self.tableView reloadData];
                }
                
            }
            
            if (self.planList.count > 0) {
                [self hidenEmptyView];
            }else{
                
//                [EasyShowTextView showText:@"当前暂无数据!"];
                
                [self showNoDataEmptyView];
                
//                LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:self.tableView.bounds LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
//                dataView.delegate = self;
//                self.tableView.tableHeaderView = dataView;
//
//                //实例一次，再次修改提示文本信息
//                dataView.tipLabel.text = @"当前没有加载到数据";
                
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

#pragma mark - getter
- (NSMutableArray<YPGetWebPlanList *> *)planList{
    if (!_planList) {
        _planList = [NSMutableArray array];
    }
    return _planList;
}

#pragma mark - LLNoDataViewTouchDelegate
- (void)didTouchLLNoDataView{
    
    [self GetWebPlanList];
    
    self.tableView.tableHeaderView = nil;
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
 
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetWebPlanList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
