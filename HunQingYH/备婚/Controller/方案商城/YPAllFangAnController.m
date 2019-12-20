//
//  YPAllFangAnController.m
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPAllFangAnController.h"
#import "YPReFangAnCell.h"
//#import "ZJScrollPageViewDelegate.h"
#import "YPReHomePlanDetailController.h"
#import "YPGetDemoPlanList.h"
#import "FL_Button.h"


@interface YPAllFangAnController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<YPGetDemoPlanList *> *listMarr;

@end

@implementation YPAllFangAnController{
    NSInteger _pageIndex;
    UIView *_navView;
    UIView *_view;


}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    //5-24 改正序
    [self GetPlanListWithOrderByType:@"0" AndOrderStart:@"1"];//获取方案列表
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    _pageIndex = 1;

    [self setupBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        //5-24 改正序
        [self GetPlanListWithOrderByType:@"0" AndOrderStart:@"1"];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        //5-24 改正序
        [self GetPlanListWithOrderByType:@"0" AndOrderStart:@"1"];
    }];
}

- (void)setupBtn{
    
    if (!_view) {
        _view = [[UIView alloc]init];
    }
    _view.backgroundColor = WhiteColor;
    [self.view addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
  
}

#pragma mark - target


#pragma mark - Table view data source

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
- (void)GetPlanListWithOrderByType:(NSString *)type AndOrderStart:(NSString *)start{
    
       [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetNewPeoplePlanList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

  
    params[@"PlanTitle"]        = @"";//标题
    params[@"PlanKeyWord"]      = @"";//关键字
    if ([self.colorStr isEqualToString:@"全部"]) {
        params[@"Color"]            = @"";//全部传空
    }else{
        params[@"Color"]            = self.colorStr;//色系
    }
 


    params[@"PageIndex"]        = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"]        = @"10";
    
    //10-26 添加-筛选 5-24 改正序
  
    params[@"OrderStart"]       = start;//0倒序、1正序
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetDemoPlanList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                [self endRefresh];
                [self.tableView reloadData];
            }else{
                NSArray *newArray = [YPGetDemoPlanList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [self.tableView reloadData];
                }
                
            }
            
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

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - getter
- (NSMutableArray<YPGetDemoPlanList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
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
