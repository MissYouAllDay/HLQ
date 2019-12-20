//
//  YPHotelPayTypeListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelPayTypeListController.h"
#import "YPHotelPayHeadCell.h"
#import "YPHotelPayInfoCell.h"
#import "YPHotelPayDaiFuFootCell.h"
#import "YPHotelPayYiFuFootCell.h"
#import "YPGetUserFlowRecord.h"
#import "WXApi.h" //微信支付
#import "DataMD5.h" //修改商户秘钥

@interface YPHotelPayTypeListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetUserFlowRecord *> *listMarr;

//微信支付
@property(nonatomic,copy)NSString *TransNumber;//支付中转号
@property(nonatomic,copy)NSString *PayAmount;//支付金额

@end

@implementation YPHotelPayTypeListController{
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetUserFlowRecord];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-35-40) style:UITableViewStyleGrouped];
    
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
        [self GetUserFlowRecord];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetUserFlowRecord];
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
    
    YPGetUserFlowRecord *list = self.listMarr[indexPath.section];
    
    if (indexPath.row == 0) {
        YPHotelPayHeadCell *cell = [YPHotelPayHeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLab.text = @"消费日期";
        cell.titleLabel.text = list.CreateTime;
        cell.titleLabel.textColor = RGBS(153);
        
        if (list.MakePayment.integerValue == 0) {//0未支付,1已支付,2已拒单
            cell.tagLabel.text = @"待付款";
            cell.tagLabel.textColor = RGB(250, 80, 120);
        }else if (list.MakePayment.integerValue == 1) {//0未支付,1已支付,2已拒单
            cell.tagLabel.text = @"已付款";
            cell.tagLabel.textColor = RGB(250, 80, 120);
        }else if (list.MakePayment.integerValue == 2){//0未支付,1已支付,2已拒单
            cell.tagLabel.text = @"已拒单";
            cell.tagLabel.textColor = RGBS(153);
        }

        return cell;
    }else if (indexPath.row == 1){
        YPHotelPayInfoCell *cell = [YPHotelPayInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.yingfuPrice.text = [NSString stringWithFormat:@"¥%.2f",list.Money];
        cell.fanhuanPrice.text = [NSString stringWithFormat:@"¥%.2f",list.DistributionLine];
        if (list.OrderType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
            cell.fanhuanDesc.text = @"返还至伴手礼额度";
        }else if (list.OrderType.integerValue == 1){
            cell.fanhuanDesc.text = @"返还至婚礼返还额度";
        }else if (list.OrderType.integerValue == 2){
            cell.fanhuanDesc.text = @"返还至代收额度";
        }
            
        if (list.FacilitatorName.length > 0) {
            cell.titleLabel.text = list.FacilitatorName;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (list.PaymentType.integerValue == 0) {//0线上,1线下
            cell.payType.text = @"线上支付";
        }else if (list.PaymentType.integerValue == 1){
            cell.payType.text = @"线下支付";
        }
        if (list.Type.integerValue == 0) {//0未审核,1已审核,2已驳回
            cell.shenhe.text = @"待审核";
        }else if (list.Type.integerValue == 1){//0未审核,1已审核,2已驳回
            cell.shenhe.text = @"已审核";
        }else if (list.Type.integerValue == 2){//0未审核,1已审核,2已驳回
            cell.shenhe.text = @"已驳回";
        }
        
        return cell;
    }else if (indexPath.row == 2){

        if (list.MakePayment.integerValue == 0) {//0未支付,1已支付,2已拒单
            YPHotelPayDaiFuFootCell *cell = [YPHotelPayDaiFuFootCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",list.Money];
            cell.refuseBtn.tag = indexPath.section + 1000;
            cell.payBtn.tag = indexPath.section + 2000;
            [cell.refuseBtn addTarget:self action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (list.MakePayment.integerValue == 1){//0未支付,1已支付,2已拒单
            
            YPHotelPayYiFuFootCell *cell = [YPHotelPayYiFuFootCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.deleteBtn.hidden = NO;
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",list.Money];
            cell.deleteBtn.tag = indexPath.section + 3000;
            [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else {//已拒单
            
            YPHotelPayYiFuFootCell *cell = [YPHotelPayYiFuFootCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.deleteBtn.hidden = YES;
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",list.Money];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - target
///拒单
- (void)refuseBtnClick:(UIButton *)sender{
    NSLog(@"拒单 --- %zd",sender.tag);
    
    YPGetUserFlowRecord *record = self.listMarr[sender.tag-1000];
    [self UserRefusalDeleteWithID:record.Id AndRefusalType:@"1" AndDeleteType:@"0"];
}
///付款
- (void)payBtnClick:(UIButton *)sender{
    NSLog(@"付款 --- %zd",sender.tag);
    
    YPGetUserFlowRecord *record = self.listMarr[sender.tag-2000];
    if (record.OrderType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        [self PaymentWithObjectId:record.Id AndOrderType:@"2"];//1婚嫁采购节2伴手礼3婚礼返还4代收
    }else if (record.OrderType.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        [self PaymentWithObjectId:record.Id AndOrderType:@"3"];//1婚嫁采购节2伴手礼3婚礼返还4代收
    }else if (record.OrderType.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        [self PaymentWithObjectId:record.Id AndOrderType:@"4"];//1婚嫁采购节2伴手礼3婚礼返还4代收
    }
    
}
///删除
- (void)deleteBtnClick:(UIButton *)sender{
    NSLog(@"删除 --- %zd",sender.tag);
    
    YPGetUserFlowRecord *record = self.listMarr[sender.tag-3000];
    [self UserRefusalDeleteWithID:record.Id AndRefusalType:@"0" AndDeleteType:@"1"];
}

#pragma mark - 网络请求
#pragma mark 获取用户订单列表
- (void)GetUserFlowRecord{

    NSString *url = @"/api/HQOAApi/GetUserFlowRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"Type"] = @"0";//0所有,1伴手礼,2婚礼返还,3代收
    if ([self.typeStr isEqualToString:@"全部"]) {
        params[@"State"] = @"0";//0全部,1待付款,2已付款,已拒单
    }else if ([self.typeStr isEqualToString:@"待付款"]){
        params[@"State"] = @"1";//0全部,1待付款,2已付款,已拒单
    }else if ([self.typeStr isEqualToString:@"已付款"]){
        params[@"State"] = @"2";//0全部,1待付款,2已付款,已拒单
    }else if ([self.typeStr isEqualToString:@"已拒单"]){
        params[@"State"] = @"3";//0全部,1待付款,2已付款,已拒单
    }
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                
                self.listMarr = [YPGetUserFlowRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetUserFlowRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
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

#pragma mark 用户拒单/删除
- (void)UserRefusalDeleteWithID:(NSString *)recordID AndRefusalType:(NSString *)refusalType AndDeleteType:(NSString *)deleteType{
    
    NSString *url = @"/api/HQOAApi/UserRefusalDelete";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"Id"] = recordID;
    params[@"RefusalType"] = refusalType;
    params[@"DeleteType"] =  deleteType;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (refusalType.integerValue == 1) {
                [EasyShowTextView showText:@"拒单成功!"];
            }else if (deleteType.integerValue == 1){
                [EasyShowTextView showText:@"删除成功!"];
            }
            
            [self GetUserFlowRecord];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 支付
- (void)PaymentWithObjectId:(NSString *)objID AndOrderType:(NSString *)orderType{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/Payment";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"PayType"] = @"0";//0微信  1支付宝
    params[@"ObjectType"] = orderType;//1婚嫁采购节2伴手礼3婚礼返还4代收
    params[@"ObjectId"]  = objID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"微信中转参数：%@",object);
            self.TransNumber = [object objectForKey:@"TransNumber"];
            self.PayAmount = [object objectForKey:@"PayAmount"];
            [self weiPayregisterRequest];
            
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
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
        
    } Failure:^(NSError *error) {
        
        NSLog(@"failure -- %@",error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络请求失败" message:@"请重试" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification{
    
    if ([notification.object isEqualToString:@"success"]) {

        [EasyShowTextView showSuccessText:@"支付成功" inView:self.tableView];
//        [self performSelector:@selector(menpiaoBtnClick) withObject:self afterDelay:1.0];
        
    } else {
   
        [EasyShowTextView showErrorText:@"支付失败" inView:self.tableView];
  
    }
    [self GetUserFlowRecord];
    
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
        [self GetUserFlowRecord];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetUserFlowRecord];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSMutableArray<YPGetUserFlowRecord *> *)listMarr{
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
