//
//  YPDistributeDriverSearchController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDistributeDriverSearchController.h"
#import "HRSearchBar.h"
#import "YPDriverSelectCell.h"
#import "YPYanHuiTingListCell.h"
#import "YPGetDriverListBySupplierID.h"

@interface YPDistributeDriverSearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *searchStr;

@property (nonatomic, strong) NSMutableArray<YPGetDriverListBySupplierID *> *listMarr;

@end

@implementation YPDistributeDriverSearchController{
    UIView *_navView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupMainUI];
}
- (void)setupNav{
    
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //加上 搜索栏
    HRSearchBar *searchBar = [[HRSearchBar alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 35)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    //输入框提示
    searchBar.placeholder = @"收藏标题";
    //光标颜色
    searchBar.cursorColor = NavBarColor;
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 5;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
    searchBar.searchBarTextField.layer.borderColor = RGB(234, 235, 237).CGColor;
    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    [searchBar.searchBarTextField becomeFirstResponder];
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    [_navView addSubview:searchBar];
    
    
}
-(void)setupMainUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    
}
#pragma mark ----tableViewDataScouce ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listMarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetDriverListBySupplierID *model = self.listMarr[indexPath.row];
    
    YPDriverSelectCell *cell = [YPDriverSelectCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = model.DriverName;
    cell.phone.text = model.DriverPhone;
    
//    if ([model.IsSelected integerValue] == 1) {//1.选中 2.未选中
//        cell.selectBtn.selected = YES;
//    }else {//1.选中 2.未选中
//        cell.selectBtn.selected = NO;
//    }
    
    cell.selectBtn.tag = indexPath.row + 1000;
    cell.phoneBtn.tag = indexPath.row + 2000;
//    [cell.selectBtn addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UISearchBar Delegate
//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    HRSearchBar *sear = (HRSearchBar *)searchBar;
    //取消按钮
    sear.cancleButton.backgroundColor = [UIColor clearColor];
    [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [sear.cancleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
    
    self.searchStr = searchText;
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self GetDriverListBySupplierIDWithSearch:searchBar.text];
    
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 队长根据车型获取车手列表
- (void)GetDriverListBySupplierIDWithSearch:(NSString *)searchStr{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetDriverListBySupplierID";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"CarID"] = self.carID;
    if (self.weddingTime.length > 0) {
        params[@"DriverTime"] = self.weddingTime;//日期为空查所有 婚期
    }else{
        params[@"DriverTime"] = @"";//日期为空查所有 婚期
    }
    
    params[@"PhoneOrName"] = searchStr;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetDriverListBySupplierID mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                
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

#pragma mark - getter
- (NSMutableArray<YPGetDriverListBySupplierID *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
     
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetDriverListBySupplierIDWithSearch:@""];
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
