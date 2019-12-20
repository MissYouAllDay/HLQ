//
//  YPNotBalanceController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNotBalanceController.h"
#import "YPNotBalanceCell.h"
#import "YPGetSupplierrOrderList.h"

@interface YPNotBalanceController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetSupplierrOrderList *> *listMarr;

@end

@implementation YPNotBalanceController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    [self GetSupplierrOrderList];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //iOS.11 修改
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetSupplierrOrderList *list = self.listMarr[indexPath.section];
    
    YPNotBalanceCell *cell = [YPNotBalanceCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderList = list;
    cell.jieSuanBtn.layer.borderColor = [UIColor redColor].CGColor;
    cell.jieSuanBtn.tag = indexPath.section + 1000;
    cell.phoneBtn.tag = indexPath.section + 2000;
    [cell.jieSuanBtn addTarget:self action:@selector(jieSuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
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
- (void)jieSuanBtnClick:(UIButton *)sender{
    NSLog(@"%zd",sender.tag);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认结算?" message:@"您确定此次合作已经结算完毕了吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = sender.tag;
    [alert show];
}

- (void)phoneBtnClick:(UIButton *)sender{
    
    YPGetSupplierrOrderList *list = self.listMarr[sender.tag - 2000];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",list.CorpPhone]]];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    YPGetSupplierrOrderList *list = self.listMarr[alertView.tag - 1000];
    
    if (buttonIndex == 1) {
        NSLog(@"确认");
        
        [self ScheduleSettlement:list.SupplierOrderID];
    }
}

#pragma mark - 网络请求
#pragma mark 获取供应商订单列表
- (void)GetSupplierrOrderList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSupplierrOrderList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"AnswerType"] = @"2";//0、获取所有、1未应答2、已同意 3、已拒绝
    params[@"SettlementType"] = @"2";//0、获取所有 1、已结算 2、未结算
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetSupplierrOrderList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
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

#pragma mark 档期结算(供应商用)
- (void)ScheduleSettlement:(NSString *)orderID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/ScheduleSettlement";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"SupplierOrderID"] = orderID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"结算成功!"];
            
            [self GetSupplierrOrderList];
            
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
- (NSMutableArray<YPGetSupplierrOrderList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
  
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetSupplierrOrderList];
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
