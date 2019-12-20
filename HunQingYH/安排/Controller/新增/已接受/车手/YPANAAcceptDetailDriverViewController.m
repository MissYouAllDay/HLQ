//
//  YPANAAcceptDetailDriverViewController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//
//注意: 缺接口 -- 获取已分配车手应答列表 9.20

#import "YPANAAcceptDetailDriverViewController.h"
#import "ZJScrollPageViewDelegate.h"
#import "YPANAAcceptDetailDriverCell.h"
//#import "YPDriverListController.h" //弃用
#import "YPDistributeCarBrandController.h"//分配车手
#import "YPCaptainGetResponseStatus.h"

@interface YPANAAcceptDetailDriverViewController ()<ZJScrollPageViewChildVcDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPCaptainGetResponseStatus *> *listMarr;

@end

@implementation YPANAAcceptDetailDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupUI];
    
    [self CaptainGetResponseStatus];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, ScreenWidth, ScreenHeight-1-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    UIButton *addDriverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addDriverBtn setTitle:@"添加车手" forState:UIControlStateNormal];
    [addDriverBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [addDriverBtn setBackgroundColor:WhiteColor];
    [addDriverBtn addTarget:self action:@selector(addDriverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addDriverBtn];
    [addDriverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(view);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPCaptainGetResponseStatus *model = self.listMarr[indexPath.row];
    
    YPANAAcceptDetailDriverCell *cell = [YPANAAcceptDetailDriverCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addDriverBtnClick{
    NSLog(@"addDriverBtnClick");

    YPDistributeCarBrandController *distribute = [[YPDistributeCarBrandController alloc]init];
    distribute.weddingTime = self.weddingTime;
    distribute.supplierOrderID = self.supplierOrderID;
    [self.navigationController pushViewController:distribute animated:YES];
    
}

#pragma mark - 网络请求
#pragma mark 队长获取已分配车手应答状态
- (void)CaptainGetResponseStatus{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CaptainGetResponseStatus";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;//车队队长ID
    params[@"SupplierOrderID"] = self.supplierOrderID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPCaptainGetResponseStatus mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
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
- (NSMutableArray<YPCaptainGetResponseStatus *> *)listMarr{
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
        [self CaptainGetResponseStatus];
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
