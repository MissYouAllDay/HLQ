//
//  YPMyKeYuan190313DetailEditController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/13.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190313DetailEditController.h"
#import "YPMyKeYuan190312DetailInfoCell.h"
#import "YPMyKeYuan190313DetailEditBtnCell.h"
#import "YPMyKeYuan190313EditRemarkCell.h"
#import "YPMyKeYuan190313EditInputCell.h"
#import "BRDatePickerView.h"
#import "YPAddRemarkController.h"

@interface YPMyKeYuan190313DetailEditController ()<UITableViewDelegate,UITableViewDataSource,YPAddRemarkDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *yufuTF;
@property (nonatomic, strong) UITextField *chubuTF;
@property (nonatomic, strong) UITextField *shijiTF;
@property (nonatomic, copy) NSString *dateStr;

@end

@implementation YPMyKeYuan190313DetailEditController{
    UIView *_navView;
    NSInteger _select;//0待处理,1有意向,2已合作,3已拒单
    __block NSString *_tandan;
    __block NSString *_judan;
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
    
    _select = 0;
    
    [self setupUI];
    [self setupNav];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(16);
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"编辑合作状态";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBA(103, 126, 215, 1) forState:UIControlStateNormal];
    saveBtn.titleLabel.font = kFont(16);
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_select == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    if (_select == 2) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPMyKeYuan190312DetailInfoCell *cell = [YPMyKeYuan190312DetailInfoCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.Headportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            if (self.infoModel.Name.length > 0) {
                cell.titleLabel.text = self.infoModel.Name;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            return cell;
        }else{
            YPMyKeYuan190313DetailEditBtnCell *cell = [YPMyKeYuan190313DetailEditBtnCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_select == 0) {
                cell.btn1.selected = YES;
                cell.btn2.selected = NO;
                cell.btn3.selected = NO;
                cell.btn4.selected = NO;
            }else if (_select == 1){
                cell.btn1.selected = NO;
                cell.btn2.selected = YES;
                cell.btn3.selected = NO;
                cell.btn4.selected = NO;
            }else if (_select == 2){
                cell.btn1.selected = NO;
                cell.btn2.selected = NO;
                cell.btn3.selected = YES;
                cell.btn4.selected = NO;
            }else if (_select == 3){
                cell.btn1.selected = NO;
                cell.btn2.selected = NO;
                cell.btn3.selected = NO;
                cell.btn4.selected = YES;
            }
            cell.btn1.tag = 1000;
            cell.btn2.tag = 1001;
            cell.btn3.tag = 1002;
            cell.btn4.tag = 1003;
            [cell.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else{
        if (_select == 1 || _select == 3) {
            YPMyKeYuan190313EditRemarkCell *cell = [YPMyKeYuan190313EditRemarkCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_select == 1) {
                if (_tandan.length > 0) {
                    cell.contentLabel.text = _tandan;
                }else{
                    cell.contentLabel.text = @"备注您的谈单要点…";
                }
            }else if (_select == 3){
                if (_judan.length > 0) {
                    cell.contentLabel.text = _judan;
                }else{
                    cell.contentLabel.text = @"请输入客户拒单原因…";
                }
            }
            return cell;
        }else if (_select == 2){
            YPMyKeYuan190313EditInputCell *cell = [YPMyKeYuan190313EditInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"预付定金";
                cell.inputTF.enabled = YES;
                cell.inputTF.placeholder = @"0¥";
                self.yufuTF = cell.inputTF;
            }else if (indexPath.row == 1) {
                cell.titleLabel.text = @"预付时间";
                cell.inputTF.enabled = NO;
                cell.inputTF.placeholder = @"请选择支付定金的时间";
                if (self.dateStr.length > 0) {
                    cell.inputTF.text = self.dateStr;
                }else{
                    cell.inputTF.text = @"";
                }
            }else if (indexPath.row == 2) {
                cell.titleLabel.text = @"初步预算";
                cell.inputTF.enabled = YES;
                cell.inputTF.placeholder = @"0¥";
                self.chubuTF = cell.inputTF;
            }else if (indexPath.row == 3) {
                cell.titleLabel.text = @"实际消费";
                cell.inputTF.enabled = YES;
                cell.inputTF.placeholder = @"0¥";
                self.shijiTF = cell.inputTF;
            }
            return cell;
        }
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
    if (section == 1) {
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
    if (section == 1){
        if (_select == 1) {
            label.text = @"谈单说明";
        }else if (_select == 2) {
            label.text = @"合作详情";
        }else if (_select == 3) {
            label.text = @"拒单原因";
        }
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
    if (indexPath.section == 1) {
        if (_select == 1) {
            YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
            addRemark.titleStr = @"谈单说明";
            addRemark.placeHolder = @"备注您的谈单要点…";
            addRemark.limitCount = 60;
            addRemark.yp_AddBlock = ^(NSString *titleStr, NSString *remark) {
                if ([titleStr isEqualToString:@"谈单说明"]) {
                    _tandan = remark;
                    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                }
            };
            [self.navigationController pushViewController:addRemark animated:YES];
        }
        if (_select == 2){
            if (indexPath.row == 1) {
                [BRDatePickerView showDatePickerWithTitle:@"请选择预付时间" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
                    self.dateStr = selectValue;
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
        }
        if (_select == 3) {
            YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
            addRemark.titleStr = @"拒单原因";
            addRemark.placeHolder = @"请输入客户拒单原因…";
            addRemark.limitCount = 60;
            addRemark.yp_AddBlock = ^(NSString *titleStr, NSString *remark) {
                if ([titleStr isEqualToString:@"拒单原因"]) {
                    _judan = remark;
                    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                }
            };
            [self.navigationController pushViewController:addRemark animated:YES];
        }
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick{
    NSLog(@"保存");
    [self UpdateJSJTouristType];
}

- (void)btnClick:(UIButton *)sender{
    _select = sender.tag-1000;
    [self.tableView reloadData];
}

#pragma mark - 网络请求
#pragma mark 服务商编辑客源合作状态
- (void)UpdateJSJTouristType{
    
    NSString *url = @"/api/HQOAApi/UpdateJSJTouristType";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"TouristType"] = @(_select);//0待处理,1有意向,2已合作,3已拒单,4修改备注
    params[@"Id"] = self.infoModel.Id;
    if (_select == 1) {
        if (_tandan.length > 0) {
            params[@"Explain"] = _tandan;
        }else{
            params[@"Explain"] = @"";
        }
    }else{
        params[@"Explain"] = @"";
    }
    if (_select == 2) {
        if (self.yufuTF.text.length > 0) {
            params[@"AdvanceEarnest"] = self.yufuTF.text;
        }else{
            params[@"AdvanceEarnest"] = @"";
        }
        if (self.dateStr.length > 0) {
            params[@"AdvanceTime"] = self.dateStr;
        }else{
            params[@"AdvanceTime"] = @"";
        }
        if (self.chubuTF.text.length > 0) {
            params[@"PreliminaryBudget"] = self.chubuTF.text;
        }else{
            params[@"PreliminaryBudget"] = @"";
        }
        if (self.shijiTF.text.length > 0) {
            params[@"ActualConsumption"] = self.shijiTF.text;
        }else{
            params[@"ActualConsumption"] = @"";
        }
    }else{
        params[@"AdvanceEarnest"] = @"";
        params[@"AdvanceTime"] = @"";
        params[@"PreliminaryBudget"] = @"";
        params[@"ActualConsumption"] = @"";
    }
    if (_select == 3) {
        if (_judan.length > 0) {
            params[@"RejectionReasons"] = _judan;
        }else{
            params[@"RejectionReasons"] = @"";
        }
    }else{
        params[@"RejectionReasons"] = @"";
    }

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"修改成功!" inView:self.tableView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
