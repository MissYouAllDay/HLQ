//
//  YPArrangeNewAddDetailController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/17.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeNewAddDetailController.h"
#import "YPArrangeNewAddDetailIconCell.h"
#import "YPArrangeNewAddInfoCell.h"
#import "YPTextNormalCell.h"
#import "YPGetSupplierrOrderInfo.h"
#import "YPGetSupplierrOrderInfoData.h"

@interface YPArrangeNewAddDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetSupplierrOrderInfo *orderInfo;
@property (nonatomic, strong) NSMutableArray<YPGetSupplierrOrderInfoData *> *liuchengMarr;

@end

@implementation YPArrangeNewAddDetailController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
    
    [self GetSupplierrOrderInfo];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
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
    titleLab.text = @"安排详情";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
 
    
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    //iOS.11 修改
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    UIButton *refuse = [UIButton buttonWithType:UIButtonTypeCustom];
    [refuse setTitle:@"拒绝" forState:UIControlStateNormal];
    [refuse setTitleColor:GrayColor forState:UIControlStateNormal];
    [refuse addTarget:self action:@selector(refuseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:refuse];
    [refuse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(view);
        make.width.mas_equalTo(ScreenWidth/2.0);
    }];
    UIButton *accept = [UIButton buttonWithType:UIButtonTypeCustom];
    [accept setTitle:@"接受" forState:UIControlStateNormal];
    [accept setTitleColor:WhiteColor forState:UIControlStateNormal];
    [accept setBackgroundColor:NavBarColor];
    [accept addTarget:self action:@selector(acceptBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:accept];
    [accept mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(view);
        make.width.mas_equalTo(ScreenWidth/2.0);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 2;
    }else{
        return self.liuchengMarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPArrangeNewAddDetailIconCell *cell = [YPArrangeNewAddDetailIconCell cellWithTableView:tableView];
            
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.corpLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
            cell.titleLabel.text = self.corpName;
            cell.nameLabel.text = self.corpPhone;
            cell.phone.hidden = YES;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            YPArrangeNewAddInfoCell *cell = [YPArrangeNewAddInfoCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.manTitle.text = @"新郎";
            cell.womanTitle.text = @"新娘";
            NSArray *groomArr = [self.orderInfo.Groom componentsSeparatedByString:@","];
            NSArray *brideArr = [self.orderInfo.Bride componentsSeparatedByString:@","];
            cell.manName.text = groomArr[0];
            cell.womanName.text = brideArr[0];
            cell.manPhone.text = groomArr[1];
            cell.womanPhone.text = brideArr[1];
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            YPArrangeNewAddInfoCell *cell = [YPArrangeNewAddInfoCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.manTitle.text = @"酒店";
            cell.womanTitle.text = @"大厅";
            if (self.orderInfo.RummeryName.length > 0) {
                cell.manName.text = self.orderInfo.RummeryName;
            }else{
                cell.manName.text = @"未添加";
            }
            
            if (self.orderInfo.BanquetHallName.length > 0) {
                cell.womanName.text = self.orderInfo.BanquetHallName;
            }else{
                cell.womanName.text = @"未添加";
            }
            cell.manPhone.hidden = YES;
            cell.womanPhone.hidden = YES;
            return cell;
        }else if (indexPath.row == 1) {
            YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @"地址";
            if (self.orderInfo.RummeryAddress.length > 0) {
                cell.content.text = self.orderInfo.RummeryAddress;
            }else{
                cell.content.text = @"未添加";
            }
            return cell;
        }
    }else if (indexPath.section == 2) {
        
        YPGetSupplierrOrderInfoData *data = self.liuchengMarr[indexPath.section - 2];
        
        YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = [NSString stringWithFormat:@"%@-%@",data.BeginTime,data.EndTime];
        cell.content.text = data.Content;
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.corpPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)refuseBtnClick{
    NSLog(@"refuseBtnClick");
    //MMSheetView
    NSArray *items =
    @[MMItemMake(@"确定", MMItemTypeNormal, ^(NSInteger index) {
        NSLog(@"确定 -- %zd",index);
        
        [self SupplierOrderReviewWithOrderID:self.supplierOrderID AndType:@"2"];//1、同意 2、拒绝
    }),];
    
    [[[MMSheetView alloc] initWithTitle:@"确定拒绝此次安排?"
                                  items:items] showWithBlock:nil];
}

- (void)acceptBtnClick{
    NSLog(@"acceptBtnClick");
    
    [self SupplierOrderReviewWithOrderID:self.supplierOrderID AndType:@"1"];//1、同意 2、拒绝
}

#pragma mark - 网络请求
#pragma mark 获取订单安排详细
- (void)GetSupplierrOrderInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSupplierrOrderInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ObjectType"] = @"1";//1、供应商订单 2、新人安排
    params[@"ObjectID"] = self.supplierOrderID;//供应商订单ID、客户ID
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"%@",object);
            
            self.orderInfo.Groom = [object valueForKey:@"Groom"];
            self.orderInfo.Bride = [object valueForKey:@"Bride"];
            self.orderInfo.RummeryName = [object valueForKey:@"RummeryName"];
            self.orderInfo.BanquetHallName = [object valueForKey:@"BanquetHallName"];
            self.orderInfo.RummeryAddress = [object valueForKey:@"RummeryAddress"];
            self.orderInfo.ScheduleID = [object valueForKey:@"ScheduleID"];
            
            self.liuchengMarr = [YPGetSupplierrOrderInfoData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
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
            if (self.doneBlock) {
                self.doneBlock(@"完成");
            }
            [self.navigationController popViewControllerAnimated:YES];
            
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
- (YPGetSupplierrOrderInfo *)orderInfo{
    if (!_orderInfo) {
        _orderInfo = [[YPGetSupplierrOrderInfo alloc]init];
    }
    return _orderInfo;
}

- (NSMutableArray<YPGetSupplierrOrderInfoData *> *)liuchengMarr{
    if (!_liuchengMarr) {
        _liuchengMarr = [NSMutableArray array];
    }
    return _liuchengMarr;
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
