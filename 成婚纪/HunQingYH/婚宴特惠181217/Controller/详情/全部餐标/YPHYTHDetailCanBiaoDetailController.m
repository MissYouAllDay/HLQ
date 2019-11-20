//
//  YPHYTHDetailCanBiaoDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailCanBiaoDetailController.h"
#pragma mark - Cell
#import "YPHYTHDetailCanBiaoDetailTingCell.h"
#import "YPHYTHDetailCanBiaoDetailOrderListCell.h"
#pragma mark - Third
#import "FL_Button.h"
#pragma mark - VC
#import "YPHYTHDetailSubmitOrderController.h"

@interface YPHYTHDetailCanBiaoDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPHYTHDetailCanBiaoDetailController{
    UIView *_navView;
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
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"餐标详情";
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
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
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
    line.backgroundColor = CHJ_bgColor;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bottomView);
        make.height.mas_equalTo(1);
    }];
    
//    UIView *colorView = [[UIView alloc] init];
//    [colorView setFrame:CGRectMake(0,0, ScreenWidth*0.5, 50)];
//    [bottomView addSubview:colorView];
//
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = colorView.bounds;
//    gradient.startPoint = CGPointMake(0, 0.5);
//    gradient.endPoint = CGPointMake(1, 0.5);
//    gradient.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0].CGColor];
//    [colorView.layer addSublayer:gradient];
//
//    FL_Button *phoneBtn = [FL_Button fl_shareButton];
//    [phoneBtn setTitleColor:WhiteColor forState:0];
//    [phoneBtn setTitle:@"免费预约" forState:UIControlStateNormal];
//    phoneBtn.status = FLAlignmentStatusNormal;
//    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    phoneBtn.frame = colorView.frame;
//    [bottomView addSubview:phoneBtn];
    
    //5-29 添加 预约
    UIView *colorView1 = [[UIView alloc] init];
    //    [colorView setFrame:CGRectMake(ScreenWidth/3*2+1,0, ScreenWidth/3, 50)];
    [colorView1 setFrame:CGRectMake(ScreenWidth-138,0, 138, 50)];
    [bottomView addSubview:colorView1];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = colorView1.bounds;
    gradient1.startPoint = CGPointMake(0, 0.5);
    gradient1.endPoint = CGPointMake(1, 0.5);
    gradient1.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView1.layer addSublayer:gradient1];
    
    FL_Button *submitBtn = [FL_Button fl_shareButton];
    [submitBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    
    submitBtn.status = FLAlignmentStatusNormal;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.frame = colorView1.frame;
    [bottomView addSubview:submitBtn];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSArray *arr = [self.canbiaoModel.MenuDetails componentsSeparatedByString:@","];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPHYTHDetailCanBiaoDetailTingCell *cell = [YPHYTHDetailCanBiaoDetailTingCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.canbiaoModel.Name.length > 0) {
            cell.titleLabel.text = self.canbiaoModel.Name;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        cell.priceLabel.text = self.canbiaoModel.Price;
        return cell;
    }else{
        NSArray *arr = [self.canbiaoModel.MenuDetails componentsSeparatedByString:@","];
        
        YPHYTHDetailCanBiaoDetailOrderListCell *cell = [YPHYTHDetailCanBiaoDetailOrderListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.descLabel.text = arr[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 66;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 60;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBS(245);
    if (section == 1) {
        view.backgroundColor = WhiteColor;
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HYTHDetailCanBiaoDetail_bg"]];
        [view addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(36);
            make.top.mas_equalTo(46);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"菜单详情";
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 16];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(imgV);
        }];
        return view;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)phoneBtnClick{
    NSLog(@"phoneBtnClick");
    [self CreatePreferentialCommodityReserve];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    
    YPHYTHDetailSubmitOrderController *submit = [[YPHYTHDetailSubmitOrderController alloc]init];
    submit.listModel = self.canbiaoModel;
    submit.detailID = self.CommodityId;
    NSDate *date = [NSDate dateWithString:self.dateStr format:@"yyyy-MM"];
    submit.canbiaoDate = date;
    submit.canbiaoTime = [NSString stringWithFormat:@"%zd",date.month];
    submit.Discount = self.Discount;
    submit.ServiceChargeProportion = self.ServiceChargeProportion;
    [self.navigationController pushViewController:submit animated:YES];
}

#pragma mark - 网络请求
#pragma mark 特惠商品预定
- (void)CreatePreferentialCommodityReserve{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreatePreferentialCommodityReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CommodityId"] = self.CommodityId;
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showText:@"预约成功!" inView:self.tableView];
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络请求错误,请稍后重试!" inView:self.tableView];
        
    }];
    
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
