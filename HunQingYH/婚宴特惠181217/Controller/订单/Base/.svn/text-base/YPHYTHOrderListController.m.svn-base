//
//  YPHYTHOrderListController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/3.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderListController.h"
#import "YPHYTHOrderListInfoCell.h"
#import "YPHYTHOrderListRestPayCountCell.h"
#import "YPHYTHOrderListAllPayCell.h"
#import "YPHYTHOrderListDeleteCell.h"
#import "YPHYTHOrderListDateOutDeleteCell.h"
#import "YPHYTHOrderPayController.h"//支付
#import "YPHYTHOrderDetailController.h"//详情
#import "YPGetPreferentialOrderList.h"
#import "YPHYTHRefundController.h"//退款

#import "YPHYTHOrderListReHeadCell.h"
#import "YPHYTHOrderListReInfoCell.h"
#import "YPHYTHOrderListReDingjinFootCell.h"
#import "YPHYTHOrderListSettleRestView.h"
#import "YPHYTHOrderPaySucceedController.h"
#import "WXApi.h" //微信支付
#import "DataMD5.h" //修改商户秘钥

@interface YPHYTHOrderListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UITextField *restTF;
@property (nonatomic, assign) NSInteger index;

//微信支付
@property(nonatomic,copy)NSString *TransNumber;//支付中转号
@property(nonatomic,copy)NSString *PayAmount;//支付金额

@property (nonatomic, strong) NSMutableArray<YPGetPreferentialOrderList *> *listMarr;

@end

@implementation YPHYTHOrderListController{
    NSInteger _pageIndex;
    YPHYTHOrderListSettleRestView *_settleView;
    NSString *_selectID;//选中付定金的ID
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetPreferentialOrderList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pageIndex = 1;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-35-40-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetPreferentialOrderList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetPreferentialOrderList];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetPreferentialOrderList *list = self.listMarr[indexPath.section];
    
    if (indexPath.row == 0) {
        YPHYTHOrderListReHeadCell *cell = [YPHYTHOrderListReHeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (list.FacilitatorName.length > 0) {
            cell.titleLabel.text = list.FacilitatorName;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        cell.tagLabel.textColor = RGB(250, 80, 120);
//        cell.timeLabel.hidden = YES;//19-02-21 隐藏-郝
        if (list.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            if (list.PaymentType.integerValue == 0) {//0待定,1定金,2已结清(已结清等待酒店确认)
                cell.tagLabel.text = @"待支付定金";
//                cell.timeLabel.text = [NSString stringWithFormat:@"倒计时%@",list.ValidityTime];
            }else if (list.PaymentType.integerValue == 1){
                cell.tagLabel.text = @"等待到店结清尾款";
            }else if (list.PaymentType.integerValue == 2){
                cell.tagLabel.text = @"已付尾款，等待酒店确认";
            }
            
        }else if (list.PaymentStatus.integerValue == 1) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            cell.tagLabel.text = @"尾款结清，交易已完成";
        }else if (list.PaymentStatus.integerValue == 2){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            cell.tagLabel.text = @"已失效";
        }else if (list.PaymentStatus.integerValue == 3){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            cell.tagLabel.text = @"同意退款";
        }else if (list.PaymentStatus.integerValue == 4){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            cell.tagLabel.text = @"拒绝退款";
        }else if (list.PaymentStatus.integerValue == 5){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            cell.tagLabel.text = @"退款审核";
        }else if (list.PaymentStatus.integerValue == 6){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            cell.tagLabel.text = @"已拒单";
        }
        
        return cell;
    }else if (indexPath.row == 1){
        YPHYTHOrderListReInfoCell *cell = [YPHYTHOrderListReInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (list.Name.length > 0) {
            cell.titleLabel.text = list.Name;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        cell.zhuoshu.text = list.TableNumber;
        cell.canbiao.text = [NSString stringWithFormat:@"¥%@/桌起",list.MealAmount];
        cell.weikuan.text = [NSString stringWithFormat:@"¥%@",list.PaidAmount];
        return cell;
    }else{
        if (list.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
            if (list.PaymentType.integerValue == 0) {//0待定,1定金,2已结清(已结清等待酒店确认)
                YPHYTHOrderListReDingjinFootCell *cell = [YPHYTHOrderListReDingjinFootCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.dingjin.text = [NSString stringWithFormat:@"¥%.1f",list.EarnestMoney.floatValue];//19-02-22 改为定金
                cell.payBtn.tag = indexPath.section + 1000;
                cell.deleteBtn.tag = indexPath.section + 2000;
                [cell.payBtn setTitle:@"付款" forState:UIControlStateNormal];
                [cell.deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                [cell.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else if (list.PaymentType.integerValue == 1){//结清尾款
                YPHYTHOrderListReDingjinFootCell *cell = [YPHYTHOrderListReDingjinFootCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.dingjin.text = [NSString stringWithFormat:@"¥%.1f",list.EarnestMoney.floatValue];//19-02-22 改为定金
                cell.payBtn.tag = indexPath.section + 1000;
                cell.deleteBtn.tag = indexPath.section + 3000;
                [cell.payBtn setTitle:@"结清尾款" forState:UIControlStateNormal];
                [cell.deleteBtn setTitle:@"申请退款" forState:UIControlStateNormal];
                [cell.payBtn addTarget:self action:@selector(settleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.deleteBtn addTarget:self action:@selector(refundClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else if (list.PaymentType.integerValue == 2){
                YPHYTHOrderListDeleteCell *cell = [YPHYTHOrderListDeleteCell  cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.realMoney.text = [NSString stringWithFormat:@"¥%.1f",list.EarnestMoney.floatValue];//19-02-22 改为定金
                cell.deleteBtn.hidden = YES;
                [cell.deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                return cell;
            }
            
        }else if (list.PaymentStatus.integerValue == 1 || list.PaymentStatus.integerValue == 2 || list.PaymentStatus.integerValue == 3 || list.PaymentStatus.integerValue == 6) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单 --- 有删除按钮(交易结束/同意退款)- 19-02-19郝
            YPHYTHOrderListDeleteCell *cell = [YPHYTHOrderListDeleteCell  cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.realMoney.text = [NSString stringWithFormat:@"¥%.1f",list.EarnestMoney.floatValue];//19-02-22 改为定金
            cell.deleteBtn.hidden = NO;
            cell.deleteBtn.tag = indexPath.section + 2000;
            [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (list.PaymentStatus.integerValue == 4 || list.PaymentStatus.integerValue == 5){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单 -- 无删除按钮
            YPHYTHOrderListDeleteCell *cell = [YPHYTHOrderListDeleteCell  cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.realMoney.text = [NSString stringWithFormat:@"¥%.1f",list.EarnestMoney.floatValue];//19-02-22 改为定金
            cell.deleteBtn.hidden = YES;
            return cell;
        }
    }
    return nil;
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
    
    YPGetPreferentialOrderList *record = self.listMarr[indexPath.section];
    
    YPHYTHOrderDetailController *detail = [[YPHYTHOrderDetailController alloc]init];
    detail.detailID = record.Id;
    detail.PaymentStatus = record.PaymentStatus;
    [self.navigationController pushViewController:detail animated:YES];

}

#pragma mark - target
///付款
- (void)payBtnClick:(UIButton *)sender{
    NSLog(@"付款 --- %zd",sender.tag);
    
    //19-02-19 直接支付
    YPGetPreferentialOrderList *record = self.listMarr[sender.tag-1000];
    _selectID = record.Id;
    [self paymentFirstRequestWithRecordID:record.Id];
    
//    YPHYTHOrderPayController *pay = [[YPHYTHOrderPayController alloc]init];
//    pay.recordID = record.Id;
//    [self.navigationController pushViewController:pay animated:YES];
    
}

///删除
- (void)deleteBtnClick:(UIButton *)sender{
    NSLog(@"删除 --- %zd",sender.tag);
    
    YPGetPreferentialOrderList *record = self.listMarr[sender.tag-2000];
    [self DeletePreferentialOrderWithID:record.Id];
}

///申请退款
- (void)refundClick:(UIButton *)sender{
    NSLog(@"退款 --- %zd",sender.tag);
    YPGetPreferentialOrderList *record = self.listMarr[sender.tag-3000];
    
    YPHYTHRefundController *refund = [[YPHYTHRefundController alloc]init];
    refund.Id = record.Id;
    refund.Name = record.Name;
    refund.TableNumber = record.TableNumber;
    refund.MealAmount = record.MealAmount;
    refund.PaymentAmount = record.PaymentAmount;//传支付金额 - 19-01-14徐
    refund.CoverMap = record.CoverMap;
    [self.navigationController pushViewController:refund animated:YES];
}

///结清尾款
- (void)settleBtnClick:(UIButton *)sender{
    self.index = sender.tag;
    [[UIApplication sharedApplication].keyWindow addSubview:self.control];
}

- (void)controlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _settleView.frame = CGRectMake(36, ScreenHeight, ScreenWidth-72, 290);
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
    }];
}

- (void)settleRest{
    YPGetPreferentialOrderList *list = self.listMarr[self.index-1000];
    NSLog(@"rest settle %@ --- %@",self.restTF.text,list.Id);
    [self UpdateTailMoneyWithID:list.Id AndPrice:self.restTF.text];
}

#pragma mark - 网络请求
#pragma mark 获取订单列表(新人)
- (void)GetPreferentialOrderList{
    
//    NSString *url = @"/api/HQOAApi/GetPreferentialOrderList";
    NSString *url = @"/api/HQOAApi/GetBanquetOrderList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"UserId"] = UserId_New;
    params[@"FacilitatorId"] = @"";//19-02-20 传空-徐
    if ([self.typeStr isEqualToString:@"全部"]) {
        params[@"PaymentStatus"] = @"0";//0全部,1待支付,2已支付,3已失效
    }else if ([self.typeStr isEqualToString:@"待支付"]){
        params[@"PaymentStatus"] = @"1";//0全部,1待支付,2已支付,3已失效
    }else if ([self.typeStr isEqualToString:@"已付款"]){
        params[@"PaymentStatus"] = @"2";//0全部,1待支付,2已支付,3已失效
    }else if ([self.typeStr isEqualToString:@"已失效"]){
        params[@"PaymentStatus"] = @"3";//0全部,1待支付,2已支付,3已失效
    }
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {

                [self.listMarr removeAllObjects];

                self.listMarr = [YPGetPreferentialOrderList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

            }else{
                NSArray *newArray = [YPGetPreferentialOrderList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

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

#pragma mark 删除订单
- (void)DeletePreferentialOrderWithID:(NSString *)recordID{
    
    NSString *url = @"/api/HQOAApi/DeletePreferentialOrder";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = recordID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"删除成功!" inView:self.tableView];
            
            [self GetPreferentialOrderList];
            
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
    params[@"Type"] = @"0";//0用户,1服务商
    params[@"Price"] = price;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"尾款结清成功!" inView:self.tableView];
            [self controlClick];
            
            [self GetPreferentialOrderList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 支付
- (void)paymentFirstRequestWithRecordID:(NSString *)recordID{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/Payment";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"PayType"] = @"0";//0微信  1支付宝
    params[@"ObjectType"] = @"5";//5特惠商品购买
    params[@"ObjectId"] = recordID;
    params[@"ObjectStates"] = @"1";//0全款,1定金,2尾款
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"微信中转参数：%@",object);
            self.TransNumber =[object objectForKey:@"TransNumber"];
            self.PayAmount =[object objectForKey:@"PayAmount"];
            [self weiPayregisterRequest];
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！" inView:self.tableView];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

- (void)weiPayregisterRequest{
    
    NSString *url = @"/api/HQOAApi/WeChatAppPay";
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"TransNumber"] =self.TransNumber;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"微信支付返回参数：%@",object);
            //判断是否安装微信
            if([WXApi isWXAppInstalled]) {
                // 监听一个通知
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
            }
            //配置调起微信支付所需要的参数
            PayReq *req  = [[PayReq alloc] init];
            req.partnerId = [object objectForKey:@"partnerid"];
            req.prepayId = [object objectForKey:@"prepayid"];
            req.package = @"Sign=WXPay";
            req.nonceStr = [object objectForKey:@"noncestr"];
            req.timeStamp = [[object objectForKey:@"timestamp"]intValue];
            DataMD5 *md5 = [[DataMD5 alloc] init];
            req.sign=[md5 createMD5SingForPay:[object objectForKey:@"appid"] partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
            //调起微信支付
            if ([WXApi sendReq:req]) {
                NSLog(@"调起微信支付成功");
                
            }else{
                NSLog(@"调起微信支付失败");
                
            }
        }else{
            [EasyShowTextView showErrorText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] inView:self.tableView];
        }
        
    } Failure:^(NSError *error) {
        
        NSLog(@"failure -- %@",error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络请求失败" message:@"请重试" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([notification.object isEqualToString:@"success"]) {
        YPHYTHOrderPaySucceedController *suc = [[YPHYTHOrderPaySucceedController alloc]init];
        suc.recordID = _selectID;
        [self.navigationController pushViewController:suc animated:YES];
    } else {
        [EasyShowTextView showErrorText:@"支付失败" inView:self.tableView];
    }
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
        [self GetPreferentialOrderList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialOrderList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSMutableArray<YPGetPreferentialOrderList *> *)listMarr{
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
            _settleView.desc1.text = @"请输入您到酒店后";
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
