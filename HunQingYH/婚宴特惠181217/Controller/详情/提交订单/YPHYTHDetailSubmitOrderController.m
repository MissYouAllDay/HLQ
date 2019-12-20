//
//  YPHYTHDetailSubmitOrderController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailSubmitOrderController.h"
#import "YPHYTHDetailSubmitOrderBtnCell.h"
#import "YPHYTHDetailSubmitOrderLabelCell.h"
#import "BRDatePickerView.h"
#import "FGNumberStepper.h"
#import "YPGetPreferentialCommodityPriceList.h"
#import "YPHYTHDetailSubmitOrderTingCell.h"
#import "YPHYTHDetailCanBiaoDetailController.h"
#import "YPHYTHDetailSubmitOrderShowPriceCell.h"

@interface YPHYTHDetailSubmitOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *dateStr;

//@property (nonatomic, assign) NSInteger currentIndex;
/**当前桌数*/
@property (nonatomic, assign) NSInteger currentTableNum;
/**餐标*/
@property (nonatomic, copy) NSString *canbiao;
/** 餐标*桌数 */
@property (nonatomic, assign) CGFloat sumPrice;
/** 总计(服务费加立返金额) */
@property (nonatomic, assign) CGFloat realSumPrice;

@property (nonatomic, strong) NSMutableArray<YPGetPreferentialCommodityPriceList *> *canbiaoMarr;

@end

@implementation YPHYTHDetailSubmitOrderController{
    UIView *_navView;
    __block UILabel *_sumLabel;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [self GetPreferentialCommodityPriceList];
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
    self.view.backgroundColor = WhiteColor;
    
    self.dateStr = [NSString stringWithFormat:@"  %zd年 %zd月 %zd日  ",self.canbiaoDate.year,self.canbiaoDate.month,self.canbiaoDate.day];
    
    self.currentTableNum = 1;
    self.canbiao = self.listModel.Price;
    self.sumPrice = self.currentTableNum*(self.canbiao.floatValue);
    self.realSumPrice = self.sumPrice+self.sumPrice*self.ServiceChargeProportion.floatValue*0.01-self.sumPrice*self.Discount.floatValue*0.01;
    
    [self setupNav];
    [self setupUI];
    
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    titleLab.text = @"选择餐标及日期人数";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self createBottomView];
}

- (void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-HOME_INDICATOR_HEIGHT, ScreenWidth,50)];
    bottomView.backgroundColor = WhiteColor;
    [self.view addSubview:bottomView];

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = RGBS(230);
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(bottomView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"实付定金";
    label1.font = kFont(12);
    label1.textColor = RGBS(102);
    [bottomView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(bottomView);
    }];
    
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc]init];
    }
    _sumLabel.text = [NSString stringWithFormat:@"¥%.2f",[self.listModel.Earnestmoney floatValue]];
    _sumLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 20];
    _sumLabel.textColor = [UIColor colorWithRed:235/255.0 green:92/255.0 blue:75/255.0 alpha:1.0];
    [bottomView addSubview:_sumLabel];
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).mas_offset(12);
        make.centerY.mas_equalTo(label1);
    }];
    
    UIView *colorView = [[UIView alloc] init];
    //    [colorView setFrame:CGRectMake(ScreenWidth/3*2+1,0, ScreenWidth/3, 50)];
    [colorView setFrame:CGRectMake(ScreenWidth*(1-0.368),0, ScreenWidth*0.368, 50)];
    [bottomView addSubview:colorView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView.layer addSublayer:gradient];
    
    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.frame = colorView.frame;
    [bottomView addSubview:submitBtn];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        YPHYTHDetailSubmitOrderTingCell *cell = [YPHYTHDetailSubmitOrderTingCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.listModel.Name;
        cell.priceLabel.text = self.listModel.Price;
        cell.monthLabel.text = @"";
//        cell.monthLabel.text = [NSString stringWithFormat:@"当前为%@月份餐标",self.canbiaoTime];
        [cell.detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1) {
        
        YPHYTHDetailSubmitOrderBtnCell *cell = [YPHYTHDetailSubmitOrderBtnCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.btn setTitle:self.dateStr forState:UIControlStateNormal];
        [cell.btn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(160);
        }];
        return cell;
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            __weak typeof(self) weakSelf = self;
            FGNumberStepper *setpper = [[FGNumberStepper alloc] initWithNumber:1 minmualNumber:1 changeAction:^(FGNumberStepper *s, NSInteger number) {
                weakSelf.currentTableNum = number;
                weakSelf.sumPrice = weakSelf.currentTableNum*(weakSelf.canbiao.floatValue);
//                _sumLabel.text = [NSString stringWithFormat:@"¥%.1f",weakSelf.sumPrice+weakSelf.sumPrice*weakSelf.ServiceChargeProportion.floatValue*0.01-weakSelf.sumPrice*weakSelf.Discount.floatValue*0.01];
                weakSelf.realSumPrice = weakSelf.sumPrice+weakSelf.sumPrice*weakSelf.ServiceChargeProportion.floatValue*0.01-weakSelf.sumPrice*weakSelf.Discount.floatValue*0.01;
                [weakSelf.tableView reloadRow:1 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
                [weakSelf.tableView reloadRow:2 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
                [weakSelf.tableView reloadRow:3 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
                [weakSelf.tableView reloadRow:4 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
            }];
            setpper.canInput = YES;
            setpper.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 13];
            setpper.frame = CGRectMake(18, 0, 122, 37);
            [cell.contentView addSubview:setpper];
            return cell;
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            YPHYTHDetailSubmitOrderLabelCell *cell = [YPHYTHDetailSubmitOrderLabelCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.titleLabel.text = @"服务费:";
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%.1f",self.sumPrice*self.ServiceChargeProportion.floatValue*0.01];
                cell.tagLabel.text = [NSString stringWithFormat:@"总消费金额的%@%%",self.ServiceChargeProportion];
                cell.tagLabel.hidden = NO;
            }else if (indexPath.row == 2){
                cell.titleLabel.text = @"立返金额:";
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%.1f",self.sumPrice*self.Discount.floatValue*0.01];
                cell.tagLabel.hidden = YES;
            }else if (indexPath.row == 3){
                cell.titleLabel.text = @"订单总额:";
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%.1f",self.realSumPrice];
                cell.tagLabel.hidden = YES;
            }
            return cell;
        }else{
            YPHYTHDetailSubmitOrderShowPriceCell *cell = [YPHYTHDetailSubmitOrderShowPriceCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dingjin.text = [NSString stringWithFormat:@"¥%.1f",self.listModel.Earnestmoney.floatValue];
            cell.weikuan.text = [NSString stringWithFormat:@"¥%.1f",self.realSumPrice - self.listModel.Earnestmoney.floatValue];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1) {
        return 50;
    }else{
        if (indexPath.row == 0) {
            return 50;
        }else if (indexPath.row == 4){
            return 140;
        }
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UILabel *label = [[UILabel alloc]init];
    if (section == 0) {
        label.text = @"餐标";
    }else if (section == 1){
        label.text = @"婚宴时间";
    }else if (section == 2){
        label.text = @"桌数";
    }
    
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 18];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(view);
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)btnClick:(UIButton *)sender{
//    NSLog(@"btnClick:");
//
//    self.currentIndex = sender.tag-1000;
//
//    YPGetPreferentialCommodityPriceList *list = self.canbiaoMarr[self.currentIndex];
//    self.canbiao = list.Price;
//    self.sumPrice = self.currentTableNum*(list.Price.floatValue);
//    _sumLabel.text = [NSString stringWithFormat:@"¥%.1f",self.sumPrice+self.sumPrice*self.ServiceChargeProportion.floatValue*0.01-self.sumPrice*self.Discount.floatValue*0.01];
//    _realSumPrice = self.sumPrice+self.sumPrice*self.ServiceChargeProportion.floatValue*0.01-self.sumPrice*self.Discount.floatValue*0.01;
//    [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadRow:1 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadRow:2 inSection:2 withRowAnimation:UITableViewRowAnimationNone];
//}

- (void)dateBtnClick{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"如果您要修改月份,请重新选择餐标" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        NSString *str = [dateFormatter stringFromDate:self.canbiaoDate];
        NSArray *arr = [self getMonthFirstAndLastDayWith:str];
        NSString *selecStr = [self.dateStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        selecStr = [selecStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        selecStr = [selecStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
        [BRDatePickerView showDatePickerWithTitle:@"选择婚宴日期" dateType:BRDatePickerModeDate defaultSelValue:selecStr minDate:[NSDate dateWithString:str format:@"yyyy-MM-dd"] maxDate:[NSDate dateWithString:arr[1] format:@"yyyy-MM-dd"] isAutoSelect:YES themeColor:CHJ_RedColor resultBlock:^(NSString *selectValue) {
            NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
            self.dateStr = [NSString stringWithFormat:@"  %@年 %@月 %@日  ",arr[0],arr[1],arr[2]];
            [self.tableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstString, lastString];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
//    if (_realSumPrice > 0) {
//        [self CreatePreferentialOrderTable];
//    }else{
//        [EasyShowTextView showText:@"请选择餐标和桌数" inView:self.tableView];
//    }
    [self CreatePreferentialOrderTable];
}

- (void)detailBtnClick{
    YPHYTHDetailCanBiaoDetailController *detail = [[YPHYTHDetailCanBiaoDetailController alloc]init];
    detail.canbiaoModel = self.listModel;
    detail.dateStr = self.dateStr;
    detail.CommodityId = self.detailID;
    detail.Discount = self.Discount;
    detail.ServiceChargeProportion = self.ServiceChargeProportion;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 网络请求
#pragma mark 提交订单
- (void)CreatePreferentialOrderTable{
    
//    NSString *url = @"/api/HQOAApi/CreatePreferentialOrderTable";
    
    NSString *url = @"/api/HQOAApi/CreateBanquetOrderTable";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"ReserveId"] = self.detailID;
//    params[@"MealAmount"] = self.canbiao;
//    NSString *str = [self.dateStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    params[@"ServiceTime"] = str3;
//    params[@"TableNumber"] = [NSString stringWithFormat:@"%zd",self.currentTableNum];
//    params[@"CommodityId"] = self.detailID;
    
    //19-01-15 去掉
//    params[@"ServiceCharge"] = [NSString stringWithFormat:@"%.1f",self.sumPrice*self.ServiceChargeProportion.floatValue*0.01];
//    params[@"ReductionAmount"] = [NSString stringWithFormat:@"%.1f",self.sumPrice*self.Discount.floatValue*0.01];
//    params[@"TotalOrders"] = [NSString stringWithFormat:@"%.1f",_realSumPrice];

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"提交订单成功!" inView:self.tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backVC];
            });
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

//#pragma mark 获取特惠商品价格列表
//- (void)GetPreferentialCommodityPriceList{
//
//    [EasyShowLodingView showLoding];
//
//    NSString *url = @"/api/HQOAApi/GetPreferentialCommodityPriceList";
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"CommodityId"] = self.detailID;
//    params[@"Month"] = self.canbiaoTime;
//
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            [self.canbiaoMarr removeAllObjects];
//            self.canbiaoMarr = [YPGetPreferentialCommodityPriceList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
//
//            if (self.canbiaoMarr.count > 0) {
//                YPGetPreferentialCommodityPriceList *list = self.canbiaoMarr[0];
//                self.sumPrice = self.currentTableNum*(list.Price.floatValue);
//                self.canbiao = list.Price;
//                _sumLabel.text = [NSString stringWithFormat:@"¥%.1f",self.sumPrice+self.sumPrice*self.ServiceChargeProportion.floatValue*0.01-self.sumPrice*self.Discount.floatValue*0.01];
//                _realSumPrice = self.sumPrice+self.sumPrice*self.ServiceChargeProportion.floatValue*0.01-self.sumPrice*self.Discount.floatValue*0.01;
//            }else{
//                self.canbiao = @"0";
//            }
//
//            [self.tableView reloadData];
//
//        }else{
//
//            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
//        }
//
//    } Failure:^(NSError *error) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//
//        [self showNetErrorEmptyView];
//
//    }];
//
//}
//
//-(void)showNetErrorEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        [self GetPreferentialCommodityPriceList];
//    }];
//
//}

#pragma mark - getter
- (NSMutableArray<YPGetPreferentialCommodityPriceList *> *)canbiaoMarr{
    if (!_canbiaoMarr) {
        _canbiaoMarr = [NSMutableArray array];
    }
    return _canbiaoMarr;
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
