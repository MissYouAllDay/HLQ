//
//  YPNewMarriedAnPaiController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewMarriedAnPaiController.h"
#import "ZJScrollPageViewDelegate.h"
#import "YPNewMarriedAnPaiCell.h"
#import "YPNewMarriedWaitCell.h"
#import "YPGetCustomerInfoDetaill.h"
#import "YPNewMarriedCarCell.h"//婚车 - 车型cell

@interface YPNewMarriedAnPaiController ()<ZJScrollPageViewChildVcDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetCustomerInfoDetaill *customInfo;
@property (nonatomic, strong) NSMutableArray<YPGetCustomerInfoDetaillSuppOrderData *> *orderDataMarr;
@property (nonatomic, strong) NSMutableArray<YPGetCustomerInfoDetaillDriverData *> *driverDataMarr;

@end

@implementation YPNewMarriedAnPaiController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    [self GetCustomerInfoDetaill];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 80;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.orderDataMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YPGetCustomerInfoDetaillSuppOrderData *data = self.orderDataMarr[section];
    
    if ([data.ProfessionName isEqualToString:@"婚车"]) {
        return self.driverDataMarr.count+1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPGetCustomerInfoDetaillSuppOrderData *data = self.orderDataMarr[indexPath.section];
    
    if ([data.ProfessionName isEqualToString:@"婚车"]) {
        if (indexPath.row == 0) {
            YPNewMarriedAnPaiCell *cell = [YPNewMarriedAnPaiCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:data.Logo] placeholderImage:[UIImage imageNamed:@"占位图"]];
            if (data.TrueName.length > 0) {
                cell.titleLabel.text = data.TrueName;
            }else{
                cell.titleLabel.text = @"无";
            }
            if (data.Phone.length > 0) {
                cell.phone.text = data.Phone;
            }else{
                cell.phone.text = @"无";
            }
            
            cell.phoneBtn.tag = indexPath.section + 1000;
            [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else{
            
            YPGetCustomerInfoDetaillDriverData *driverData = self.driverDataMarr[indexPath.row-1];
            
            YPNewMarriedCarCell *cell = [YPNewMarriedCarCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (driverData.Name.length > 0) {
                cell.carNameLabel.text = driverData.Name;
            }else{
                cell.carNameLabel.text = @"无";
            }
            if (driverData.Color.length > 0) {
                cell.colorLabel.text = driverData.Color;
            }else{
                cell.colorLabel.text = @"无";
            }
            if (driverData.ct.length > 0) {
                cell.countLabel.text = [NSString stringWithFormat:@"x%@",driverData.ct];
            }else{
                cell.countLabel.text = @"x0";
            }
            return cell;
        }
    }else{
        YPNewMarriedAnPaiCell *cell = [YPNewMarriedAnPaiCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:data.Logo] placeholderImage:[UIImage imageNamed:@"占位图"]];
        if (data.TrueName.length > 0) {
            cell.titleLabel.text = data.TrueName;
        }else{
            cell.titleLabel.text = @"无";
        }
        if (data.Phone.length > 0) {
            cell.phone.text = data.Phone;
        }else{
            cell.phone.text = @"无";
        }
        
        cell.phoneBtn.tag = indexPath.section + 1000;
        [cell.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 75;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YPGetCustomerInfoDetaillSuppOrderData *data = self.orderDataMarr[section];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    UILabel *label = [[UILabel alloc]init];
    label.textColor = GrayColor;
    
    label.text = data.ProfessionName;
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(10);
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - target
- (void)phoneBtnClick:(UIButton *)sender{
    NSLog(@"phoneBtnClick: -- %zd",sender.tag);
    
    YPGetCustomerInfoDetaillSuppOrderData *data = self.orderDataMarr[sender.tag - 1000];
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",data.Phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - 网络请求
#pragma mark 客户获取婚礼详细信息
- (void)GetCustomerInfoDetaill{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCustomerInfoDetaill";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"CustomerID"] = self.customerID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.orderDataMarr = [YPGetCustomerInfoDetaillSuppOrderData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"SuppOrderData"]];
            
            self.driverDataMarr = [YPGetCustomerInfoDetaillDriverData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"DriverData"]];
            
            [self.tableView reloadData];
            
            if (self.orderDataMarr.count > 0) {
//                self.tableView.tableHeaderView = nil;
                
                [self hidenEmptyView];
                
            }else{
//                [EasyShowTextView showText:@"当前暂无数据!"];
                
                [self showNoDataEmptyView];
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        [self showNetErrorEmptyView];
        
    }];
}

#pragma mark - getter
- (YPGetCustomerInfoDetaill *)customInfo{
    if (!_customInfo) {
        _customInfo = [[YPGetCustomerInfoDetaill alloc]init];
    }
    return _customInfo;
}

- (NSMutableArray<YPGetCustomerInfoDetaillSuppOrderData *> *)orderDataMarr{
    if (!_orderDataMarr) {
        _orderDataMarr = [NSMutableArray array];
    }
    return _orderDataMarr;
}

- (NSMutableArray<YPGetCustomerInfoDetaillDriverData *> *)driverDataMarr{
    if (!_driverDataMarr) {
        _driverDataMarr = [NSMutableArray array];
    }
    return _driverDataMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetCustomerInfoDetaill];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
