//
//  YPMyKeYuan190311DetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/11.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190311DetailController.h"
#import "YPGetJSJTableInfo.h"
#import "YPMyKeYuan190312DetailHeadCell.h"
#import "YPMyKeYuan190312DetailInfoCell.h"
#import "YPMyKeYuan190312DetailXuQiuCell.h"
#import "YPMyKeYuan190312DetailWedInfoCell.h"
#import "YPMyKeYuan190312DetailMoreCell.h"
#import "YPMyKeYuan190312DetailHeadInfoCell.h"
#import "YPMyKeYuan190313DetailEditController.h"
#import <ASGradientLabel.h>
#import "YPAddRemarkController.h"

@interface YPMyKeYuan190311DetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetJSJTableInfo *infoModel;
@property (nonatomic, strong) NSString *remark;

@end

@implementation YPMyKeYuan190311DetailController{
    UIView *_navView;
    UIView *bottomView;
    UIButton *rightBtn;
    UIButton *cancleBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetJSJTableInfo];
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

    [self setupUI];
    [self setupNav];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    titleLab.text = @"客源详情";
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
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self setupBottomView];
}

- (void)setupBottomView{
    if (!bottomView) {
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-HOME_INDICATOR_HEIGHT, ScreenWidth,50)];
    }
    bottomView.backgroundColor = WhiteColor;
    bottomView.hidden = NO;
    [self.view addSubview:bottomView];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bottomView);
        make.height.mas_equalTo(1);
    }];
    
    if (!rightBtn) {
        rightBtn = [[UIButton alloc]init];
    }
    rightBtn.titleLabel.font = kFont(13);
    if (!cancleBtn) {
        cancleBtn = [[UIButton alloc]init];
    }
    cancleBtn.titleLabel.font = kFont(13);
    
    [rightBtn setTitle:@"联系客户" forState:UIControlStateNormal];
    [rightBtn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
    rightBtn.layer.borderColor = CHJ_RedColor.CGColor;
    rightBtn.layer.cornerRadius = 4;
    rightBtn.clipsToBounds = YES;
    rightBtn.layer.borderWidth = 1;
    [rightBtn addTarget:self action:@selector(contactBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_equalTo(-18);
        make.size.mas_equalTo(CGSizeMake(80, 36));
    }];

    [cancleBtn setTitle:@"删除客源" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
    cancleBtn.layer.borderColor = RGBS(221).CGColor;
    cancleBtn.layer.cornerRadius = 4;
    cancleBtn.clipsToBounds = YES;
    cancleBtn.layer.borderWidth = 1;
    [cancleBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_equalTo(rightBtn.mas_left).mas_offset(-10);
        make.size.mas_equalTo(rightBtn);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.infoModel.TouristType.integerValue == 0) {//0待处理,1有意向,2已合作,3已拒单
            return 1;
        }else{
            return 2;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YPMyKeYuan190312DetailHeadCell *cell = [YPMyKeYuan190312DetailHeadCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.infoModel.TouristType.integerValue == 0) {//0待处理,1有意向,2已合作,3已拒单
            cell.titleLabel.text = @"待处理";
        }else if (self.infoModel.TouristType.integerValue == 1) {//0待处理,1有意向,2已合作,3已拒单
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"有意向";
            }else if (indexPath.row == 1){
                YPMyKeYuan190312DetailMoreCell *cell = [YPMyKeYuan190312DetailMoreCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"谈单说明:";
                if (self.infoModel.Explain.length > 0) {
                    cell.descLabel.text = self.infoModel.Explain;
                }else{
                    cell.descLabel.text = @"当前无说明";
                }
                return cell;
            }
        }else if (self.infoModel.TouristType.integerValue == 2) {//0待处理,1有意向,2已合作,3已拒单
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"已合作";
            }else if (indexPath.row == 1){
                YPMyKeYuan190312DetailHeadInfoCell *cell = [YPMyKeYuan190312DetailHeadInfoCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.yufu.text = [NSString stringWithFormat:@"%@¥",self.infoModel.AdvanceEarnest];
                cell.yufuTime.text = [NSString stringWithFormat:@"(%@)",self.infoModel.AdvanceTime];
                cell.chubu.text = [NSString stringWithFormat:@"%@¥",self.infoModel.PreliminaryBudget];
                cell.shiji.text = [NSString stringWithFormat:@"%@¥",self.infoModel.ActualConsumption];
                return cell;
            }
        }else if (self.infoModel.TouristType.integerValue == 3) {//0待处理,1有意向,2已合作,3已拒单
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"已拒单";
            }else if (indexPath.row == 1){
                YPMyKeYuan190312DetailMoreCell *cell = [YPMyKeYuan190312DetailMoreCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"拒单原因:";
                if (self.infoModel.RejectionReasons.length > 0) {
                    cell.descLabel.text = self.infoModel.RejectionReasons;
                }else{
                    cell.descLabel.text = @"当前无原因";
                }
                return cell;
            }
        }
        [cell.editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1){
        YPMyKeYuan190312DetailInfoCell *cell = [YPMyKeYuan190312DetailInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.Headportrait] placeholderImage:[UIImage imageNamed:@"mykeyuan_icon"]];
        if (self.infoModel.Name.length > 0) {
            cell.titleLabel.text = self.infoModel.Name;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (self.infoModel.Source.integerValue == 0) {
            //文字渐变
            ASGradientLabel *label = [[ASGradientLabel alloc]init];
            label.text = @"官方推荐";
            label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightHeavy];
            label.colors = @[(id)RGBA(250, 226, 102, 1).CGColor, (id)RGBA(239, 166, 58, 1).CGColor];
            label.startPoint = CGPointMake(0, 0);
            label.endPoint = CGPointMake(1, 0);
            label.locations = @[@0 ,@1];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.titleLabel);
                make.right.mas_equalTo(-18);
            }];
        }
        return cell;
    }else if (indexPath.section == 2){
        YPMyKeYuan190312DetailXuQiuCell *cell = [YPMyKeYuan190312DetailXuQiuCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = [self.infoModel.Identity componentsSeparatedByString:@","];
        if (arr.count > 0) {
            cell.label1.text = arr[0];
        }else{
            cell.label1.text = @"酒店";
        }
        return cell;
    }else if (indexPath.section == 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc]init];
        if (self.infoModel.Meno.length > 0) {
            label.text = self.infoModel.Meno;
        }else{
            label.text = @"无";
        }
        label.textColor = LightGrayColor;
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        return cell;
    }else{
        YPMyKeYuan190312DetailWedInfoCell *cell = [YPMyKeYuan190312DetailWedInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.infoModel.Phone.length > 0) {
            cell.phoneLabel.text = self.infoModel.Phone;
        }else{
            cell.phoneLabel.text = @"无电话";
        }
        if (self.infoModel.WeddingTime.length > 0) {
            cell.wedDate.text = self.infoModel.WeddingTime;
        }else{
            cell.wedDate.text = @"无婚期";
        }
        if (self.infoModel.Area.length > 0) {
            cell.areaLabel.text = self.infoModel.Area;
        }else{
            cell.areaLabel.text = @"无地区";
        }
        cell.zhuoshu.text = [NSString stringWithFormat:@"%@桌",self.infoModel.TablesNumber];
        cell.canbiao.text = [NSString stringWithFormat:@"%@元/桌",self.infoModel.MealMark];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBS(245);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2 || section == 3 || section == 4) {
        return 40;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    label.textColor = [UIColor darkGrayColor];
    if (section == 2){
        label.text = @"需求商家";
    }else if (section == 3){
        label.text = @"备注";
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [btn setTitleColor:CHJ_RedColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(16);
        [btn addTarget:self action:@selector(remarkClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.centerY.mas_equalTo(view);
        }];
    }else if (section == 4){
        label.text = @"婚礼信息";
    }else{
        return nil;
    }
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

#pragma mark - 网络请求
#pragma mark 查看客源详情
- (void)GetJSJTableInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetJSJTableInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.detailID;
    params[@"FacilitatorId"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.Identity = [object valueForKey:@"Identity"];
            self.infoModel.Id = [object valueForKey:@"Id"];
            self.infoModel.Name = [object valueForKey:@"Name"];
            self.infoModel.Phone = [object valueForKey:@"Phone"];
            self.infoModel.WeddingTime = [object valueForKey:@"WeddingTime"];
            self.infoModel.Meno = [object valueForKey:@"Meno"];
            self.infoModel.TablesNumber = [object valueForKey:@"TablesNumber"];
            self.infoModel.MealMark = [object valueForKey:@"MealMark"];
            self.infoModel.Time = [object valueForKey:@"Time"];
            self.infoModel.Area = [object valueForKey:@"Area"];
            self.infoModel.FacilitatorName = [object valueForKey:@"FacilitatorName"];
            self.infoModel.DistributionType = [object valueForKey:@"DistributionType"];
            self.infoModel.Source = [object valueForKey:@"Source"];
            self.infoModel.TouristType = [object valueForKey:@"TouristType"];
            self.infoModel.Explain = [object valueForKey:@"Explain"];
            self.infoModel.AdvanceEarnest = [object valueForKey:@"AdvanceEarnest"];
            self.infoModel.AdvanceTime = [object valueForKey:@"AdvanceTime"];
            self.infoModel.PreliminaryBudget = [object valueForKey:@"PreliminaryBudget"];
            self.infoModel.ActualConsumption = [object valueForKey:@"ActualConsumption"];
            self.infoModel.RejectionReasons = [object valueForKey:@"RejectionReasons"];
            self.infoModel.Headportrait = [object valueForKey:@"Headportrait"];

            [self.tableView reloadData];

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络错误,请稍后重试!" inView:self.tableView];
        
    }];
    
}

#pragma mark 删除客源数据
- (void)DeleteJSJTableWithID:(NSString *)detailID{
    
    NSString *url = @"/api/HQOAApi/DeleteJSJTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = detailID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"删除成功!" inView:self.tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
    }];
    
}

#pragma mark 服务商编辑客源合作状态
- (void)UpdateJSJTouristType{
    
    NSString *url = @"/api/HQOAApi/UpdateJSJTouristType";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"TouristType"] = @4;//0待处理,1有意向,2已合作,3已拒单,4修改备注
    params[@"Id"] = self.infoModel.Id;
    params[@"Explain"] = @"";
    params[@"AdvanceEarnest"] = @"";
    params[@"AdvanceTime"] = @"";
    params[@"PreliminaryBudget"] = @"";
    params[@"ActualConsumption"] = @"";
    params[@"RejectionReasons"] = @"";
    params[@"Meno"] = self.remark;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"修改成功!" inView:self.tableView];
            
            [self GetJSJTableInfo];
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
    }];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editBtnClick{
    YPMyKeYuan190313DetailEditController *edit = [[YPMyKeYuan190313DetailEditController alloc]init];
    edit.infoModel = self.infoModel;
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)deleteBtnClick{
    [self DeleteJSJTableWithID:self.detailID];
}

- (void)contactBtnClick{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.infoModel.Phone]]];
}

- (void)remarkClick{
    NSLog(@"remarkClick");
    YPAddRemarkController *remark = [[YPAddRemarkController alloc]init];
    remark.titleStr = @"客源备注";
    remark.placeHolder = @"请填写客源备注";
    remark.limitCount = 60;
    remark.editRemark = self.remark;
    remark.yp_AddBlock = ^(NSString *titleStr, NSString *remark) {
        if ([titleStr isEqualToString:@"客源备注"]) {
            self.remark = remark;
            [self UpdateJSJTouristType];
        }
    };
    [self.navigationController pushViewController:remark animated:YES];
}

#pragma mark - getter
- (YPGetJSJTableInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetJSJTableInfo alloc]init];
    }
    return _infoModel;
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
