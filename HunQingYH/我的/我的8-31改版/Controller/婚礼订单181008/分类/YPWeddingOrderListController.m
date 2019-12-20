//
//  YPWeddingOrderListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderListController.h"
#import "YPWeddingOrderListHeadCell.h"
#import "YPWeddingOrderListSub1Cell.h"
#import "YPWeddingOrderListSub2Cell.h"
#import "YPGetFacilitatorFlowRecord.h"
#import "YPWeddingOrderRefuseReasonController.h"//拒单原因

@interface YPWeddingOrderListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorFlowRecord *> *listMarr;

@end

@implementation YPWeddingOrderListController{
    NSInteger _pageIndex;
    NSIndexPath *_selectIndex;//查看更多
    BOOL _openState;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetFacilitatorFlowRecord];
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
    
    _pageIndex = 1;
    _openState = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-40) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBA(242, 243, 247, 1);
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
        [self GetFacilitatorFlowRecord];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetFacilitatorFlowRecord];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetFacilitatorFlowRecord *list = self.listMarr[indexPath.section];
    
    if (indexPath.row == 0) {
        YPWeddingOrderListHeadCell *cell = [YPWeddingOrderListHeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.timeLabel.text = list.CreateTime;
        
        if (list.MakeMoney.integerValue == 0) {//1已打款 0未打款
            if (list.MakePayment.integerValue == 0) {//0未支付,1已支付
                cell.tagLabel.text = @"待支付";
                cell.tagLabel.textColor = RGB(250, 80, 120);
            }else if (list.MakePayment.integerValue == 1) {
                cell.tagLabel.text = @"已支付";
                cell.tagLabel.textColor = RGB(250, 80, 120);
            }
        }else if (list.MakeMoney.integerValue == 1) {//1已打款 0未打款 18-10-11 已提现
            cell.tagLabel.text = @"已提现";
            cell.tagLabel.textColor = RGB(250, 80, 120);
        }
        
        return cell;
    }else if (indexPath.row == 1){
        YPWeddingOrderListSub1Cell *cell = [YPWeddingOrderListSub1Cell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (list.UserName.length > 0) {
            cell.tiitleLabel.text = list.UserName;
        }else{
            cell.tiitleLabel.text = @"无名称";
        }
        if (list.Phone.length > 0) {
            cell.phoenLabel.text = list.Phone;
        }else{
            cell.phoenLabel.text = @"无手机号";
        }
        if (list.Type.integerValue == 0) {//0未审核,1已审核,2已驳回
            cell.tagLabel.text = @"待审核";
            cell.refuseBtn.hidden = YES;
        }else if (list.Type.integerValue == 1){//0未审核,1已审核,2已驳回
            cell.tagLabel.text = @"已审核";
            cell.refuseBtn.hidden = YES;
        }else if (list.Type.integerValue == 2){//0未审核,1已审核,2已驳回
            cell.tagLabel.text = @"已驳回";
            cell.refuseBtn.hidden = NO;
            cell.refuseBtn.tag = indexPath.section + 1000;
            [cell.refuseBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else {
        
        if (_selectIndex.section == indexPath.section) {
            if (_openState) {
                YPWeddingOrderListSub2Cell *cell = [YPWeddingOrderListSub2Cell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.priceLabel.text = [NSString stringWithFormat:@"%@ 元",list.Money];
                if (list.ActivityType.integerValue == 0) {//0伴手礼,1代收,2婚礼返还
                    if (list.PaymentType.integerValue == 0) {//0线上,1线下
                        cell.sourceLabel.text = @"伴手礼 - 线上订单";
                    }else if (list.PaymentType.integerValue == 1){
                        cell.sourceLabel.text = @"伴手礼 - 线下订单";
                    }
                }else if (list.ActivityType.integerValue == 1){//0伴手礼,1代收,2婚礼返还
                    if (list.PaymentType.integerValue == 0) {//0线上,1线下
                        cell.sourceLabel.text = @"代收 - 线上订单";
                    }else if (list.PaymentType.integerValue == 1){
                        cell.sourceLabel.text = @"代收 - 线下订单";
                    }
                }else if (list.ActivityType.integerValue == 2){//0伴手礼,1代收,2婚礼返还
                    //18-11-13 婚礼返还只有线上 - 徐
                    cell.sourceLabel.text = @"婚礼返还 - 线上订单";
                }
                if (list.DistributionFacilitatorName.length > 0) {
                    cell.guanlianLabel.text = list.DistributionFacilitatorName;
                }else{
//                    cell.guanlianLabel.text = @"无关联商家";
                    cell.guanlianLabel.text = @"婚礼桥平台";
                }
                if (list.WeddingDate.length > 0) {
                    cell.wedDateLabel.text = list.WeddingDate;
                }else{
                    cell.wedDateLabel.text = @"无日期";
                }
                if (list.SinglePersonPhone.length > 0) {
                    cell.jiedanPhone.text = list.SinglePersonPhone;
                }else{
                    cell.jiedanPhone.text = @"无手机号";
                }
                cell.closeBtn.enabled = NO;
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *label = [[UILabel alloc]init];
                label.text = @"查看更多";
                label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
                label.textColor = [UIColor colorWithRed:250/255.0 green:80/255.0 blue:120/255.0 alpha:1];
                [cell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(cell.contentView);
                }];
                return cell;
            }
                
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label = [[UILabel alloc]init];
            label.text = @"查看更多";
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
            label.textColor = [UIColor colorWithRed:250/255.0 green:80/255.0 blue:120/255.0 alpha:1];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(cell.contentView);
            }];
            return cell;
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
    
    if (indexPath.row == 2) {
        if (_selectIndex == indexPath) {
            if (_openState) {
                _openState = NO;
            }else{
                _selectIndex = indexPath;
                _openState = YES;
            }
        }else{
            _selectIndex = indexPath;
            _openState = YES;
        }
//        [self.tableView reloadRow:2 inSection:_selectIndex.section withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.listMarr.count)] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

#pragma mark - target
///删除
- (void)deleteBtnClick:(UIButton *)sender{
    NSLog(@"拒单原因 --- %zd",sender.tag);
    
    YPGetFacilitatorFlowRecord *record = self.listMarr[sender.tag - 1000];
    NSLog(@"%@",record.DismissReason);
    YPWeddingOrderRefuseReasonController *refuse = [[YPWeddingOrderRefuseReasonController alloc]init];
    refuse.ruleStr = record.DismissReason;
    [self.navigationController pushViewController:refuse animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取服务商活动流水列表
- (void)GetFacilitatorFlowRecord{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorFlowRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"Type"] = @"0";//0所有,1线上,2线下
    
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] =  @"10";
    
    params[@"ActivityType"] =  @"3";//0伴手礼,1代收,2婚礼返还,3伴手礼和代收
    params[@"UserNamePhone"] =  @"";
    //0全部,1待支付,2已支付,3已打款
    if ([self.typeStr isEqualToString:@"全部"]) {
        params[@"PayType"] = @"0";//0全部,1待支付,2已支付,3已打款
    }else if ([self.typeStr isEqualToString:@"待支付"]){
        params[@"PayType"] = @"1";//0全部,1待支付,2已支付,3已打款
    }else if ([self.typeStr isEqualToString:@"已支付"]){
        params[@"PayType"] = @"2";//0全部,1待支付,2已支付,3已打款
    }else if ([self.typeStr isEqualToString:@"已提现"]){//18-10-11 已提现
        params[@"PayType"] = @"3";//0全部,1待支付,2已支付,3已打款
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {

                [self.listMarr removeAllObjects];

                self.listMarr = [YPGetFacilitatorFlowRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

            }else{
                NSArray *newArray = [YPGetFacilitatorFlowRecord mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

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
        
    }];
    
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetFacilitatorFlowRecord];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetFacilitatorFlowRecord];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorFlowRecord *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
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
