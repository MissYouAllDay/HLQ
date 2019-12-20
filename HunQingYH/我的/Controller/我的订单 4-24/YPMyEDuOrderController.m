//
//  YPMyEDuOrderController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyEDuOrderController.h"
#import "YPMyEDuOrderGoodCell.h"
#import "YPMyEDuOrderHeaderCell.h"
#import "YPGetShoppingOrderList.h"
#import "YPEDuGoodDetailController.h"//详情
#import "YPMyEDuOrderInfoCell.h"

@interface YPMyEDuOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetShoppingOrderList *> *listMarr;

@end

@implementation YPMyEDuOrderController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetShoppingOrderList];
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
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我的订单";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ClearColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
//    [self noDataView];
}

- (void)noDataView{
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopCart"]];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"您还没有订单哦, 再去逛逛吧";
    label.textColor = GrayColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgV.mas_bottom).mas_offset(50);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMarr.count == 0 ? self.listMarr.count : self.listMarr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.listMarr.count == indexPath.row) {
        
        YPGetShoppingOrderList *listModel = self.listMarr[0];
        
        YPMyEDuOrderInfoCell *cell = [YPMyEDuOrderInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (listModel.Consignee.length > 0) {
            cell.titleLabel.text = listModel.Consignee;
        }else{
            cell.titleLabel.text = @"无姓名";
        }
        if (listModel.ConsigneePhone.length > 0) {
            cell.phoneLabel.text = listModel.ConsigneePhone;
        }else{
            cell.phoneLabel.text = @"无手机号";
        }
        if (listModel.Address.length > 0) {
            cell.address.text = listModel.Address;
        }else{
            cell.address.text = @"无地址";
        }
        
        return cell;
        
    }else{
        
        YPGetShoppingOrderList *listModel = self.listMarr[indexPath.row];
        
        YPMyEDuOrderGoodCell *cell = [YPMyEDuOrderGoodCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:listModel.BriefIntroduction] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (listModel.CommodityName.length > 0) {
            cell.nameLabel.text = listModel.CommodityName;
        }else{
            cell.nameLabel.text = @"无名称";
        }
        if (listModel.CategoryGoodsName.length > 0 || listModel.PlaceOriginName.length > 0) {
            cell.descLabel.text = [NSString stringWithFormat:@"类别: %@  型号: %@",listModel.CategoryGoodsName,listModel.PlaceOriginName];
        } else if (listModel.CategoryGoodsName.length == 0 && listModel.PlaceOriginName.length > 0) {
            cell.descLabel.text = [NSString stringWithFormat:@"类别: 无  型号: %@",listModel.PlaceOriginName];
        } else if (listModel.CategoryGoodsName.length > 0 || listModel.PlaceOriginName.length == 0) {
            cell.descLabel.text = [NSString stringWithFormat:@"类别: %@  型号: 无",listModel.CategoryGoodsName];
        }else{
            cell.descLabel.text = @"类别: 无  型号: 无";
        }
        cell.countLabel.text = [NSString stringWithFormat:@"x %zd",[listModel.Count integerValue]];
        return cell;
    }

}

// 重新绘制cell边框
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        // if (tableView == self.tableView) {
        
        CGFloat cornerRadius = 10.f;
        
        cell.backgroundColor = ClearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
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
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            
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
    if (section == 0) {
        return 200;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"温馨提示";
    label.textColor = RGBA(51, 51, 51, 1);
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(50);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"平台担保礼品均是正品，愿承担相应责任！您将在1个月内收到礼品（因从国外正品渠道采购，会有延迟，详情请咨询：400-6277-086，或拨打7*24小时客服热线：15192055999同微信）";
    label1.numberOfLines = 0;
    label1.textColor = RGBA(153, 153, 153, 1);
    label1.font = kFont(14);
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(view);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(label.mas_bottom).mas_offset(12);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetShoppingOrderList *listModel = self.listMarr[indexPath.row];
    
    YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
    detail.commodityId = listModel.CommodityId;
  
    detail.willShowCart = NO;//不显示购物车
    
//    detail.ActivityIdType = self.ActivityIdType;//18-09-19
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取订单列表
- (void)GetShoppingOrderList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetShoppingOrderList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    //18-09-17
    if (self.ActivityIdType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_banShouLi;
    }else if (self.ActivityIdType.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_hunLiFanHuan;
    }else if (self.ActivityIdType.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_daiShou;
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetShoppingOrderList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
//            if (self.listMarr.count == 0) {
//                [self showNoDataEmptyView];
//            }else{
//                [self hidenEmptyView];
//            }
            
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

#pragma mark - getter
- (NSMutableArray<YPGetShoppingOrderList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetShoppingOrderList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetShoppingOrderList];
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
