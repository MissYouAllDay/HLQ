//
//  CXInviteHotelStayLogVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInviteHotelStayLogVC.h"
#import "CXInviteHotelStayLogCell.h" // 邀请酒店记录cell

#import "CXInviteHotelListModel.h"  //model
@interface CXInviteHotelStayLogVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;    // tableview
@property (nonatomic, assign) int pageIndex;    // 页码
@property (nonatomic, strong) NSMutableArray  *listMarr;    // 数据
@end

@implementation CXInviteHotelStayLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"记录";
    self.pageIndex = 1;
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"kefu" highImageName:@"kefu" target:self action:@selector(showTelAlert)];
    self.navigationItem.rightBarButtonItems = @[item];
    [self.view addSubview:self.tableView];
    
    [self loadInviteHotelListData];
}

// MARK: - 请求数据

- (void)loadInviteHotelListData {
  
    [EasyShowLodingView showLoding];
    
    NSString *url = URL_ACTIVITY_InviteHotelList;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:UserPhone_New forKey:@"Phone"];
    [params setObject:@(self.pageIndex) forKey:@"PageIndex"];
    [params setObject:@(20) forKey:@"PageCount"];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [EasyShowLodingView hidenLoding];
               });
               
               if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
                   
                   if (_pageIndex == 1) {
                       
                       [self.listMarr removeAllObjects];
                       self.listMarr = [CXInviteHotelListModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                       
                   }else{
                       NSArray *newArray = [CXInviteHotelListModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                       
                       if (newArray.count == 0) {
                           self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                       }else{
                           [self.listMarr addObjectsFromArray:newArray];
                       }
                       
                   }
                   
                   [self.tableView reloadData];
                   [self endRefresh];
                   
               }else{
                   
                   [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
               }
               
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
    }];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"该区域暂无商家入驻\n快来抢占先机" subTitle:@"" imageName:@"HYTH_nodata.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self loadInviteHotelListData];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

- (void)endRefresh {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXInviteHotelStayLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXInviteHotelStayLogCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXInviteHotelStayLogCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.listMarr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// MARK: - Until
//  客服电话
- (void)showTelAlert {
    
    [CXUtils phoneAction:self withTel:kefuTel];
}

// MARK: - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenContentHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 210;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)listMarr {
    
    if (!_listMarr) {
        _listMarr = [[NSMutableArray alloc] init];
    }
    return _listMarr;
}

@end
