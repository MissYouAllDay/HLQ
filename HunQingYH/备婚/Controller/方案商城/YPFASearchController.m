//
//  YPFASearchController.m
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPFASearchController.h"
#import "YPReFangAnCell.h"
#import "YPGetPlanList.h"
#import "YPReHomePlanDetailController.h"

@interface YPFASearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *navView;
}
@property (nonatomic, strong) UISearchBar *bar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *searchStr;

@property (nonatomic, strong) NSMutableArray<YPGetDemoPlanList *> *listMarr;

@end

@implementation YPFASearchController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setStatusBarBackgroundColor:MainColor];
   
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
//设置状态栏颜色
//- (void)setStatusBarBackgroundColor:(UIColor *)color {
//
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    self.view.backgroundColor = WhiteColor;
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor =WhiteColor;
    [self.view addSubview:navView];
    // 创建searchBar
    self.bar = [[UISearchBar alloc]init];
    self.bar.backgroundColor = WhiteColor;
    self.bar.barTintColor  =WhiteColor;
    [self.bar setBackgroundImage:[UIImage new]];
    [ self.bar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar_bg_icon"] forState:UIControlStateNormal];
    self.bar.placeholder = @"搜索方案标题";
    self.bar.showsCancelButton = NO;
    // searchBar  代理,记得签协议
    self.bar.delegate = self;
    [navView addSubview:self.bar];
    [self.bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(navView.mas_bottom);
        make.left.mas_equalTo(navView);
        make.right.mas_equalTo(navView);
        make.height.mas_equalTo(40);
    }];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPGetDemoPlanList *plan = self.listMarr[indexPath.section];
    
    YPReFangAnCell *cell = [YPReFangAnCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.planList = plan;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetDemoPlanList *plan = self.listMarr[indexPath.section];
    
    YPReHomePlanDetailController *detail = [[YPReHomePlanDetailController alloc]init];
    detail.planID = plan.PlanID;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.bar resignFirstResponder];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 314;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - 网络请求
#pragma mark 查看方案列表
- (void)GetPlanListWithOrderByText:(NSString *)text {
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetNewPeoplePlanList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; 
    
    params[@"PlanTitle"]        = text;//标题
    params[@"PlanKeyWord"]      = @"";//关键字
    params[@"Color"]            = @"";//全部传空
    params[@"PageIndex"]        = @"1";
    params[@"PageCount"]        = @"1000000";
    
    //5-24 改正序
    params[@"OrderStart"]       = @"1";//0倒序、1正序
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
        
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetDemoPlanList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                [self.tableView reloadData];
            
                
            
            
            if (self.listMarr.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];
                
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}
#pragma mark - getter
- (NSMutableArray<YPGetDemoPlanList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%@",searchBar.text);
    
    self.searchStr = searchBar.text;
    
    [self GetPlanListWithOrderByText:self.searchStr];
   
}
#pragma mark --- 搜索框开始编辑 ---
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        //        self.navigationController.navigationBarHidden = YES;
        //        _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 44);
        _bar.showsCancelButton = YES;
        
        for (id obj in [searchBar subviews]) {
            if ([obj isKindOfClass:[UIView class]]) {
                for (id obj2 in [obj subviews]) {
                    if ([obj2 isKindOfClass:[UIButton class]]) {
                        UIButton *btn = (UIButton *)obj2;
                        [btn setTitle:@"取消" forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
        
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
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
