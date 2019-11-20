//
//  YPMyCollectionSearchController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/8.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCollectionSearchController.h"
#import "HRSearchBar.h"
#import "YPMyCollectionCell.h"
#import "YPYanHuiTingListCell.h"
#import "YPCollectionList.h"

@interface YPMyCollectionSearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *searchStr;

@property (nonatomic, strong) NSMutableArray<YPCollectionList *> *listMarr;

@end

@implementation YPMyCollectionSearchController{
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
    
    YPCollectionList *list = self.listMarr[indexPath.row];
    
//    if ([list.CollectionType integerValue] == 0) {//0供应商、1方案、2宴会
        
        YPMyCollectionCell *cell = [YPMyCollectionCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (list.CollectionTitle.length > 0) {
            cell.titleLabel.text = list.CollectionTitle;
        }else{
            cell.titleLabel.text = @"无";
        }
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.CollectionLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        return cell;
//    }else if ([list.CollectionType integerValue] == 2) {
//        YPYanHuiTingListCell *cell = [YPYanHuiTingListCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.listModel = list;
//        return cell;
//    }else{
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]init];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.text = @"当前没有符合条件的收藏";
//        return cell;
//        
//    }
    
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
    
    [self CollectionList];
    
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark - 获取收藏列表
- (void)CollectionList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CollectionList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CollectorsType"] = @"0";//0用户、1公司
    params[@"CollectorsID"] = UserId_New;
    params[@"CollectionType"] = @"0";//0供应商、1方案、2宴会、3全部
    params[@"CollectionTitle"] = self.searchStr;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPCollectionList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
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
- (NSMutableArray<YPCollectionList *> *)listMarr{
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
        [self CollectionList];
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
