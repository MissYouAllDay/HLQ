//
//  CXGiftViewController.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXGiftViewController.h"
#import "CXGiftTableViewCell.h"

#import "CXActivityCouponModel.h" // model
#import "CXGiftGoodDetailVC.h"  // 优惠券详情

@interface CXGiftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int  page;    // 页码
@property (nonatomic, strong) NSMutableArray  *listArr;    // dataArr

@end

@implementation CXGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = Line375(170);
        _tableView.estimatedRowHeight = UITableViewRowAnimationAutomatic;
        _tableView.tableFooterView = [UIView new];
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self getADAlertRequest:self.categoryId];
        }];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXGiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXGiftTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXGiftTableViewCell" owner:nil options:nil] lastObject];
    }
    CXActivityCouponModel *model = self.listArr[indexPath.row];
    [cell.mainImg sd_setImageWithURL:[NSURL URLWithString:model.CoverMap] placeholderImage:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CXActivityCouponModel *model = self.listArr[indexPath.row];
    CXGiftGoodDetailVC *vc = [[CXGiftGoodDetailVC alloc] init];
    vc.giftId = model.Id;
    [self.mainNav pushViewController:vc animated:YES];   
}

// MARK: - JXCategoryListContentViewDelegate
- (UIView *)listView {
    
    return self.view;
}


// MARK: - SET & GET
- (void)setCategoryId:(NSString *)categoryId {
    
    _categoryId = categoryId;
    [self getADAlertRequest:categoryId];
}


// MARK: - HTTP
-(void)getADAlertRequest:(NSString *)categoryId {
    NSString *url = URL_ACTIVITY_CouponList;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:categoryId forKey:@"CategoryId"];
    [params setValue:@"20" forKey:@"PageCount"];
    [params setValue:@(self.page) forKey:@"PageIndex"];

    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        NSLog(@"%@",object);
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSArray *arr = [CXActivityCouponModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.listArr addObjectsFromArray:arr];
            if (self.listArr.count == 0) {
                
                [EasyShowEmptyView showEmptyViewLodingWithTitle:@"平台还没有准备好该活动哦\n请耐心等待～～～" callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {}];
            }
            if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] != self.page) {
                self.page ++;
                
            }else {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        [self.tableView reloadData];
        [self endRef];
    } Failure:^(NSError *error) {
      
        if (self.page == 1) {
            
            [EasyShowEmptyView showEmptyViewWithTitle:@"网络错开小差了" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
                [self getADAlertRequest:self.categoryId];
            }];
        }
      
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        [self endRef];
    }];
}

- (void)endRef {
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

// MARK: - Lazy
-(NSMutableArray *)listArr {
    
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc] init];
    }
    return _listArr;
}

@end
