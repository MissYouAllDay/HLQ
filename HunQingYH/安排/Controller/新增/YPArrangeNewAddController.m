//
//  YPArrangeNewAddController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeNewAddController.h"
#import "ZJScrollPageViewDelegate.h"
#import "YPArrangeNewAddListCell.h"
#import "YPArrangeNewAddDetailController.h"//未处理 详情
#import "YPANAAcceptDetailController.h"//已接受 详情 婚车
#import "YPOtherArrangeNewAddAcceptDetailController.h"//已接受 详情 其他供应商
#import "YPGetSupplierrOrderList.h"//供应商模型
#import "YPDistributeCarBrandController.h"//分配车手
#import "YPArrangeLiuChengController.h"//查看流程
#import "YPGetDriverTimetableListByDriverID.h"//车手-安排-新增-模型

@interface YPArrangeNewAddController ()<ZJScrollPageViewChildVcDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetSupplierrOrderList *> *listMarr;

@property (nonatomic, strong) NSMutableArray<YPGetDriverTimetableListByDriverID *> *driverMarr;

@end

@implementation YPArrangeNewAddController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    [self rereshData];
}
-(void)rereshData{
    
    if (CheShou(Profession_New)) {
        //车手调用不同的接口
        [self GetDriverTimetableListByDriverID];
        
    }else{
        //获取供应商订单列表
        [self GetSupplierrOrderList];
    }
}
- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //iOS.11 修改
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (CheShou(Profession_New)) {
        return self.driverMarr.count;
    }else{
        return self.listMarr.count;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YPArrangeNewAddListCell *cell = [YPArrangeNewAddListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.refuse.tag   = indexPath.section + 1000;
    cell.accept.tag   = indexPath.section + 2000;
    cell.phoneBtn.tag = indexPath.section + 3000;
    
    [cell.refuse addTarget:self action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.accept addTarget:self action:@selector(acceptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HunChe(Profession_New)) {//婚车 -- 已接受:分配车手 -- 详情可点击

        YPGetSupplierrOrderList *order = self.listMarr[indexPath.section];//婚车和其他使用
        
        cell.order = order;//婚车和其他使用

        if ([order.AnswerStatus integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
            cell.accept.hidden =NO;
            cell.refuse.hidden =NO;
            [cell.accept setTitle:@"接受" forState:UIControlStateNormal];
            [cell.refuse setTitle:@"拒绝" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(40);
            }];
            
        }else if ([order.AnswerStatus integerValue] == 1) {//0 未应答 1、已同意 2、已拒绝

            cell.refuse.hidden = YES;
            [cell.accept setTitle:@"分配车手" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
            }];
        }else if ([order.AnswerStatus integerValue] == 2) {
            cell.refuse.hidden = YES;
            cell.accept.enabled = NO;
            [cell.accept setTitle:@"已拒绝" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
            }];
            cell.accept.enabled = NO;
        }
       
    }else if (CheShou(Profession_New)){//车手 -- 已接受:查看档期 -- 获取不同的数据
        
        //车手使用数据
        YPGetDriverTimetableListByDriverID *driverModel = self.driverMarr[indexPath.section];
        
        cell.driverModel = driverModel;

        if ([driverModel.StatuType integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
            cell.accept.hidden =NO;
            cell.refuse.hidden =NO;
            [cell.accept setTitle:@"接受" forState:UIControlStateNormal];
            [cell.refuse setTitle:@"拒绝" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(40);
            }];
            
        }else if ([driverModel.StatuType integerValue] == 1) {//0 未应答 1、已同意 2、已拒绝
            
            cell.refuse.hidden = YES;
            [cell.accept setTitle:@"查看档期" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
            }];
        }else if ([driverModel.StatuType integerValue] == 2) {
            cell.refuse.hidden = YES;
            cell.accept.enabled = NO;
            [cell.accept setTitle:@"已拒绝" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
            }];
            cell.accept.enabled = NO;
        }
        
    }else {//其他 -- 已接受:查看档期
        
        YPGetSupplierrOrderList *order = self.listMarr[indexPath.section];//婚车和其他使用
        
        cell.order = order;//婚车和其他使用
        
        if ([order.AnswerStatus integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
            cell.accept.hidden =NO;
            cell.refuse.hidden =NO;
            [cell.accept setTitle:@"接受" forState:UIControlStateNormal];
            [cell.refuse setTitle:@"拒绝" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(40);
            }];

        }else if ([order.AnswerStatus integerValue] == 1) {//0 未应答 1、已同意 2、已拒绝

            cell.refuse.hidden = YES;
            [cell.accept setTitle:@"查看档期" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
            }];
        }else if ([order.AnswerStatus integerValue] == 2) {
            cell.refuse.hidden = YES;
            cell.accept.enabled = NO;
            [cell.accept setTitle:@"已拒绝" forState:UIControlStateNormal];
            [cell.accept mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
            }];
            cell.accept.enabled = NO;
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (HunChe(Profession_New)) {//婚车 -- 已接受:分配车手 -- 详情可点击
        YPGetSupplierrOrderList *order = self.listMarr[indexPath.section];
    
        if ([order.AnswerStatus integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
    
            YPArrangeNewAddDetailController *detail = [[YPArrangeNewAddDetailController alloc]init];
            detail.supplierOrderID = order.SupplierOrderID;
//            detail.corpID = order.CorpID;
            detail.corpName = order.CorpName;
            detail.corpLogo = order.CorpLogo;
//            detail.customerID = order.CustomerID;
            detail.corpPhone = order.CorpPhone;
            
            detail.doneBlock = ^(NSString *str) {
                [self GetSupplierrOrderList];//接受/拒绝 - 刷新数据
            };
            
            [self.navigationController yp_pushViewController:detail animated:YES];
    
        }else if ([order.AnswerStatus integerValue] == 1) {//已接受 - 内容/车手 - 添加/修改备注
    
            YPANAAcceptDetailController *detail = [[YPANAAcceptDetailController alloc]init];
            detail.supplierOrderID = order.SupplierOrderID;
            detail.corpID = order.CorpID;
            detail.corpName = order.CorpName;
            detail.corpLogo = order.CorpLogo;
            detail.customerID = order.CustomerID;
            detail.corpPhone = order.CorpPhone;
            
            detail.weddingTime = order.WeddingDate;
            
            [self.navigationController yp_pushViewController:detail animated:YES];
        
        }else if ([order.AnswerStatus integerValue] == 2){//已拒绝  --- 不能查看详情
//            YPArrangeNewAddDetailController *detail = [[YPArrangeNewAddDetailController alloc]init];
//            detail.supplierOrderID = order.SupplierOrderID;
////            detail.corpID = order.CorpID;
//            detail.corpName = order.CorpName;
//            detail.corpLogo = order.CorpLogo;
////            detail.customerID = order.CustomerID;
//            detail.corpPhone = order.CorpPhone;
//            [self.navigationController yp_pushViewController:detail animated:YES];
            
        }

        
    }else if (CheShou(Profession_New)){//车手 已接受:查看流程 -- 不可点击详情
        
        
        
        
        
    }else {//其他 已接受:查看流程 -- 详情可点击
        
        YPGetSupplierrOrderList *order = self.listMarr[indexPath.section];
        
        if ([order.AnswerStatus integerValue] == 0) {//0 未应答 1、已同意 2、已拒绝
            
            YPArrangeNewAddDetailController *detail = [[YPArrangeNewAddDetailController alloc]init];
            detail.supplierOrderID = order.SupplierOrderID;
//            detail.corpID = order.CorpID;
            detail.corpName = order.CorpName;
            detail.corpLogo = order.CorpLogo;
//            detail.customerID = order.CustomerID;
            detail.corpPhone = order.CorpPhone;
            [self.navigationController yp_pushViewController:detail animated:YES];
            
        }else if ([order.AnswerStatus integerValue] == 1) {//已接受 - 内容 - 添加/修改备注
            
            YPOtherArrangeNewAddAcceptDetailController *other = [[YPOtherArrangeNewAddAcceptDetailController alloc]init];
            other.supplierOrderID = order.SupplierOrderID;
//            other.corpID = order.CorpID;
            other.corpName = order.CorpName;
            other.corpLogo = order.CorpLogo;
//            other.customerID = order.CustomerID;
            other.corpPhone = order.CorpPhone;
            
            other.weddingTime = order.WeddingDate;
            
            [self.navigationController yp_pushViewController:other animated:YES];
            
        }else if ([order.AnswerStatus integerValue] == 2){//已拒绝  --- 不能查看详情
            
//            YPArrangeNewAddDetailController *detail = [[YPArrangeNewAddDetailController alloc]init];
//            detail.supplierOrderID = order.SupplierOrderID;
////            detail.corpID = order.CorpID;
//            detail.corpName = order.CorpName;
//            detail.corpLogo = order.CorpLogo;
////            detail.customerID = order.CustomerID;
//            detail.corpPhone = order.CorpPhone;
//            [self.navigationController yp_pushViewController:detail animated:YES];

        }
        
    }
    
}

#pragma mark - target
- (void)refuseBtnClick:(UIButton *)sender{
    
    NSLog(@"拒绝 -- %zd",sender.tag);
    
    if (CheShou(Profession_New)) {
        
        YPGetDriverTimetableListByDriverID *driverModel = self.driverMarr[sender.tag - 1000];
        
        //MMSheetView
        NSArray *items =
        @[MMItemMake(@"确定", MMItemTypeNormal, ^(NSInteger index) {
            NSLog(@"确定 -- %zd",index);
            
            //车手 -- 接受
            [self UpScheduleAuditDriverWithScheduleID:driverModel.ScheduleID AndType:@"2"];////1、同意 2、拒绝
        }),];
        
        [[[MMSheetView alloc] initWithTitle:@"确定拒绝此次安排?"
                                      items:items] showWithBlock:nil];
        
    }else{
        YPGetSupplierrOrderList *list = self.listMarr[sender.tag - 1000];
        
        //MMSheetView
        NSArray *items =
        @[MMItemMake(@"确定", MMItemTypeNormal, ^(NSInteger index) {
            NSLog(@"确定 -- %zd",index);
            
            [self SupplierOrderReviewWithOrderID:list.SupplierOrderID AndType:@"2"];
        }),];
        
        [[[MMSheetView alloc] initWithTitle:@"确定拒绝此次安排?"
                                      items:items] showWithBlock:nil];
    }
}

- (void)acceptBtnClick:(UIButton *)sender{
    NSLog(@"接受 -- %zd",sender.tag);
    
    if (HunChe(Profession_New)) {//婚车 -- 已接受:分配车手
        YPGetSupplierrOrderList *list = self.listMarr[sender.tag - 2000];
    
        if ([list.AnswerStatus integerValue] == 1) {//0 未应答 1、已同意 2、已拒绝
            //分配车手
            YPDistributeCarBrandController *distribute = [[YPDistributeCarBrandController alloc]init];
            distribute.weddingTime = list.WeddingDate;
            distribute.supplierOrderID = list.SupplierOrderID;
            [self.navigationController yp_pushViewController:distribute animated:YES];
    
        }else if ([list.AnswerStatus integerValue] == 0){
            //接受
            [self SupplierOrderReviewWithOrderID:list.SupplierOrderID AndType:@"1"];
        }
        
    }else if (CheShou(Profession_New)){//车手 -- 已接受:查看流程 -- 不同的数据
        
        YPGetDriverTimetableListByDriverID *driverModel = self.driverMarr[sender.tag - 2000];
        
        if ([driverModel.StatuType integerValue] == 1) {//0未审核,1已同意,2已拒绝
            //查看流程
            YPArrangeLiuChengController *liucheng = [[YPArrangeLiuChengController alloc]init];
            liucheng.supplierOrderID = driverModel.OrderID;
            [self.navigationController yp_pushViewController:liucheng animated:YES];
    
        }else if ([driverModel.StatuType integerValue] == 0){
            //车手 -- 接受
            [self UpScheduleAuditDriverWithScheduleID:driverModel.ScheduleID AndType:@"1"];////1、同意 2、拒绝
        }
        
        
    }else {//其他 -- 已接受:查看流程
        
        YPGetSupplierrOrderList *list = self.listMarr[sender.tag - 2000];
    
        if ([list.AnswerStatus integerValue] == 1) {//0 未应答 1、已同意 2、已拒绝
            //查看流程
            YPArrangeLiuChengController *liucheng = [[YPArrangeLiuChengController alloc]init];
            liucheng.supplierOrderID = list.SupplierOrderID;
            [self.navigationController yp_pushViewController:liucheng animated:YES];
    
        }else if ([list.AnswerStatus integerValue] == 0){
            //接受
            [self SupplierOrderReviewWithOrderID:list.SupplierOrderID AndType:@"1"];
        }
        
    }
}

- (void)phoneBtnClick:(UIButton *)sender{
    if (CheShou(Profession_New)){//车手 -- 已接受:查看档期 -- 获取不同的数据
        
        //车手使用数据
        YPGetDriverTimetableListByDriverID *driverModel = self.driverMarr[sender.tag - 3000];
        
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",driverModel.CaptainPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else{
        YPGetSupplierrOrderList *order = self.listMarr[sender.tag - 3000];
        
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",order.CorpPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

#pragma mark - 网络请求
#pragma mark 获取供应商订单列表 -- 除车手外 调用
- (void)GetSupplierrOrderList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSupplierrOrderList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"AnswerType"] = @"0";//0、获取所有、1未应答2、已同意 3、已拒绝
    params[@"SettlementType"] = @"0";//0、获取所有 1、已结算 2、未结算
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.listMarr removeAllObjects];
            self.listMarr = [YPGetSupplierrOrderList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            NSLog(@"烈烈了%zd",self.listMarr.count);
            
            
            if (self.listMarr.count > 0) {
                [self hidenEmptyView];
            }else{
                
                [self showNoDataEmptyView];
                
            }
            [self.tableView reloadData];
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

#pragma mark 供应商订单审核
- (void)SupplierOrderReviewWithOrderID:(NSString *)orderID AndType:(NSString *)type{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/SupplierOrderReview";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"SupplierOrderID"] = orderID;
    params[@"ReviewType"] = type;//1、同意 2、拒绝
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"操作成功!"];
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

#pragma mark - 车手专用
#pragma mark - 车手获取自己安排列表
- (void)GetDriverTimetableListByDriverID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetDriverTimetableListByDriverID";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"DriverID"] = UserId_New;
    params[@"StatuType"] = @"0";//0全部,1已同意,2已拒绝,3未审核
    params[@"BeginTime"] = @"";
    params[@"EndTime"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.driverMarr removeAllObjects];
            self.driverMarr = [YPGetDriverTimetableListByDriverID mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.driverMarr.count > 0) {
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

#pragma mark 车手对档期审核
- (void)UpScheduleAuditDriverWithScheduleID:(NSString *)scheduleID AndType:(NSString *)type{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpScheduleAuditDriver";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"ScheduleID"] = scheduleID;
    params[@"StatuType"] = type;//1、同意 2、拒绝
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"操作成功!"];
            
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

- (NSMutableArray<YPGetDriverTimetableListByDriverID *> *)driverMarr{
    if (!_driverMarr) {
        _driverMarr = [NSMutableArray array];
    }
    return _driverMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetDriverTimetableListByDriverID];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
