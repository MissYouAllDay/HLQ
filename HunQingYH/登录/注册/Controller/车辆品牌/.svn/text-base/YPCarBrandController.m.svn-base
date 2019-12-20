//
//  YPCarBrandController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPCarBrandController.h"
#import "ContactModel.h"
#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool
#import "YPCarTypeController.h"//车系
#import "YPAddCarBrandInfoController.h"//添加车型

@interface YPCarBrandController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
    UIView *navView;
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property(nonatomic,strong)NSIndexPath *lastPath;//上次选中的索引
@property (nonatomic, copy) NSString *selectCarID;
@property (nonatomic, copy) NSString *selectCarName;

@end

@implementation YPCarBrandController{

//    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //获取车型
    [self GetCarModelList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
//    _pageIndex = 1;
    
    [self createNav];
    [self creatUI];

}

- (void)createNav {
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = WhiteColor;
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"车辆品牌";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont systemFontOfSize:20 ];
    [navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(navView.mas_centerX);
    }];

    //设置导航栏右边
    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(navView).mas_offset(-15);
        make.centerY.mas_equalTo(navView.mas_centerY).offset(10);
    }];
    
}

-(void)creatUI{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor darkGrayColor]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _pageIndex = 1;
//        [self GetCarModelList];
//    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _pageIndex ++;
//        [self GetCarModelList];
//    }];
    
    //    self.tableView.tableHeaderView=self.searchBar;
    //cell暂无数据时，不显示间隔线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    //布局View
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"自行添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(view);
        make.top.mas_equalTo(view).mas_offset(1);
    }];
    
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _rowArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_rowArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    }
    [label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section+1]]];
    return label;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _sectionArr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22.0;
}

#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    if (self.lastPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    ContactModel *model=_rowArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.Name;

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSLog(@"--------- re %zd,%zd  ------now %zd,%zd",_lastPath.section,_lastPath.row,indexPath.section,indexPath.row);
    
    //之前选中的，取消选择
    UITableViewCell *celled = [tableView cellForRowAtIndexPath:self.lastPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    //记录当前选中的位置索引
    self.lastPath = indexPath;
    //当前选择的打勾
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContactModel *model=_rowArr[indexPath.section][indexPath.row];
    self.selectCarID = model.CarModelID;
    self.selectCarName = model.Name;
}

#pragma mark ------target-------
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnClick{
    NSLog(@"doneBtnClick");
    
    if ([self.brandDelegate respondsToSelector:@selector(carBrand:andCarModelID:)]) {
        [self.brandDelegate carBrand:self.selectCarName andCarModelID:self.selectCarID];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick{
    NSLog(@"addBtnClick");
    
    YPAddCarBrandInfoController *addInfo = [[YPAddCarBrandInfoController alloc]init];
    [self.navigationController pushViewController:addInfo animated:YES];
}

#pragma mark -------网络请求----------
#pragma mark 获取品牌/型号列表
-(void)GetCarModelList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetCarModelList";
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CarModelID"] = @"1";//1获取品牌；品牌ID获取型号列表
//    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
//            if (_pageIndex == 1) {
                [self.dataArr removeAllObjects];
        
                self.dataArr = [ContactModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                _rowArr= [ContactDataHelper getFriendListDataBy:_dataArr];
                _sectionArr= [ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
                
                [self.tableView reloadData];
//                [self endRefresh];
//            }else{
//                NSArray *newArray = [ContactModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
//                
//                if (newArray.count == 0) {
//                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//                }else{
//                    [self.dataArr addObjectsFromArray:newArray];
//                    
//                    _rowArr= [ContactDataHelper getFriendListDataBy:_dataArr];
//                    _sectionArr= [ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
//                    
//                    [self endRefresh];
//                    [self.tableView reloadData];
//                }
//                
//            }
        
            if (self.dataArr.count > 0) {
                [self hidenEmptyView];
            }else{
                
//                [EasyShowTextView showText:@"当前暂无数据!"];
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
//-(void)endRefresh{
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
      
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetCarModelList];
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
