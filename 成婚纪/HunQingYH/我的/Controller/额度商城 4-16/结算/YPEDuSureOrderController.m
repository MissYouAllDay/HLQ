//
//  YPEDuSureOrderController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuSureOrderController.h"
#import "YPEDuSureOrderAddressCell.h"
#import "YPEDuTitleCell.h"
#import "YPMyEDuOrderGoodCell.h"
#import "YPEDuAddressListController.h"//地址列表
#import "HRCartModel.h"
#import "YPGetConsigneeInfoList.h"
#import "YPEDuGoodDetailController.h"//详情
#import "YYKit.h"
#import <YYCache.h>
@interface YPEDuSureOrderController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetConsigneeInfoList *> *listMarr;

/** 默认地址/选中地址*/
@property (nonatomic, strong) YPGetConsigneeInfoList *infoModel;

@end

@implementation YPEDuSureOrderController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (self.ActivityIdType.integerValue == 0) {//18-11-12 伴手礼隐藏收货地址
        
    }else{
        [self GetConsigneeInfoList];
    }
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
    titleLab.text = @"确认订单";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    if (iPhoneX) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-60) style:UITableViewStyleGrouped];
    }else{
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = CHJ_bgColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        if (iPhoneX) {
            make.height.mas_equalTo(60);
        }else{
            make.height.mas_equalTo(50);
        }
    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:RGB(250, 60, 60)];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(3);
        if (iPhoneX) {
            make.bottom.mas_equalTo(-10);
        }else{
            make.bottom.mas_equalTo(-3);
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.ActivityIdType.integerValue == 0) {//18-11-12 伴手礼隐藏收货地址
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.ActivityIdType.integerValue == 0) {//18-11-12 伴手礼隐藏收货地址
        return 1 + self.modelArr.count;
    }else{
        if (section == 0) {
            return 1;
        } else {
            return 1 + self.modelArr.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (self.ActivityIdType.integerValue == 0) {//18-11-12 伴手礼隐藏收货地址
            if (indexPath.row == 0) {
                YPEDuTitleCell *cell = [YPEDuTitleCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                
                HRCartModel *cart = self.modelArr[indexPath.row - 1];
                
                YPMyEDuOrderGoodCell *cell = [YPMyEDuOrderGoodCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:cart.BriefIntroduction] placeholderImage:[UIImage imageNamed:@"图片占位"]];
                if (cart.CommodityName.length > 0) {
                    cell.nameLabel.text = cart.CommodityName;
                }else{
                    cell.nameLabel.text = @"无名称";
                }
                if (cart.CategoryGoodsName.length > 0 || cart.PlaceOriginName.length > 0) {
                    cell.descLabel.text = [NSString stringWithFormat:@"类别: %@  型号: %@",cart.CategoryGoodsName,cart.PlaceOriginName];
                } else if (cart.CategoryGoodsName.length == 0 && cart.PlaceOriginName.length > 0) {
                    cell.descLabel.text = [NSString stringWithFormat:@"类别: 无  型号: %@",cart.PlaceOriginName];
                } else if (cart.CategoryGoodsName.length > 0 || cart.PlaceOriginName.length == 0) {
                    cell.descLabel.text = [NSString stringWithFormat:@"类别: %@  型号: 无",cart.CategoryGoodsName];
                }else{
                    cell.descLabel.text = @"类别: 无  型号: 无";
                }
                cell.countLabel.text = [NSString stringWithFormat:@"x %zd",cart.Count];
                return cell;
            }
        }else{
            if (self.infoModel.Id.length > 0) {
                YPEDuSureOrderAddressCell *cell = [YPEDuSureOrderAddressCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.infoModel = self.infoModel;
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.textLabel.text = @"请选择或添加地址";
                cell.textLabel.textColor = GrayColor;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(cell.contentView);
                }];
                return cell;
            }
        }
        
    } else {
        if (indexPath.row == 0) {
            YPEDuTitleCell *cell = [YPEDuTitleCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            
            HRCartModel *cart = self.modelArr[indexPath.row - 1];
            
            YPMyEDuOrderGoodCell *cell = [YPMyEDuOrderGoodCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:cart.BriefIntroduction] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            if (cart.CommodityName.length > 0) {
                cell.nameLabel.text = cart.CommodityName;
            }else{
                cell.nameLabel.text = @"无名称";
            }
            if (cart.CategoryGoodsName.length > 0 || cart.PlaceOriginName.length > 0) {
                cell.descLabel.text = [NSString stringWithFormat:@"类别: %@  型号: %@",cart.CategoryGoodsName,cart.PlaceOriginName];
            } else if (cart.CategoryGoodsName.length == 0 && cart.PlaceOriginName.length > 0) {
                cell.descLabel.text = [NSString stringWithFormat:@"类别: 无  型号: %@",cart.PlaceOriginName];
            } else if (cart.CategoryGoodsName.length > 0 || cart.PlaceOriginName.length == 0) {
                cell.descLabel.text = [NSString stringWithFormat:@"类别: %@  型号: 无",cart.CategoryGoodsName];
            }else{
                cell.descLabel.text = @"类别: 无  型号: 无";
            }
            cell.countLabel.text = [NSString stringWithFormat:@"x %zd",cart.Count];
            return cell;
        }
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
    
    if (indexPath.section == 0) {
        
        if (self.ActivityIdType.integerValue == 0) {//18-11-12 伴手礼隐藏收货地址
            if (indexPath.row == 0) {
                
            }else{
                
                HRCartModel *cart = self.modelArr[indexPath.row - 1];
                
                YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
                detail.commodityId = cart.CommodityId;
                
                detail.willShowCart = YES;//显示购物车
                
                detail.ActivityIdType = self.ActivityIdType;//18-09-19
                
                [self.navigationController pushViewController:detail animated:YES];
                
            }
        }else{
            YPEDuAddressListController *address = [[YPEDuAddressListController alloc]init];
            address.addressBlock = ^(YPGetConsigneeInfoList *infoModel) {
                self.infoModel = infoModel;
            };
            [self.navigationController pushViewController:address animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }else{
            
            HRCartModel *cart = self.modelArr[indexPath.row - 1];
            
            YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
            detail.commodityId = cart.CommodityId;
          
            detail.willShowCart = YES;//显示购物车
            
            detail.ActivityIdType = self.ActivityIdType;//18-09-19
            
            [self.navigationController pushViewController:detail animated:YES];
            
        }
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

#pragma mark - 网络请求
#pragma mark 获取收件人信息列表
- (void)GetConsigneeInfoList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetConsigneeInfoList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetConsigneeInfoList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            for (YPGetConsigneeInfoList *info in self.listMarr) {
                if (info.DefaultAddress == 1) {//0，否；1，是
                    self.infoModel = info;
                }
            }

            [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            
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

#pragma mark 购物车商品提交结算
- (void)PlaceOrder{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/PlaceOrder";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    
    if (self.ActivityIdType.integerValue == 0) {//18-11-12 伴手礼隐藏收货地址
        params[@"AddresseeId"] = @"00000000-0000-0000-0000-000000000000";
    }else{
        params[@"AddresseeId"] = self.infoModel.Id;
    }
    
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
            
            [EasyShowTextView showSuccessText:@"结算成功!" inView:self.tableView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *viewCtl = self.navigationController.viewControllers[2];
                
                [self.navigationController popToViewController:viewCtl animated:YES];
            });
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

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureBtnClick{
    NSLog(@"sure");
    
    if (self.ActivityIdType.intValue == 0) {//0伴手礼,1婚礼返还,2代收
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示：伴手礼内所有可用额度，在本次结算后即全部清零作废，是否结算？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (self.ActivityIdType.intValue == 1){//0伴手礼,1婚礼返还,2代收
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示：婚礼返还内所有可用额度，在本次结算后即全部清零作废，是否结算？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (self.ActivityIdType.intValue == 2){//0伴手礼,1婚礼返还,2代收
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示：代收内所有可用额度，在本次结算后即全部清零作废，是否结算？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self PlaceOrder];
    }
}

#pragma mark - getter
- (NSMutableArray<YPGetConsigneeInfoList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (YPGetConsigneeInfoList *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetConsigneeInfoList alloc]init];
    }
    return _infoModel;
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
