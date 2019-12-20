//
//  YPHYTHOrderPayController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/4.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderPayController.h"
#import "YPHYTHOrderPayWayCell.h"
#import "YPHYTHOrderPayInfoCell.h"
#import "YPHYTHOrderPayRealPayCell.h"
#import "YPHYTHOrderPayWaySelectCell.h"
#import "YPHYTHOrderPaySucceedController.h"
#import "YPGetPreferentialOrderDetailsInfo.h"
#import "WXApi.h" //微信支付
#import "DataMD5.h" //修改商户秘钥

@interface YPHYTHOrderPayController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetPreferentialOrderDetailsInfo *infoModel;

//微信支付
@property(nonatomic,copy)NSString *TransNumber;//支付中转号
@property(nonatomic,copy)NSString *PayAmount;//支付金额

@end

@implementation YPHYTHOrderPayController{
    UIView *_navView;
    UILabel *_payMoneyLab;
    NSInteger _payWay;//1:全款 2:定金 3:尾款
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetPreferentialOrderDetailsInfo];
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
    
    self.view.backgroundColor = WhiteColor;

    [self setupNav];
    
}

#pragma mark - UI
- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableHeaderView = [self setupHeadView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self setupBottomView];
    
}

- (UIView *)setupHeadView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 75)];
    UIImageView *imgv = [[UIImageView alloc]init];
    imgv.image = [UIImage imageNamed:@"HYTH_banner"];
    [view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    return view;
}

- (void)setupBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-HOME_INDICATOR_HEIGHT, ScreenWidth,50)];
    bottomView.backgroundColor = WhiteColor;
    [self.view addSubview:bottomView];
    
    UIView *colorView = [[UIView alloc] init];
    [colorView setFrame:CGRectMake(0,0, ScreenWidth, 50)];
    [bottomView addSubview:colorView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView.layer addSublayer:gradient];
    
    UILabel *rmblabel = [[UILabel alloc]init];
    rmblabel.text = @"¥";
    rmblabel.textColor = WhiteColor;
    rmblabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
    [colorView addSubview:rmblabel];
    [rmblabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(colorView);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"立即支付";
    label.textColor = WhiteColor;
    label.font = kFont(12);
    [colorView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rmblabel.mas_left).offset(-11);
        make.bottom.mas_equalTo(rmblabel).mas_offset(-3);
    }];
    
    _payMoneyLab = [[UILabel alloc]init];
    if (_payWay == 1) {//全款
        _payMoneyLab.text = self.infoModel.TotalOrders;
    }else if (_payWay == 2){//定金
        _payMoneyLab.text = self.infoModel.Earnestmoney;
    }else{//尾款
        _payMoneyLab.text = self.infoModel.PaidAmount;
    }
    
    _payMoneyLab.textColor = WhiteColor;
    _payMoneyLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 20];
    [colorView addSubview:_payMoneyLab];
    [_payMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rmblabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(rmblabel).mas_offset(3);
    }];
    
    UIButton *payBtn = [[UIButton alloc]init];
    [payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bottomView);
    }];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"支付";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (_payWay == 1) {//全款
            return 4;
        }else if (_payWay == 2) {//定金
            return 5;
        }else{//尾款
            return 4;
        }
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label = [[UILabel alloc]init];
            label.text = @"付款方式";
            label.textColor = RGBS(153);
            label.font = kFont(15);
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(36);
                make.top.mas_equalTo(18);
            }];
            return cell;
        }else if (indexPath.row == 1){
            YPHYTHOrderPayWayCell *cell = [YPHYTHOrderPayWayCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.restLab2.text = [NSString stringWithFormat:@"¥%@",self.infoModel.Earnestmoney];//定金
            
            if (_payWay == 1) {//全款
                cell.allBtn.layer.borderColor = CHJ_RedColor.CGColor;
                [cell.allBtn setBackgroundColor:RGBA(251, 161, 182, 1)];
                cell.allLab1.textColor = cell.allLab2.textColor = WhiteColor;
                
                cell.restBtn.layer.borderColor = RGBA(228, 229, 233, 1).CGColor;
                [cell.restBtn setBackgroundColor:RGBS(247)];
                cell.restLab1.textColor = cell.restLab2.textColor = RGBS(51);
            }else if (_payWay == 2) {//定金
                cell.restBtn.layer.borderColor = CHJ_RedColor.CGColor;
                [cell.restBtn setBackgroundColor:RGBA(251, 161, 182, 1)];
                cell.restLab1.textColor = cell.restLab2.textColor = WhiteColor;
                
                cell.allBtn.layer.borderColor = RGBA(228, 229, 233, 1).CGColor;
                [cell.allBtn setBackgroundColor:RGBS(247)];
                cell.allLab1.textColor = cell.allLab2.textColor = RGBS(51);
            }else{//尾款
                YPHYTHOrderPayInfoCell *cell = [YPHYTHOrderPayInfoCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLab1.text = @"订单总额";
                cell.titleLab2.text = @"服务费";
                cell.titleLab3.text = @"立减金额";
                cell.descLab1.text = [NSString stringWithFormat:@"¥ %.1f",self.infoModel.TableNumber.floatValue*self.infoModel.MealAmount.floatValue];//19-01-11 未优惠前的金额 桌数*餐标 郝
                cell.descLab2.text = [NSString stringWithFormat:@"+¥ %@",self.infoModel.ServiceCharge];
                cell.descLab3.text = [NSString stringWithFormat:@"-¥ %@",self.infoModel.ReductionAmount];
                return cell;
            }
            
            __weak typeof(self) WeakSelf = self;
            cell.yp_payWayBlock = ^(UIButton * _Nonnull btn1, UILabel * _Nonnull lab1, UILabel * _Nonnull lab2, UIButton * _Nonnull btn2, UILabel * _Nonnull lab3, UILabel * _Nonnull lab4) {
                
                if (btn1.tag == 1001) {//点击全款
                    NSLog(@"全款");
                    _payWay = 1;
                    _payMoneyLab.text = self.infoModel.TotalOrders;//支付总额
                }else if (btn1.tag == 1002){//点击定金
                    NSLog(@"定金");
                    _payWay = 2;
                    _payMoneyLab.text = self.infoModel.Earnestmoney;//定金
                }
                [WeakSelf.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            };
            return cell;
        }else if (indexPath.row == 2){
            if (_payWay == 3) {//尾款
                
                YPHYTHOrderPayInfoCell *cell = [YPHYTHOrderPayInfoCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLab1.text = @"已付定金";
                cell.titleLab2.text = @"剩余尾款";
                cell.titleLab3.text = @"尾款倒计时";
                cell.descLab1.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.PaymentAmount];//已经支付的定金
                cell.descLab2.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.PaidAmount];
                cell.descLab3.text = self.infoModel.ValidityTime;//倒计时
                return cell;
                
            }else{
                YPHYTHOrderPayInfoCell *cell = [YPHYTHOrderPayInfoCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLab1.text = @"订单总额";
                cell.titleLab2.text = @"服务费";
                cell.titleLab3.text = @"立减金额";
                cell.descLab1.text = [NSString stringWithFormat:@"¥ %.1f",self.infoModel.TableNumber.floatValue*self.infoModel.MealAmount.floatValue];//19-01-11 未优惠前的金额 桌数*餐标 郝
                cell.descLab2.text = [NSString stringWithFormat:@"+¥ %@",self.infoModel.ServiceCharge];
                cell.descLab3.text = [NSString stringWithFormat:@"-¥ %@",self.infoModel.ReductionAmount];
                return cell;
            }
        }else if (indexPath.row == 3){
            if (_payWay == 1 || _payWay == 3) {//全款 / 尾款
                YPHYTHOrderPayRealPayCell *cell = [YPHYTHOrderPayRealPayCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.realPayMoney.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.PaidAmount];//19-01-18 全款尾款都用 待付金额 徐
                return cell;
            }else if (_payWay == 2) {//定金
                YPHYTHOrderPayInfoCell *cell = [YPHYTHOrderPayInfoCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLab1.text = @"预付定金";
                cell.titleLab2.text = @"剩余尾款";
                cell.titleLab3.text = @"尾款倒计时";
                cell.descLab1.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.Earnestmoney];//定金
                cell.descLab2.text = [NSString stringWithFormat:@"¥ %.1f",self.infoModel.TotalOrders.floatValue-self.infoModel.Earnestmoney.floatValue];//支付总额-定金
                cell.descLab3.text = self.infoModel.ValidityTime;//倒计时
                return cell;
            }
        }else{//定金 第四行 显示定金
            YPHYTHOrderPayRealPayCell *cell = [YPHYTHOrderPayRealPayCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.realPayMoney.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.Earnestmoney];
            return cell;
        }
        
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label = [[UILabel alloc]init];
            label.text = @"支付方式";
            label.textColor = RGBS(153);
            label.font = kFont(15);
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(36);
                make.top.mas_equalTo(18);
            }];
            return cell;
        }else{
            YPHYTHOrderPayWaySelectCell *cell = [YPHYTHOrderPayWaySelectCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)payBtnClick{
    [self paymentFirstRequest];
}

#pragma mark - 网络请求
#pragma mark 获取订单详情
- (void)GetPreferentialOrderDetailsInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetPreferentialOrderDetailsInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.recordID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.Id = [object valueForKey:@"Id"];
            self.infoModel.PeopleName = [object valueForKey:@"PeopleName"];
            self.infoModel.Phone = [object valueForKey:@"Phone"];
            self.infoModel.Area = [object valueForKey:@"Area"];
            self.infoModel.CommodityName = [object valueForKey:@"CommodityName"];
            self.infoModel.HotelName = [object valueForKey:@"HotelName"];
            self.infoModel.ServiceTime = [object valueForKey:@"ServiceTime"];
            self.infoModel.TableNumber = [object valueForKey:@"TableNumber"];
            self.infoModel.MealAmount = [object valueForKey:@"MealAmount"];
            self.infoModel.TotalOrders = [object valueForKey:@"TotalOrders"];
            self.infoModel.ReductionAmount = [object valueForKey:@"ReductionAmount"];
            self.infoModel.PaymentAmount = [object valueForKey:@"PaymentAmount"];
            self.infoModel.PaidAmount = [object valueForKey:@"PaidAmount"];
            self.infoModel.ServiceCharge = [object valueForKey:@"ServiceCharge"];
            self.infoModel.PaymentType = [object valueForKey:@"PaymentType"];
            self.infoModel.UndertakeType = [object valueForKey:@"UndertakeType"];
            self.infoModel.Earnestmoney = [object valueForKey:@"Earnestmoney"];
            self.infoModel.CoverMap = [object valueForKey:@"CoverMap"];
            self.infoModel.CreateTime = [object valueForKey:@"CreateTime"];
            self.infoModel.ValidityTime = [object valueForKey:@"ValidityTime"];
            
            if (self.infoModel.PaymentType.integerValue == 0){//0待定,1定金,2已结清,3全款
                _payWay = 1;//默认全款
                _payMoneyLab.text = self.infoModel.TotalOrders;//支付总额
            }else if (self.infoModel.PaymentType.integerValue == 1){
                _payWay = 3;//尾款
                _payMoneyLab.text = self.infoModel.PaidAmount;//支付尾款
            }
            
            [self setupUI];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [self showNetErrorEmptyView];
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialOrderDetailsInfo];
    }];
    
}

#pragma mark 支付
- (void)paymentFirstRequest{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/Payment";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"PayType"] = @"0";//0微信  1支付宝
    params[@"ObjectType"] = @"5";//5特惠商品购买
    params[@"ObjectId"] = self.recordID;
    if (_payWay == 1) {//1:全款 2:定金 3:尾款
        params[@"ObjectStates"] = @"0";//0全款,1定金,2尾款
    }else if (_payWay == 2){
        params[@"ObjectStates"] = @"1";//0全款,1定金,2尾款
    }else if (_payWay == 3){
        params[@"ObjectStates"] = @"2";//0全款,1定金,2尾款
    }
    
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
//        [EasyShowTextView showSuccessText:@"支付成功" inView:self.tableView];
        YPHYTHOrderPaySucceedController *suc = [[YPHYTHOrderPaySucceedController alloc]init];
        suc.recordID = self.recordID;
        [self.navigationController pushViewController:suc animated:YES];
    } else {
        [EasyShowTextView showErrorText:@"支付失败" inView:self.tableView];
    }
}

#pragma mark - getter
- (YPGetPreferentialOrderDetailsInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetPreferentialOrderDetailsInfo alloc]init];
    }
    return _infoModel;
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
