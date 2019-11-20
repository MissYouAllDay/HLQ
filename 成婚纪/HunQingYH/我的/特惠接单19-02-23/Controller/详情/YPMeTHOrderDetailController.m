//
//  YPMeTHOrderDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMeTHOrderDetailController.h"
#import "UIImage+YPGradientImage.h"
#import "YPMeTHOrderDetailCustomerCell.h"
#import "YPMeTHOrderDetailInfoCell.h"
#import "YPHYTHOrderDetailNormalInfoCell.h"
#import "YPHYTHOrderListSettleRestView.h"

@interface YPMeTHOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UITextField *restTF;

@end

@implementation YPMeTHOrderDetailController{
    UIView *_navView;
    
    UIView *bottomView;
    UIButton *rightBtn;
    UIButton *cancleBtn;
    
    YPHYTHOrderListSettleRestView *_settleView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self GetPreferentialOrderDetailsInfo];
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
    
    [self setupUI];
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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    UIImageView *bgimgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    bgimgv.image = [UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 75) andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1];
    [view addSubview:bgimgv];
    
    UIImageView *imgv = [[UIImageView alloc]init];
    imgv.image = [UIImage imageNamed:@"HYTH_orderDetailClock"];
    [view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(18);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    UILabel *label = [[UILabel alloc]init];
    if (self.listModel.ReceiptType.integerValue == 0) {//0待定,1接单,2拒单
        label.text = @"已付定金，等待接单";
    }else if (self.listModel.ReceiptType.integerValue == 1){//0待定,1接单,2拒单
        if (self.listModel.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效
            if (self.listModel.FacilitatorTailMoney.integerValue == 0) {//服务商输入尾款状态 0未输入,1已输入
                label.text = @"已接单，等待结清尾款";
            }else if (self.listModel.FacilitatorTailMoney.integerValue == 1){
                label.text = @"已结清，等待用户确认";
            }
        }else if (self.listModel.PaymentStatus.integerValue == 1){
            label.text = @"已结清尾款";
        }
    }else if (self.listModel.ReceiptType.integerValue == 2) {//0待定,1接单,2拒单
        label.text = @"已拒绝接单";
    }
    label.textColor = WhiteColor;
    label.font = kFont(13);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgv.mas_right).offset(5);
        make.centerY.mas_equalTo(imgv);
    }];
    return view;
}

- (void)setupBottomView{
    if (!bottomView) {
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-HOME_INDICATOR_HEIGHT, ScreenWidth,50)];
    }
    bottomView.backgroundColor = WhiteColor;
    bottomView.hidden = NO;
    [self.view addSubview:bottomView];
    
    if (!rightBtn) {
        rightBtn = [[UIButton alloc]init];
    }
    rightBtn.titleLabel.font = kFont(13);
    if (!cancleBtn) {
        cancleBtn = [[UIButton alloc]init];
    }
    cancleBtn.titleLabel.font = kFont(13);
    
    if (self.listModel.ReceiptType.integerValue == 0) {//0待定,1接单,2拒单
        rightBtn.hidden = NO;
        cancleBtn.hidden = NO;
        [rightBtn setImage:[UIImage imageNamed:@"MeTH_accept"] forState:UIControlStateNormal];
        [cancleBtn setImage:[UIImage imageNamed:@"MeTH_refuse"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(acceptBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn addTarget:self action:@selector(refuseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.right.mas_equalTo(-18);
            make.size.mas_equalTo(CGSizeMake(74, 27));
        }];
        [bottomView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.right.mas_equalTo(rightBtn.mas_left).mas_offset(-10);
            make.size.mas_equalTo(rightBtn);
        }];
        
    }else if (self.listModel.ReceiptType.integerValue == 1){//0待定,1接单,2拒单
        if (self.listModel.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效
            if (self.listModel.FacilitatorTailMoney.integerValue == 0) {//服务商输入尾款状态 0未输入,1已输入
                rightBtn.hidden = NO;
                cancleBtn.hidden = YES;
                [rightBtn setImage:[UIImage imageNamed:@"MeTH_rest"] forState:UIControlStateNormal];
                [rightBtn addTarget:self action:@selector(restBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:rightBtn];
                [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(bottomView);
                    make.right.mas_equalTo(-18);
                    make.size.mas_equalTo(CGSizeMake(74, 27));
                }];
            }else if (self.listModel.FacilitatorTailMoney.integerValue == 1){
                bottomView.backgroundColor = ClearColor;
                bottomView.hidden = YES;
            }
        }else if (self.listModel.PaymentStatus.integerValue == 1){
            rightBtn.hidden = NO;
            cancleBtn.hidden = YES;
            [rightBtn setImage:[UIImage imageNamed:@"MeTH_delete"] forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView);
                make.right.mas_equalTo(-18);
                make.size.mas_equalTo(CGSizeMake(74, 27));
            }];
        }
    }else if (self.listModel.ReceiptType.integerValue == 2) {//0待定,1接单,2拒单
        rightBtn.hidden = NO;
        cancleBtn.hidden = YES;
        [rightBtn setImage:[UIImage imageNamed:@"MeTH_delete"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.right.mas_equalTo(-18);
            make.size.mas_equalTo(CGSizeMake(74, 27));
        }];
    }
}

- (void)setupNav{

    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];

    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];

    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"订单详情";
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPMeTHOrderDetailCustomerCell *cell = [YPMeTHOrderDetailCustomerCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.listModel.UserHeadportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (self.listModel.UserName.length > 0) {
            cell.titleLabel.text = self.listModel.UserName;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (self.listModel.UserPhone.length > 0) {
            cell.phoneLabel.text = self.listModel.UserPhone;
        }else{
            cell.phoneLabel.text = @"无号码";
        }
        [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1){
        YPMeTHOrderDetailInfoCell *cell = [YPMeTHOrderDetailInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.listModel.Name.length > 0) {
            cell.tingLabel.text = self.listModel.Name;
        }else{
            cell.tingLabel.text = @"无名称";
        }
        cell.zhuoshu.text = self.listModel.TableNumber;
        cell.canbiao.text = [NSString stringWithFormat:@"¥%@/桌起",self.listModel.MealAmount];
        cell.timeLabel.text = self.listModel.ServiceTime;
        return cell;
    }else if (indexPath.section == 2){
        YPHYTHOrderDetailNormalInfoCell *cell = [YPHYTHOrderDetailNormalInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"到店尾款";
        cell.descLabel.text = [NSString stringWithFormat:@"¥%@",self.listModel.PaidAmount];
        return cell;
    }else {
        YPHYTHOrderDetailNormalInfoCell *cell = [YPHYTHOrderDetailNormalInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"下单时间";
        cell.descLabel.text = self.listModel.CreateTime;
        return cell;
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
    return 9;
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

- (void)phoneBtnClick{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.listModel.UserPhone]]];
}

- (void)acceptBtnClick{
    [self UpdateReceiptTypeWithID:self.listModel.Id AndType:@"0"];
}

- (void)refuseBtnClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要拒绝这个肥单吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self UpdateReceiptTypeWithID:self.listModel.Id AndType:@"1"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
///结清尾款
- (void)restBtnClick{
    [[UIApplication sharedApplication].keyWindow addSubview:self.control];
}

- (void)deleteBtnClick{
    [self DeletePreferentialOrder];
}

- (void)controlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _settleView.frame = CGRectMake(36, ScreenHeight, ScreenWidth-72, 290);
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
    }];
}

- (void)settleRest{
    [self UpdateTailMoneyWithID:self.listModel.Id AndPrice:self.restTF.text];
}

#pragma mark - 网络请求
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 删除订单
- (void)DeletePreferentialOrder{
    
    NSString *url = @"/api/HQOAApi/DeletePreferentialOrder";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = self.listModel.Id;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"删除成功!" inView:self.tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
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
