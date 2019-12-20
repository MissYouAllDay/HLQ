//
//  YPMyKeYuan190311ListController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190311ListController.h"
#import "YPGetFacilitatorIdJSJTableList.h"
#import "YPMyKeYuan190311ListCell.h"
#import "YPMyKeYuan190311DetailController.h"

@interface YPMyKeYuan190311ListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorIdJSJTableList *> *listMarr;

@end

@implementation YPMyKeYuan190311ListController{
    NSInteger _pageIndex;
    UIImageView *_placeHoldImgV;
    UIButton *_applyBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if ([_typeStr isEqualToString:@"审核中"]) {
        [self GetFacilitatorIdJSJTableList_1];
    }else{
        [self GetFacilitatorIdJSJTableListWithSortField:@"1" Sort:@"1"];
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
    
    _pageIndex = 1;
    
    self.view.backgroundColor = RGBS(245);
    
    [self setupUI];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-40) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBS(245);
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        if ([_typeStr isEqualToString:@"审核中"]) {
            [self GetFacilitatorIdJSJTableList_1];
        }else{
            [self GetFacilitatorIdJSJTableListWithSortField:@"1" Sort:@"1"];
        }
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        if ([_typeStr isEqualToString:@"审核中"]) {
            [self GetFacilitatorIdJSJTableList_1];
        }else{
            [self GetFacilitatorIdJSJTableListWithSortField:@"1" Sort:@"1"];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetFacilitatorIdJSJTableList *list = self.listMarr[indexPath.section];
    YPMyKeYuan190311ListCell *cell = [YPMyKeYuan190311ListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (list.Name.length > 0) {
        cell.titleLabel.text = list.Name;
    }else{
        cell.titleLabel.text = @"无姓名";
    }
    if (list.Phone.length > 0) {
        cell.phoneLabel.text = list.Phone;
    }else{
        cell.phoneLabel.text = @"无手机号";
    }
    if (list.WeddingTime.length > 0) {
        cell.date.text = list.WeddingTime;
    }else{
        cell.date.text = @"无时间";
    }
    cell.zhuoshu.text = [NSString stringWithFormat:@"%@桌",list.TablesNumber];
    cell.canbiao.text = [NSString stringWithFormat:@"%@元/桌",list.MealMark];
    if (list.Source.integerValue == 0) {
        cell.guanfang.hidden = NO;
    }else{
        cell.guanfang.hidden = YES;
    }
    if (list.Time.length > 0) {
        if ([self.typeStr isEqualToString:@"审核中"]) {
            cell.timeLabel.text = [NSString stringWithFormat:@"%@ 申请",list.Time];
        }else{
            cell.timeLabel.text = [NSString stringWithFormat:@"%@ 获客",list.Time];
        }
    }else{
        if ([self.typeStr isEqualToString:@"审核中"]) {
            cell.timeLabel.text = [NSString stringWithFormat:@"%@ 申请",@"当前无时间"];
        }else{
            cell.timeLabel.text = [NSString stringWithFormat:@"%@ 获客",@"当前无时间"];
        }
    }
    cell.tagLabel.hidden = YES;
    cell.deleteBtn.tag = indexPath.section + 1000;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.contactBtn.tag = indexPath.section + 2000;
    [cell.contactBtn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 183;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetFacilitatorIdJSJTableList *list = self.listMarr[indexPath.section];

    YPMyKeYuan190311DetailController *detail = [[YPMyKeYuan190311DetailController alloc]init];
    detail.detailID = list.Id;
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - target
- (void)deleteBtnClick:(UIButton *)sender{
    YPGetFacilitatorIdJSJTableList *list = self.listMarr[sender.tag - 1000];
    [self DeleteJSJTableWithID:list.Id];
}

- (void)contactBtnClick:(UIButton *)sender{
    YPGetFacilitatorIdJSJTableList *list = self.listMarr[sender.tag - 2000];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",list.Phone]]];
}

#pragma mark - 网络请求
#pragma mark 供应商获取客源数据
- (void)GetFacilitatorIdJSJTableListWithSortField:(NSString *)SortField Sort:(NSString *)Sort{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorIdJSJTableList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"SortField"] = SortField;
    params[@"Sort"] = Sort;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"100";
    params[@"AreaId"] = areaID_New;
    if ([self.typeStr isEqualToString:@"审核中"]) {//0全部,1待处理,2有意向,3已合作,4已拒单,5官方推荐
        params[@"Type"] = @"0";
    }else if ([self.typeStr isEqualToString:@"待处理"]) {//0全部,1待处理,2有意向,3已合作,4已拒单,5官方推荐
        params[@"Type"] = @"1";
    }else if ([self.typeStr isEqualToString:@"有意向"]) {//0全部,1待处理,2有意向,3已合作,4已拒单,5官方推荐
        params[@"Type"] = @"2";
    }else if ([self.typeStr isEqualToString:@"已合作"]) {//0全部,1待处理,2有意向,3已合作,4已拒单,5官方推荐
        params[@"Type"] = @"3";
    }else if ([self.typeStr isEqualToString:@"拒单/失效"]) {//0全部,1待处理,2有意向,3已合作,4已拒单,5官方推荐
        params[@"Type"] = @"4";
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self endRefresh];
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetFacilitatorIdJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetFacilitatorIdJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            [self.tableView reloadData];

            if (self.listMarr.count == 0) {
                [self showNoDataEmptyView];
            }else{
                [self hidenEmptyView];
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 供应商获取客源数据
- (void)GetFacilitatorIdJSJTableList_1{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorIdJSJTableList_1";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"SortField"] = @"1";
    params[@"Sort"] = @"1";
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"100";
    params[@"AreaId"] = areaID_New;
    params[@"Type"] = @"0";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self endRefresh];
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetFacilitatorIdJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetFacilitatorIdJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            [self.tableView reloadData];
            
            if (self.listMarr.count == 0) {
                [self showNoDataEmptyView];
            }else{
                [self hidenEmptyView];
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 删除客源数据
- (void)DeleteJSJTableWithID:(NSString *)detailID{
    
    NSString *url = @"/api/HQOAApi/DeleteJSJTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = detailID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"删除成功!" inView:self.tableView];
            
            if ([_typeStr isEqualToString:@"审核中"]) {
                [self GetFacilitatorIdJSJTableList_1];
            }else{
                [self GetFacilitatorIdJSJTableListWithSortField:@"1" Sort:@"1"];
            }
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
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
        if ([_typeStr isEqualToString:@"审核中"]) {
            [self GetFacilitatorIdJSJTableList_1];
        }else{
            [self GetFacilitatorIdJSJTableListWithSortField:@"1" Sort:@"1"];
        }
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        if ([_typeStr isEqualToString:@"审核中"]) {
            [self GetFacilitatorIdJSJTableList_1];
        }else{
            [self GetFacilitatorIdJSJTableListWithSortField:@"1" Sort:@"1"];
        }
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorIdJSJTableList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
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
