//
//  YPMyOrderListDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/12.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyOrderListDetailController.h"
#import "YPHotelPayHeadCell.h"
#import "YPMyOrderListGoodCell.h"
#import "YPHotelPayDaiFuFootCell.h"
#import "YPHotelPayYiFuFootCell.h"
#import "YPGetUserShoppingRecord.h"
#import "YPEDuGoodDetailController.h"//商品详情

@interface YPMyOrderListDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetUserShoppingRecord *> *listMarr;

@end

@implementation YPMyOrderListDetailController{
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetUserShoppingRecord];
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
    
    _pageIndex = 1;
    
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetUserShoppingRecord];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetUserShoppingRecord];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    YPGetUserShoppingRecord *record = self.listMarr[section];
    return 3+record.CommodityData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetUserShoppingRecord *record = self.listMarr[indexPath.section];
    
    if (indexPath.row == 0) {
        YPHotelPayHeadCell *cell = [YPHotelPayHeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLab.text = @"下单日期";
        cell.titleLabel.text = record.CreateTime;
        cell.titleLab.textColor = cell.titleLabel.textColor = RGBS(153);
        if (record.IsStatus.integerValue == 0) {//0未审核,1已审核,2审核驳回
            cell.tagLabel.text = @"待审核";
        }else if (record.IsStatus.integerValue == 1){
            cell.tagLabel.text = @"已过审";
        }
        return cell;
    }else {
        
        if (record.CommodityData.count > 0) {

            if (indexPath.row == record.CommodityData.count+2) {//最后一行
                
                YPHotelPayYiFuFootCell *cell = [YPHotelPayYiFuFootCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.deleteBtn.hidden = YES;
//                cell.deleteBtn.tag = indexPath.section + 1000;
//                [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.priceLabel.text = [NSString stringWithFormat:@"¥ %zd",record.Quota.integerValue];
                return cell;
                
            }else if (indexPath.row == record.CommodityData.count+1){//倒数第二行
            
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"订单来源";
                cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
                cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                
                [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(cell.contentView);
                    make.left.mas_equalTo(25);
                }];
                
                UILabel *label = [[UILabel alloc] init];
                if (record.ActivityCategoryName.length > 0) {
                    label.text = record.ActivityCategoryName;
                }else{
                    label.text = @"无";
                }
                label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
                label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(cell.textLabel);
                    make.left.mas_equalTo(cell.textLabel.mas_right).mas_offset(13);
                }];
                
                return cell;
                
            }else{
                
                YPGetUserShoppingRecordCommodityData *data = record.CommodityData[indexPath.row - 1];
                
                YPMyOrderListGoodCell *cell = [YPMyOrderListGoodCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:data.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
                if (data.CommodityName.length > 0) {
                    cell.titleLabel.text = data.CommodityName;
                }else{
                    cell.titleLabel.text = @"无名称";
                }
                if (data.SpecificationModelIdName.length > 0) {
                    cell.typeLabel.text = data.SpecificationModelIdName;
                }else{
                    cell.typeLabel.text = @"无型号";
                }
                
                cell.priceLabel.text = [NSString stringWithFormat:@"¥ %zd",data.Quate.integerValue];
                cell.countLabel.text = [NSString stringWithFormat:@"x %zd",data.Count.integerValue];
                
                return cell;
            }
            
        }else{//没有礼品 直接展示最后两行
            
            if (indexPath.row == 1) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"订单来源";
                cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
                cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                
                [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(cell.contentView);
                    make.left.mas_equalTo(25);
                }];
                
                UILabel *label = [[UILabel alloc] init];
                if (record.ActivityCategoryName.length > 0) {
                    label.text = record.ActivityCategoryName;
                }else{
                    label.text = @"无";
                }
                label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
                label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(cell.textLabel);
                    make.left.mas_equalTo(cell.textLabel.mas_right).mas_offset(13);
                }];
                
                return cell;
            }else{
                YPHotelPayYiFuFootCell *cell = [YPHotelPayYiFuFootCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.deleteBtn.hidden = YES;
//                cell.deleteBtn.tag = indexPath.section + 1000;
//                [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.priceLabel.text = [NSString stringWithFormat:@"¥ %zd",record.Quota.integerValue];
                return cell;
            }
        }

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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetUserShoppingRecord *record = self.listMarr[indexPath.section];
    if (record.CommodityData.count > 0) {
        
        if (indexPath.row == record.CommodityData.count+2) {//最后一行

        }else if (indexPath.row == record.CommodityData.count+1){//倒数第二行
          
        }else if (indexPath.row == 0){//第一行
            
        }else{
            
            YPGetUserShoppingRecordCommodityData *data = record.CommodityData[indexPath.row - 1];
            
            YPEDuGoodDetailController *detail = [[YPEDuGoodDetailController alloc]init];
            detail.commodityId = data.CommodityId;
            detail.willShowCart = NO;//显示购物车
//            detail.ActivityIdType = self.ActivityIdType;//18-09-21 不显示购物车 用不到活动ID
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
    
}

//#pragma mark - target
//- (void)deleteBtnClick:(UIButton *)sender{
//    NSLog(@"delete --- %zd",sender.tag);
//}

#pragma mark - 网络请求
#pragma mark 用户获取购物订单
- (void)GetUserShoppingRecord{
    
     [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetUserShoppingRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    //18-09-19 ---  订单 展示 伴手礼/婚礼返还/代收 全部订单
    params[@"ActivityId"] = @"";//传空查全部
    
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    if ([self.typeStr isEqualToString:@"待审核"]) {
        params[@"Type"] =  @"0";//0未审核,1已审核,2审核驳回
    }else if ([self.typeStr isEqualToString:@"已过审"]){
        params[@"Type"] =  @"1";//0未审核,1已审核,2审核驳回
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                
                self.listMarr = [YPGetUserShoppingRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetUserShoppingRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            
            if (self.listMarr.count > 0) {
                [self hidenEmptyView];
            }else{
                [self showNoDataEmptyView];
            }
            
            [self.tableView reloadData];
            [self endRefresh];
            
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

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - getter
- (NSMutableArray<YPGetUserShoppingRecord *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetUserShoppingRecord];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetUserShoppingRecord];
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
