//
//  YPHYTHOrderDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/7.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderDetailController.h"
#import "YPHYTHOrderDetailOrderInfoCell.h"
#import "YPHYTHOrderPayInfoCell.h"
#import "YPHYTHOrderPayRealPayCell.h"
#import "YPHYTHOrderDetailNormalInfoCell.h"
#import "YPHYTHOrderDetailPaidInfoCell.h"
#import "YPGetPreferentialOrderDetailsInfo.h"
#import "YPHYTHOrderPayController.h"//支付
#import "YPHYTHOrderPaySucceedController.h"//支付成功
#import "YPHYTHRefundController.h"//退款
#import "YPHYTHOrderDetailOrderPriceInfoCell.h"
#import "YPHYTHOrderListSettleRestView.h"
#import "WXApi.h" //微信支付
#import "DataMD5.h" //修改商户秘钥

@interface YPHYTHOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UITextField *restTF;

@property (nonatomic, strong) YPGetPreferentialOrderDetailsInfo *infoModel;

//微信支付
@property(nonatomic,copy)NSString *TransNumber;//支付中转号
@property(nonatomic,copy)NSString *PayAmount;//支付金额

@end

@implementation YPHYTHOrderDetailController{
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
    
    self.view.backgroundColor = CHJ_bgColor;
    
//    [self setupUI];
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
    bgimgv.image = [self gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 75) andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1];
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
    if (self.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        if (self.infoModel.PaymentType.integerValue == 0) {//0待定,1定金,2已结清(已结清等待酒店确认)
            label.text = @"待支付定金";
        }else if (self.infoModel.PaymentType.integerValue == 1){
            label.text = @"等待到店结清尾款";
        }else if (self.infoModel.PaymentType.integerValue == 2){
            label.text = @"已付尾款，等待酒店确认";
        }
    }else if (self.PaymentStatus.integerValue == 1) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        label.text = @"尾款结清，交易已完成";
    }else if (self.PaymentStatus.integerValue == 2){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        label.text = @"已失效";
    }else if (self.PaymentStatus.integerValue == 3){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        label.text = @"同意退款";
    }else if (self.PaymentStatus.integerValue == 4){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        label.text = @"拒绝退款";
    }else if (self.PaymentStatus.integerValue == 5){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        label.text = @"退款审核";
    }else if (self.PaymentStatus.integerValue == 6){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        label.text = @"已拒单";
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
    
    if (self.PaymentStatus.integerValue == 0) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单
        if (self.infoModel.PaymentType.integerValue == 0) {//0待定,1定金,2已结清(已结清等待酒店确认)
            [rightBtn setTitle:@"付款" forState:UIControlStateNormal];
            [rightBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
            rightBtn.layer.borderColor = CHJ_RedColor.CGColor;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            rightBtn.layer.cornerRadius = 14;
            rightBtn.clipsToBounds = YES;
            rightBtn.layer.borderWidth = 1;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView);
                make.right.mas_equalTo(-18);
                make.size.mas_equalTo(CGSizeMake(74, 27));
            }];
            
            [cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [cancleBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
            cancleBtn.layer.borderColor = RGBS(221).CGColor;
            cancleBtn.layer.cornerRadius = 14;
            cancleBtn.clipsToBounds = YES;
            cancleBtn.layer.borderWidth = 1;
            [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancleBtn];
            [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView);
                make.right.mas_equalTo(rightBtn.mas_left).mas_offset(-10);
                make.size.mas_equalTo(rightBtn);
            }];
            
        }else if (self.infoModel.PaymentType.integerValue == 1){//结清尾款
            
            [rightBtn setTitle:@"结清尾款" forState:UIControlStateNormal];
            [rightBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
            rightBtn.layer.borderColor = CHJ_RedColor.CGColor;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            rightBtn.layer.cornerRadius = 14;
            rightBtn.clipsToBounds = YES;
            rightBtn.layer.borderWidth = 1;
            [bottomView addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView);
                make.right.mas_equalTo(-18);
                make.size.mas_equalTo(CGSizeMake(74, 27));
            }];
            
            [cancleBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [cancleBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
            cancleBtn.layer.borderColor = RGBS(221).CGColor;
            cancleBtn.layer.cornerRadius = 14;
            cancleBtn.clipsToBounds = YES;
            cancleBtn.layer.borderWidth = 1;
            [cancleBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancleBtn];
            [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomView);
                make.right.mas_equalTo(rightBtn.mas_left).mas_offset(-10);
                make.size.mas_equalTo(rightBtn);
            }];
        }else if (self.infoModel.PaymentType.integerValue == 2){//结清-什么按钮都没有
            bottomView.hidden = YES;
        }
        
    }else if (self.PaymentStatus.integerValue == 1 || self.PaymentStatus.integerValue == 2 || self.PaymentStatus.integerValue == 3 || self.PaymentStatus.integerValue == 6) {//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单 --- 有删除按钮(交易结束/同意退款)- 19-02-19郝
        [cancleBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        cancleBtn.layer.cornerRadius = 14;
        cancleBtn.clipsToBounds = YES;
        cancleBtn.layer.borderColor = RGBS(221).CGColor;
        cancleBtn.layer.borderWidth = 1;
        [bottomView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.right.mas_equalTo(-18);
            make.size.mas_equalTo(CGSizeMake(74, 27));
        }];
    }else if (self.PaymentStatus.integerValue == 4 || self.PaymentStatus.integerValue == 5){//0未支付,1已支付(交易全部完成),2已失效,3同意退款,4拒绝退款,5退款审核,6拒单 -- 无删除按钮
        bottomView.hidden = YES;
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

#pragma mark - 渐变色Image
- (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case 0://纵向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1://横向渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
        default:
            start = CGPointZero;
            end = CGPointZero;
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPHYTHOrderDetailOrderInfoCell *cell = [YPHYTHOrderDetailOrderInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *bgimgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        bgimgv.image = [self gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 75) andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1];
        cell.backgroundColor = [UIColor colorWithPatternImage:bgimgv.image];
        
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (self.infoModel.CommodityName.length > 0) {
            cell.tehui.text = self.infoModel.CommodityName;
        }else{
            cell.tehui.text = @"无名称";
        }
        cell.canbiao.text = [NSString stringWithFormat:@"¥%@/桌起",self.infoModel.MealAmount];
        cell.zhuoshu.text = [NSString stringWithFormat:@"%@桌",self.infoModel.TableNumber];
        if (self.infoModel.HotelName.length > 0) {
            cell.jiudian.text = self.infoModel.HotelName;
        }else{
            cell.jiudian.text = @"无名称";
        }
        cell.timeLabel.text = self.infoModel.ServiceTime;
        cell.banquetName.text = self.infoModel.CommodityName;
        cell.yongcanRenLabel.text = self.infoModel.PeopleName;
        cell.mobileLabel.text = self.infoModel.Phone;
        cell.timeYongCanLabel.text = @"--";
       
        return cell;
    }else if (indexPath.section == 1){
        
        YPHYTHOrderDetailOrderPriceInfoCell *cell = [YPHYTHOrderDetailOrderPriceInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sumLabel.text = [NSString stringWithFormat:@"¥ %.1f",self.infoModel.TableNumber.floatValue*self.infoModel.MealAmount.floatValue];//19-01-11 未优惠前的金额 桌数*餐标 郝
        cell.serviceLabel.text = [NSString stringWithFormat:@"+¥ %@",self.infoModel.ServiceCharge];
        cell.reduceLabel.text = [NSString stringWithFormat:@"-¥ %@",self.infoModel.ReductionAmount];
        cell.realLabel.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.TotalOrders];//支付总额 19-02-20 徐
        cell.restLabel.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.PaidAmount];
        cell.handselLabel.text = [NSString stringWithFormat:@"¥ %@",self.infoModel.Earnestmoney];//定金
        return cell;
    }else{
        YPHYTHOrderDetailNormalInfoCell *cell = [YPHYTHOrderDetailNormalInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.descLabel.text = self.infoModel.CreateTime;
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

- (void)rightBtnClick:(UIButton *)sender{
    NSLog(@"rightBtnClick");
    if ([sender.titleLabel.text isEqualToString:@"付款"]) {
        
        //19-02-19 直接支付
        [self paymentFirstRequestWithRecordID:self.detailID];
        
//        YPHYTHOrderPayController *pay = [[YPHYTHOrderPayController alloc]init];
//        pay.recordID = self.infoModel.Id;
//        [self.navigationController pushViewController:pay animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"申请退款"]){
        YPHYTHRefundController *refund = [[YPHYTHRefundController alloc]init];
        refund.Id = self.infoModel.Id;
        refund.Name = self.infoModel.CommodityName;
        refund.TableNumber = self.infoModel.TableNumber;
        refund.MealAmount = self.infoModel.MealAmount;
        refund.PaymentAmount = self.infoModel.PaymentAmount;//传支付金额 - 19-01-14徐
        refund.CoverMap = self.infoModel.CoverMap;
        [self.navigationController pushViewController:refund animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"结清尾款"]){
        [[UIApplication sharedApplication].keyWindow addSubview:self.control];
    }
}

- (void)cancleBtnClick{
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
    [self UpdateTailMoneyWithID:self.detailID AndPrice:self.restTF.text];
}

#pragma mark - 网络请求
#pragma mark 获取订单详情
- (void)GetPreferentialOrderDetailsInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetPreferentialOrderDetailsInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.detailID;
    
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

#pragma mark 删除订单
- (void)DeletePreferentialOrder{
    
    NSString *url = @"/api/HQOAApi/DeletePreferentialOrder";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = self.infoModel.Id;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            if (self.infoModel.PaymentType.integerValue == 0 || self.infoModel.PaymentType.integerValue == 1) {//0待定,1定金,2结清,3全款
                [EasyShowTextView showText:@"取消成功!" inView:self.tableView];
            }else if (self.infoModel.PaymentType.integerValue == 2 || self.infoModel.PaymentType.integerValue == 3) {//0待定,1定金,2结清,3全款
                [EasyShowTextView showText:@"删除成功!" inView:self.tableView];
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
        suc.recordID = self.detailID;
        [self.navigationController pushViewController:suc animated:YES];
    } else {
        [EasyShowTextView showErrorText:@"支付失败" inView:self.tableView];
    }
}

-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialOrderDetailsInfo];
    }];
    
}

#pragma mark - getter
- (YPGetPreferentialOrderDetailsInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetPreferentialOrderDetailsInfo alloc]init];
    }
    return _infoModel;
}

- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
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
