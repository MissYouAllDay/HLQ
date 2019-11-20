//
//  YPMeTeHuiOrderListController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMeTeHuiOrderListController.h"
#import "YPMeTHOrderHeadCell.h"
#import "YPMeTHOrderInfoCell.h"
#import "YPMeTHOrderFootTwoBtnCell.h"
#import "YPMeTHOrderFootOneBtnCell.h"
#import "YPMeTHOrderDetailController.h"
#import "YPGetFacilitatorPreferentialOrderList.h"
#import "YPHYTHOrderListSettleRestView.h"

@interface YPMeTeHuiOrderListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UITextField *restTF;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorPreferentialOrderList *> *listMarr;

@end

@implementation YPMeTeHuiOrderListController{
    NSInteger _pageIndex;
    YPHYTHOrderListSettleRestView *_settleView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetFacilitatorPreferentialOrderList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pageIndex = 1;
    
    self.view.backgroundColor = RGBS(245);
    
    [self setupUI];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT-40) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBS(245);
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetFacilitatorPreferentialOrderList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetFacilitatorPreferentialOrderList];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[section];
    if (list.ReceiptType.integerValue == 1){//0待定,1接单,2拒单
        if (list.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效
            if (list.FacilitatorTailMoney.integerValue == 1){//服务商输入尾款状态 0未输入,1已输入
                return 2;
            }
        }
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[indexPath.section];
    if (indexPath.row == 0) {
        YPMeTHOrderHeadCell *cell = [YPMeTHOrderHeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.UserHeadportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (list.UserName.length > 0) {
            cell.titleLabel.text = list.UserName;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (list.UserPhone.length > 0) {
            cell.phoneLabel.text = list.UserPhone;
        }else{
            cell.phoneLabel.text = @"无号码";
        }
        if (list.ReceiptType.integerValue == 0) {//0待定,1接单,2拒单
            cell.tagLabel.text = @"已付定金，等待接单";
        }else if (list.ReceiptType.integerValue == 1){//0待定,1接单,2拒单
            if (list.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效
                if (list.FacilitatorTailMoney.integerValue == 0) {//服务商输入尾款状态 0未输入,1已输入
                    cell.tagLabel.text = @"已接单，等待结清尾款";
                }else if (list.FacilitatorTailMoney.integerValue == 1){
                    cell.tagLabel.text = @"已结清，等待用户确认";
                }
            }else if (list.PaymentStatus.integerValue == 1){
                cell.tagLabel.text = @"已结清尾款";
            }
        }else if (list.ReceiptType.integerValue == 2) {//0待定,1接单,2拒单
            cell.tagLabel.text = @"已拒绝接单";
        }
        return cell;
    }else if (indexPath.row == 1){
        YPMeTHOrderInfoCell *cell = [YPMeTHOrderInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (list.Name.length > 0) {
            cell.titleLabel.text = list.Name;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        cell.zhuoshu.text = list.TableNumber;
        cell.canbiao.text = [NSString stringWithFormat:@"¥%@/桌起",list.MealAmount];
        cell.restLabel.text = [NSString stringWithFormat:@"¥%@",list.PaidAmount];
        cell.timeLabel.text = list.ServiceTime;
        return cell;
    }else{
        YPMeTHOrderFootTwoBtnCell *twocell = [YPMeTHOrderFootTwoBtnCell cellWithTableView:tableView];
        twocell.selectionStyle = UITableViewCellSelectionStyleNone;
        YPMeTHOrderFootOneBtnCell *onecell = [YPMeTHOrderFootOneBtnCell cellWithTableView:tableView];
        onecell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (list.ReceiptType.integerValue == 0) {//0待定,1接单,2拒单
            twocell.acceptBtn.tag = indexPath.section + 1000;
            twocell.refuseBtn.tag = indexPath.section + 2000;
            [twocell.acceptBtn setImage:[UIImage imageNamed:@"MeTH_accept"] forState:UIControlStateNormal];
            [twocell.refuseBtn setImage:[UIImage imageNamed:@"MeTH_refuse"] forState:UIControlStateNormal];
            [twocell.acceptBtn addTarget:self action:@selector(acceptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [twocell.refuseBtn addTarget:self action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return twocell;
        }else if (list.ReceiptType.integerValue == 1){//0待定,1接单,2拒单
            if (list.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效(接单无已失效)
                if (list.FacilitatorTailMoney.integerValue == 0) {//服务商输入尾款状态 0未输入,1已输入
                    onecell.btn.tag = indexPath.section + 3000;
                    [onecell.btn setImage:[UIImage imageNamed:@"MeTH_rest"] forState:UIControlStateNormal];
                    [onecell.btn addTarget:self action:@selector(restBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    return onecell;
                }else if (list.FacilitatorTailMoney.integerValue == 1){
                    return nil;
                }
            }else if (list.PaymentStatus.integerValue == 1){
                onecell.btn.tag = indexPath.section + 4000;
                [onecell.btn setImage:[UIImage imageNamed:@"MeTH_delete"] forState:UIControlStateNormal];
                [onecell.btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                return onecell;
            }
        }else if (list.ReceiptType.integerValue == 2) {//0待定,1接单,2拒单
            onecell.btn.tag = indexPath.section + 4000;
            [onecell.btn setImage:[UIImage imageNamed:@"MeTH_delete"] forState:UIControlStateNormal];
            [onecell.btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return onecell;
        }
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 55;
    }else if (indexPath.row == 1){
        return 150;
    }else if (indexPath.row == 2){
        return 44;
    }
    return 0;
}

// 重新绘制cell边框
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        // if (tableView == self.tableView) {
        
        CGFloat cornerRadius = 4.f;
        
        cell.backgroundColor = ClearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 15, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        //颜色修改
        
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.0f].CGColor;
        
        layer.strokeColor = [UIColor whiteColor].CGColor;
        
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+15, bounds.size.height-lineHeight, bounds.size.width-15, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[indexPath.section];

    YPMeTHOrderDetailController *detail = [[YPMeTHOrderDetailController alloc]init];
    detail.listModel = list;
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - target
- (void)acceptBtnClick:(UIButton *)sender{//1000
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[sender.tag-1000];
    [self UpdateReceiptTypeWithID:list.Id AndType:@"0"];
}

- (void)refuseBtnClick:(UIButton *)sender{//2000
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[sender.tag-2000];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要拒绝这个肥单吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self UpdateReceiptTypeWithID:list.Id AndType:@"1"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
///结清尾款
- (void)restBtnClick:(UIButton *)sender{//3000
    self.index = sender.tag;
    [[UIApplication sharedApplication].keyWindow addSubview:self.control];
}

- (void)deleteBtnClick:(UIButton *)sender{//4000
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[sender.tag-4000];
    [self DeletePreferentialOrderWithID:list.Id];
}

- (void)controlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _settleView.frame = CGRectMake(36, ScreenHeight, ScreenWidth-72, 290);
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
    }];
}

- (void)settleRest{
    YPGetFacilitatorPreferentialOrderList *list = self.listMarr[self.index-3000];
    NSLog(@"rest settle %@ --- %@",self.restTF.text,list.Id);
    [self UpdateTailMoneyWithID:list.Id AndPrice:self.restTF.text];
}

#pragma mark - 网络请求
#pragma mark 获取订单列表(供应商)
- (void)GetFacilitatorPreferentialOrderList{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorPreferentialOrderList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId_New;
    if ([self.typeStr isEqualToString:@"全部"]) {
        params[@"Type"] = @"0";//0全部,1待接单,2待结清,3已结清,4已失效
    }else if ([self.typeStr isEqualToString:@"待接单"]){
        params[@"Type"] = @"1";//0全部,1待接单,2待结清,3已结清,4已失效
    }else if ([self.typeStr isEqualToString:@"待结清"]){
        params[@"Type"] = @"2";//0全部,1待接单,2待结清,3已结清,4已失效
    }else if ([self.typeStr isEqualToString:@"已结清"]){
        params[@"Type"] = @"3";//0全部,1待接单,2待结清,3已结清,4已失效
    }else if ([self.typeStr isEqualToString:@"已拒单"]){
        params[@"Type"] = @"4";//0全部,1待接单,2待结清,3已结清,4已失效
    }
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                
                self.listMarr = [YPGetFacilitatorPreferentialOrderList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetFacilitatorPreferentialOrderList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            
            if (self.listMarr.count > 0) {
                [self hidenEmptyView];
            }else{
                [self showNoDataEmptyView];
            }
            
            [self.tableView reloadData];
            [self endRefresh];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 服务商/用户输入特惠订单尾款
- (void)UpdateTailMoneyWithID:(NSString *)recordID AndPrice:(NSString *)price{
    
    NSString *url = @"/api/HQOAApi/UpdateTailMoney";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = recordID;
    params[@"Type"] = @"1";//0用户,1服务商
    params[@"Price"] = price;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"尾款结清成功!" inView:self.tableView];
            [self controlClick];
            
            [self GetFacilitatorPreferentialOrderList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 服务商接/拒特惠订单
- (void)UpdateReceiptTypeWithID:(NSString *)recordID AndType:(NSString *)type{
    
    NSString *url = @"/api/HQOAApi/UpdateReceiptType";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = recordID;
    params[@"Type"] = type;//0接单,1拒单
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (type.integerValue == 0) {
                [EasyShowTextView showText:@"接单成功!" inView:self.tableView];
            }else if (type.integerValue == 1){
                [EasyShowTextView showText:@"拒单成功!" inView:self.tableView];
            }
            
            [self GetFacilitatorPreferentialOrderList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 删除订单
- (void)DeletePreferentialOrderWithID:(NSString *)recordID{
    
    NSString *url = @"/api/HQOAApi/DeletePreferentialOrder";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = recordID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"删除成功!" inView:self.tableView];
            
            [self GetFacilitatorPreferentialOrderList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetFacilitatorPreferentialOrderList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetFacilitatorPreferentialOrderList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorPreferentialOrderList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_settleView) {
            _settleView = [YPHYTHOrderListSettleRestView yp_orderListSettleRestView];
            _settleView.backgroundColor = WhiteColor;
            _settleView.desc1.text = @"请输入新人到店后";
            _settleView.desc2.text = @"所支付的尾款金额";
            self.restTF = _settleView.inputTF;
            [_settleView.sureBtn addTarget:self action:@selector(settleRest) forControlEvents:UIControlEventTouchUpInside];
            [_settleView.cancleBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    _settleView.frame = CGRectMake(36, ScreenHeight, ScreenWidth-72, 290);
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _settleView.frame = CGRectMake(36, ScreenHeight-145-ScreenHeight*0.5, ScreenWidth-72, 290);
        [_control addSubview:_settleView];
    } completion:nil];
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
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
