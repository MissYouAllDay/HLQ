//
//  YPHYTHDetailAllCanBiaoController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/18.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailAllCanBiaoController.h"
#import "YPHYTHDetailAllCanBiaoNavDateView.h"
#import "YPHYTHDetailAllCanBiaoListCell.h"
#import "YPHYTHDetailCanBiaoDetailController.h"//餐标详情
#import "BRDatePickerView.h"
#import "YPGetPreferentialCommodityPriceList.h"
#import "YPHYTHDetailSubmitOrderController.h"//提交订单

@interface YPHYTHDetailAllCanBiaoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) NSMutableArray<YPGetPreferentialCommodityPriceList *> *canbiaoMarr;

@end

@implementation YPHYTHDetailAllCanBiaoController{
    UIView *_navView;
    YPHYTHDetailAllCanBiaoNavDateView *_navDateView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    
    self.currentDate = [NSDate dateWithString:self.dateStr format:@"yyyy-MM"];
    
    [self setupNav];
    [self setupUI];
    
    [self GetPreferentialCommodityPriceList];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBS(245);
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _pageIndex = 1;
//        [self GetWebSupplierList];
//    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _pageIndex ++;
//        [self GetWebSupplierList];
//    }];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:_navView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _navView.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0].CGColor];
    [_navView.layer addSublayer:gradient];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.top.mas_equalTo(10+STATUSBAR_HEIGHT_S);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    if (self.titleStr.length > 0) {
        titleLab.text = self.titleStr;
    }else{
        titleLab.text = @"宴会厅";
    }
    titleLab.textColor = WhiteColor;
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
        make.left.mas_equalTo(backBtn.mas_right).mas_offset(8);
        make.right.mas_equalTo(-8);
    }];
    /*
    if (!_navDateView) {
        _navDateView = [YPHYTHDetailAllCanBiaoNavDateView yp_detailAllCanBiaoNavDateView];
    }
    [_navDateView.preBtn addTarget:self action:@selector(preBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navDateView.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navDateView.dateBtn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _navDateView.dateLabel.text = [NSString stringWithFormat:@"%zd年%zd月",self.currentDate.year,self.currentDate.month];
    [_navView addSubview:_navDateView];
    [_navDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_navView);
        make.height.mas_equalTo(40);
    }];
     */
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.canbiaoMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetPreferentialCommodityPriceList *list = self.canbiaoMarr[indexPath.section];
    
    YPHYTHDetailAllCanBiaoListCell *cell = [YPHYTHDetailAllCanBiaoListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (list.Name.length > 0) {
        cell.titleLabel.text = list.Name;
    }else{
        cell.titleLabel.text = @"无名称";
    }
    cell.priceLabel.text = list.Price;
    cell.yudingBtn.tag = indexPath.section + 1000;
    cell.lookBtn.tag = indexPath.section + 2000;
    [cell.yudingBtn addTarget:self action:@selector(yudingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.lookBtn addTarget:self action:@selector(lookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBS(245);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBS(245);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetPreferentialCommodityPriceList *list = self.canbiaoMarr[indexPath.section];
    
    YPHYTHDetailCanBiaoDetailController *detail = [[YPHYTHDetailCanBiaoDetailController alloc]init];
    detail.canbiaoModel = list;
    detail.dateStr = self.dateStr;
    detail.CommodityId = self.CommodityId;
    detail.Discount = self.Discount;
    detail.ServiceChargeProportion = self.ServiceChargeProportion;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - target
- (void)backVC{
    self.dateBlock([NSString stringWithFormat:@"%zd-%zd",self.currentDate.year,self.currentDate.month]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dateBtnClick{
    NSLog(@"dateBtnClick");
    [BRDatePickerView showDatePickerWithTitle:@"选择婚宴日期" dateType:BRDatePickerModeYM defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
        self.currentDate = [NSDate dateWithString:selectValue format:@"yyyy-MM"];
        _navDateView.dateLabel.text = [NSString stringWithFormat:@"%zd年%zd月",self.currentDate.year,self.currentDate.month];
        [self GetPreferentialCommodityPriceList];
    }];
}

- (void)preBtnClick{
    NSLog(@"preBtnClick");
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:-1];
    self.currentDate = [calendar dateByAddingComponents:lastMonthComps toDate:self.currentDate options:0];
    _navDateView.dateLabel.text = [NSString stringWithFormat:@"%zd年%zd月",self.currentDate.year,self.currentDate.month];
    [self GetPreferentialCommodityPriceList];
}

- (void)nextBtnClick{
    NSLog(@"nextBtnClick");
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:+1];
    self.currentDate = [calendar dateByAddingComponents:lastMonthComps toDate:self.currentDate options:0];
    _navDateView.dateLabel.text = [NSString stringWithFormat:@"%zd年%zd月",self.currentDate.year,self.currentDate.month];
    [self GetPreferentialCommodityPriceList];
}

- (void)yudingBtnClick:(UIButton *)sender{
    
    YPGetPreferentialCommodityPriceList *list = self.canbiaoMarr[sender.tag-1000];
    
    YPHYTHDetailSubmitOrderController *submit = [[YPHYTHDetailSubmitOrderController alloc]init];
    submit.listModel = list;
    submit.detailID = self.CommodityId;
    submit.canbiaoTime = [NSString stringWithFormat:@"%zd",self.currentDate.month];
    submit.canbiaoDate = self.currentDate;
    submit.Discount = self.Discount;
    submit.ServiceChargeProportion = self.ServiceChargeProportion;
    [self.navigationController pushViewController:submit animated:YES];
}

- (void)lookBtnClick:(UIButton *)sender{
    YPGetPreferentialCommodityPriceList *list = self.canbiaoMarr[sender.tag-2000];
    
    YPHYTHDetailCanBiaoDetailController *detail = [[YPHYTHDetailCanBiaoDetailController alloc]init];
    detail.canbiaoModel = list;
    detail.dateStr = self.dateStr;
    detail.CommodityId = self.CommodityId;
    detail.Discount = self.Discount;
    detail.ServiceChargeProportion = self.ServiceChargeProportion;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark 获取特惠商品价格列表
- (void)GetPreferentialCommodityPriceList{
    [EasyShowLodingView showLoding];
    
    //。该接口废弃 2019-10-10 王铭   NSString *url = @"/api/HQOAApi/GetPreferentialCommodityPriceList";
    NSString *url = @"/api/HQOAApi/GetBanquetMealTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CommodityId"] = self.CommodityId;
    params[@"Month"] = [NSString stringWithFormat:@"%zd",self.currentDate.month];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.canbiaoMarr removeAllObjects];
            self.canbiaoMarr = [YPGetPreferentialCommodityPriceList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
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
        [self GetPreferentialCommodityPriceList];
    }];
    
}

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
