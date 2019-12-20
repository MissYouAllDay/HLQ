//
//  YPDistributeCarBrandController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/19.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDistributeCarBrandController.h"
#import "YPDriverBrandCell.h"
#import "YPDistributeDriverController.h"
#import "YPGetModelsListBySupplierID.h"

@interface YPDistributeCarBrandController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetModelsListBySupplierID *> *listMarr;

@end

@implementation YPDistributeCarBrandController{
    UIView *_navView;
    
    //避免重复创建
    UIView      *_top;
    UILabel     *time;
    UILabel     *type;
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
    
    [self GetModelsListBySupplierID];
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
    titleLab.text = @"分配车手";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
//    //设置导航栏右边
//    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:searchBtn];
//    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
//        make.right.mas_equalTo(_navView).mas_offset(-15);
//        make.centerY.mas_equalTo(_navView.mas_centerY).offset(10);
//    }];
    
}

- (void)setupUI{
    
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!_top) {
        _top = [[UIView alloc]init];
    }
    _top.backgroundColor = WhiteColor;
    [self.view addSubview:_top];
    [_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    if (!time) {
        time = [[UILabel alloc]init];
    }
    time.text = self.weddingTime;
    time.textColor = GrayColor;
    [_top addSubview:time];
    
    if (!type) {
        type = [[UILabel alloc]init];
    }
    type.text = @"他们都有空";
    type.textColor = GrayColor;
    [_top addSubview:type];
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(_top);
    }];
    
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(time.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(time);
    }];
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+41, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-41) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return 5;
    return self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetModelsListBySupplierID *model = self.listMarr[indexPath.row];
    
    YPDriverBrandCell *cell = [YPDriverBrandCell cellWithTableView:tableView];
    
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetModelsListBySupplierID *model = self.listMarr[indexPath.row];
    
    YPDistributeDriverController *driver = [[YPDistributeDriverController alloc]init];
    driver.carID = model.CarID;
    driver.weddingTime = self.weddingTime;
    driver.supplierOrderID = self.supplierOrderID;
    [self.navigationController pushViewController:driver animated:YES]; 
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 队长获取车型列表
- (void)GetModelsListBySupplierID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetModelsListBySupplierID";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    if (self.weddingTime.length > 0) {
        params[@"DriverTime"] = self.weddingTime;//日期为空查所有 婚期
    }else{
        params[@"DriverTime"] = @"";//日期为空查所有 婚期
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetModelsListBySupplierID mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];
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
- (NSMutableArray<YPGetModelsListBySupplierID *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

//#pragma mark - 缺省
//-(void)showNoDataEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        <#way#>
//    }];
//
//}
//-(void)showNetErrorEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        <#way#>
//    }];
//
//}
//-(void)hidenEmptyView{
//    [ EasyShowEmptyView hiddenEmptyView:self.view];
//}

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
