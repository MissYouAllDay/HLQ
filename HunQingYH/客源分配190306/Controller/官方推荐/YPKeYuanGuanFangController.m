//
//  YPKeYuanGuanFangController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuanGuanFangController.h"
//#import "YPKYGFBannerCell.h"
//#import "YPKeYuan190306AllListCell.h"
#import "YPPassengerDistributionBannerCell.h"
#import "YPGetFacilitatorIdJSJTableList.h"
#import "YPKeYuan190320ReAllListCell.h"

@interface YPKeYuanGuanFangController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorIdJSJTableList *> *listMarr;

@end

@implementation YPKeYuanGuanFangController{
    NSInteger _pageIndex;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    _pageIndex = 1;
    
    [self setupUI];
    [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
    }];
}

- (void)setupNoDataView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guanfang_占位"]];
    [view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
        make.size.mas_equalTo(CGSizeMake(240, 240));
    }];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-48-HOME_INDICATOR_HEIGHT);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
    }];
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listMarr.count > 0 ? self.listMarr.count + 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YPPassengerDistributionBannerCell *cell = [YPPassengerDistributionBannerCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.urlArr = self.imgArr;
        [cell.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(ScreenWidth*0.4);
        }];
        return cell;
    }else{
        if (self.listMarr.count > 0) {
            YPGetFacilitatorIdJSJTableList *listModel = self.listMarr[indexPath.section - 1];
            
            YPKeYuan190320ReAllListCell *cell = [YPKeYuan190320ReAllListCell cellWithTableView:tableView];
            if (listModel.Source.integerValue == 0) {//0官方,1个人
                cell.tagImgV.hidden = NO;
            }else{
                cell.tagImgV.hidden = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (listModel.Name.length > 0) {
                cell.titleLabel.text = listModel.Name;
            }else{
                cell.titleLabel.text = @"无姓名";
            }
            if (listModel.Phone.length > 0) {
                cell.phoneLabel.text = listModel.Phone;
            }else{
                cell.phoneLabel.text = @"无手机号";
            }
            if (listModel.Identity.length > 0) {
                cell.supplierLabel.text = listModel.Identity;
            }else{
                cell.supplierLabel.text = @"无需求商家";
            }
            if (listModel.WeddingTime.length > 0) {
                cell.hunqi.text = listModel.WeddingTime;
            }else{
                cell.hunqi.text = @"无婚期";
            }
            cell.zhuoshu.text = [NSString stringWithFormat:@"%@桌",listModel.TablesNumber];
            cell.canbiao.text = [NSString stringWithFormat:@"%@元/桌",listModel.MealMark];
            [cell.applyBtn setTitle:@"立即接收" forState:UIControlStateNormal];
            cell.applyBtn.tag = indexPath.section-1 + 1000;
            [cell.applyBtn addTarget:self action:@selector(lookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID1"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"当前无数据";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(cell.contentView);
            }];
            return cell;
        }
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.tableView) {
//        if (indexPath.section == 0) {
//            return ScreenWidth*0.33;
//        }else{
//            if (self.listMarr.count > 0) {
//                return 138;
//            }else{
//                return 44;
//            }
//        }
//    }else{
//        return 44;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)lookBtnClick:(UIButton *)sender{
    YPGetFacilitatorIdJSJTableList *list = self.listMarr[sender.tag-1000];
    [self UpdateJSJReceiptTypeWithID:list.Id];
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
    params[@"Type"] = @"5";//0全部,1待处理,2有意向,3已合作,4已拒单,5官方推荐
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *str = [object valueForKey:@"Img"];
            self.imgArr = [str componentsSeparatedByString:@","];
            
            [self.listMarr removeAllObjects];
            self.listMarr = [YPGetFacilitatorIdJSJTableList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            if (self.listMarr.count == 0) {
                [self setupNoDataView];
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 服务商接收客源
- (void)UpdateJSJReceiptTypeWithID:(NSString *)recordID{
    
    NSString *url = @"/api/HQOAApi/UpdateJSJReceiptType";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = recordID;
    params[@"Type"] = @"0";//0接单,1拒单
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"接收成功, 可前往我的客源查看详情!" inView:self.tableView];
            
            [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
            
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
        [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetFacilitatorIdJSJTableListWithSortField:@"0" Sort:@"0"];
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

// MARK: - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
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
