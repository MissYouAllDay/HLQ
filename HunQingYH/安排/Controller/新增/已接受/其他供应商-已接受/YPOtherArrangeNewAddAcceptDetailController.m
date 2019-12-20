//
//  YPOtherArrangeNewAddAcceptDetailController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPOtherArrangeNewAddAcceptDetailController.h"
#import "YPArrangeNewAddDetailIconCell.h"
#import "YPArrangeNewAddInfoCell.h"
#import "YPTextNormalCell.h"
#import "YPAddRemarkController.h"//添加备注
#import "YPGetSupplierrOrderInfo.h"
#import "YPGetSupplierrOrderInfoData.h"

@interface YPOtherArrangeNewAddAcceptDetailController ()<UITableViewDelegate,UITableViewDataSource,YPAddRemarkDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) UIButton *addRemarkBtn;

@property (nonatomic, strong) YPGetSupplierrOrderInfo *orderInfo;
@property (nonatomic, strong) NSMutableArray<YPGetSupplierrOrderInfoData *> *liuchengMarr;

@end

@implementation YPOtherArrangeNewAddAcceptDetailController{
    UIView *_navView;
    //避免重复创建
    UIView *view;
    UIButton *deleteBtn;
    UIButton *editBtn;
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
    
    [self setupUI];
    [self setupNav];
    
    [self GetSupplierrOrderInfo];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, ScreenWidth, ScreenHeight-1-NAVIGATION_BAR_HEIGHT-50) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
    
    if (!view) {
        view = [[UIView alloc]init];
    }
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    if (self.remark.length > 0) {
        
        [self.addRemarkBtn removeFromSuperview];
        
        if (!deleteBtn) {
            deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [deleteBtn setTitle:@"删除备注" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:GrayColor forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(view);
            make.width.mas_equalTo(ScreenWidth/2.0);
        }];
        if (!editBtn) {
            editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [editBtn setTitle:@"修改备注" forState:UIControlStateNormal];
        [editBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [editBtn setBackgroundColor:NavBarColor];
        [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:editBtn];
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(view);
            make.width.mas_equalTo(ScreenWidth/2.0);
        }];
        
    }else{
        
        if (!self.addRemarkBtn) {
            self.addRemarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [self.addRemarkBtn setTitle:@"添加备注" forState:UIControlStateNormal];
        [self.addRemarkBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.addRemarkBtn setBackgroundColor:NavBarColor];
        [self.addRemarkBtn addTarget:self action:@selector(addRemarkBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.addRemarkBtn];
        [self.addRemarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(view);
        }];
        
    }
    
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
    titleLab.text = @"档期详情";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
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
        if (self.remark.length > 0) {
            if (self.liuchengMarr.count > 0) {
                return self.liuchengMarr.count + 1;
            }else{
                return 1;
            }
        }else{
            if (self.liuchengMarr.count > 0) {
                return self.liuchengMarr.count;
            }else{
                return 0;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPArrangeNewAddDetailIconCell *cell = [YPArrangeNewAddDetailIconCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.corpLogo]];
            cell.titleLabel.text = self.corpName;
            cell.nameLabel.text = self.corpPhone;
            cell.phone.hidden = YES;
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
                cell.manName.text = @"无";
            }
            
            if (self.orderInfo.BanquetHallName.length > 0) {
                cell.womanName.text = self.orderInfo.BanquetHallName;
            }else{
                cell.womanName.text = @"无";
            }
            cell.manPhone.hidden = YES;
            cell.womanPhone.hidden = YES;
            return cell;
        }else if (indexPath.row == 1) {
            YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.titleLabel.text = @"地址";
            if (self.orderInfo.RummeryAddress.length > 0) {
                cell.content.text = self.orderInfo.RummeryAddress;
            }else{
                cell.content.text = @"无";
            }
            return cell;
        }
    }else if (indexPath.section == 2) {
        
        if (self.liuchengMarr.count > 0) {//有流程
            YPGetSupplierrOrderInfoData *data = self.liuchengMarr[indexPath.section - 2];
            
            YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = [NSString stringWithFormat:@"%@-%@",data.BeginTime,data.EndTime];
            cell.content.text = data.Content;
            
            if (self.remark.length > 0) {
                
                if (indexPath.row == self.liuchengMarr.count) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.titleLabel.text = @"备注";
                    cell.content.text = self.remark;
                }
            }
            
            return cell;
        }else{//无流程 -- 有备注
            
            YPTextNormalCell *cell = [YPTextNormalCell cellWithTableView:tableView];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = @"备注";
            cell.content.text = self.remark;
            
            return cell;
        }
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
    NSLog(@"phoneBtnClick");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.corpPhone]]];
}


- (void)addRemarkBtnClick{
    NSLog(@"addRemarkBtnClick");
    
    YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
    addRemark.remarkDelegate = self;
    addRemark.titleStr = @"添加备注";
    addRemark.placeHolder = @"请添加备注";
    addRemark.limitCount = 60;
    [self.navigationController pushViewController:addRemark animated:YES];
}

- (void)deleteBtnClick{
    NSLog(@"deleteBtnClick");
    
    self.remark = @"";
    [self AddScheduleRemark];
    
}

- (void)editBtnClick{
    NSLog(@"editBtnClick");
    YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
    addRemark.remarkDelegate = self;
    addRemark.editRemark = self.remark;
    addRemark.titleStr = @"添加备注";
    addRemark.placeHolder = @"请添加备注";
    addRemark.limitCount = 60;
    [self.navigationController pushViewController:addRemark animated:YES];
}

#pragma mark - YPAddRemarkDelegate
- (void)addRemark:(NSString *)remark{
    NSLog(@"YPAddRemarkDelegate %@",remark);
    
    self.remark = remark;
    if (remark.length > 0) {
        [self AddScheduleRemark];
    }
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

#pragma mark 供应商档期添加/修改备注
- (void)AddScheduleRemark{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddScheduleRemark";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"SupplierID"] = FacilitatorId_New;
    params[@"ScheduleID"] = self.orderInfo.ScheduleID;//档期ID
    params[@"Remark"] = self.remark;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"操作成功!"];
            
            [self.tableView reloadData];
            [self setupUI];
            
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
