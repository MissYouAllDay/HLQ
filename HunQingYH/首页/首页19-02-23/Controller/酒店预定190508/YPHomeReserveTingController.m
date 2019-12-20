//
//  YPHomeReserveTingController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHomeReserveTingController.h"
#import "YPInviteFriendsWedInputCell.h"
#import "YPInviteFriendsWedPhoneInputCell.h"
#import "YPMyKeYuan190313EditRemarkCell.h"
#import "UIImage+YPGradientImage.h"
#import "BRDatePickerView.h"
#import "YPAddRemarkController.h"
#import "YPCanBiaoListViewController.h"

@interface YPHomeReserveTingController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**新人姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**桌数*/
@property (nonatomic, strong) UITextField *zhuoshuTF;
/**新人婚期*/
@property (nonatomic, copy) NSString *dateStr;
/**备注*/
@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *phoneStr;

@property (nonatomic, copy) __block NSString *selectCanBiaoID;
@property (nonatomic, copy) __block NSString *selectCanBiaoName;

@end

@implementation YPHomeReserveTingController{
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
    self.view.backgroundColor = WhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNav];
    [self setupUI];
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
    titleLab.text = @"预订信息";
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
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 50) andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 50) andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-HOME_INDICATOR_HEIGHT);
        make.height.mas_equalTo(50);
    }];
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50-HOME_INDICATOR_HEIGHT-1) style:UITableViewStyleGrouped];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return 1;
    }else{
        if (_type == 2) {//特惠详情
            return 6;//桌数
        }else{
            return 5;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = self.hotelTing;
        label1.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        [cell.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        if (_type == 1) {
            UILabel *label2 = [[UILabel alloc]init];
            label2.text = [NSString stringWithFormat:@"%@ %@",self.timeStr,self.zhuoshu];
            label2.font = [UIFont systemFontOfSize:13];
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-18);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(10);
                make.bottom.mas_equalTo(-10);
                make.left.mas_greaterThanOrEqualTo(label1.mas_right).mas_offset(5);
            }];
        }
        cell.backgroundColor = CHJ_bgColor;
        return cell;
    }else if (indexPath.section == 1){
        YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"宴会类型";
            cell.inputTF.text = @"婚宴";
            cell.inputTF.enabled = NO;
        }else if (indexPath.row == 1) {
            YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"联系人";
            cell.inputTF.placeholder = @"请输入姓名";
            cell.inputTF.keyboardType = UIKeyboardTypeDefault;
            cell.inputTF.enabled = YES;
            self.nameTF = cell.inputTF;
            if (self.nameStr.length > 0) {
                self.nameTF.text = self.nameStr;
            }else{
                self.nameTF.text = @"";
            }
            [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"电话";
            cell.inputTF.placeholder = @"请输入手机";
            cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
            cell.inputTF.enabled = YES;
            self.phoneTF = cell.inputTF;
            if (self.phoneStr.length > 0) {
                self.phoneTF.text = self.phoneStr;
            }else{
                self.phoneTF.text = @"";
            }
        }else if (indexPath.row == 3){
            cell.titleLabel.text = @"时间";
            cell.inputTF.placeholder = @"请选择新人婚期";
            cell.inputTF.enabled = NO;
            if (self.dateStr.length > 0) {
                cell.inputTF.text = self.dateStr;
            }else{
                cell.inputTF.text = @"";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 4){
            cell.titleLabel.text = @"餐标";
            cell.inputTF.placeholder = @"请选择餐标";
            cell.inputTF.enabled = NO;
            if (self.selectCanBiaoName.length > 0) {
                cell.inputTF.text = self.selectCanBiaoName;
            }else{
                cell.inputTF.text = @"";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 5){
            cell.titleLabel.text = @"桌数";
            cell.inputTF.placeholder = @"请输入桌数";
            cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
            cell.inputTF.enabled = YES;
            self.zhuoshuTF = cell.inputTF;
            if (self.zhuoshu.length > 0) {
                self.zhuoshuTF.text = self.zhuoshu;
            }else{
                self.zhuoshuTF.text = @"";
            }
        }
        return cell;
    }else{
        YPMyKeYuan190313EditRemarkCell *cell = [YPMyKeYuan190313EditRemarkCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_remark.length > 0) {
            cell.contentLabel.text = _remark;
        }else{
            cell.contentLabel.text = @"请输入备注内容";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    if (section == 1 || section == 2) {
        view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        UILabel *label = [[UILabel alloc]init];
        if (section == 1) {
            label.text = @"请填写预订信息";
        }else if (section == 2){
            label.text = @"备注";
        }
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.centerY.mas_equalTo(view);
        }];
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 3) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.section == 1 && indexPath.row == 4){
        if (self.dateStr.length > 0) {
            YPCanBiaoListViewController *list = [[YPCanBiaoListViewController alloc]init];
            list.tingID = self.listModel.Id;
            list.dateStr = self.dateStr;
            list.listBlock = ^(NSString * _Nonnull canbiaoID, NSString * _Nonnull canbiaoName) {
                self.selectCanBiaoID = canbiaoID;
                self.selectCanBiaoName = canbiaoName;
                [self.tableView reloadRow:4 inSection:1 withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:list animated:YES];
        }else{
            [EasyShowTextView showText:@"请先选择婚期" inView:self.tableView];
        }
    }else if (indexPath.section == 2){
        YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
        addRemark.titleStr = @"备注";
        addRemark.placeHolder = @"请输入备注内容";
        addRemark.limitCount = 60;
        addRemark.yp_AddBlock = ^(NSString *titleStr, NSString *remark) {
            if ([titleStr isEqualToString:@"备注"]) {
                _remark = remark;
                [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
            }
        };
        [self.navigationController pushViewController:addRemark animated:YES];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 通讯录
- (void)addressBookClick{
    YPAddressBookTool *tool = [YPAddressBookTool yp_shareAddressBookTool];
    tool.vc = self;
    [tool JudgeAddressBookPower];
    tool.successBlock = ^(NSDictionary * _Nonnull object) {
        NSLog(@"[YPAddressBookTool yp_shareAddressBookTool] -- %@--%@",object[@"name"],object[@"phone"]);
        NSMutableString *phone = [object[@"phone"] stringByReplacingOccurrencesOfString:@"-" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""].mutableCopy;
        self.nameStr = object[@"name"];
        self.phoneStr = phone.copy;
        [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
    };
}

- (void)submitBtnClick{
    [self CreateBanquetlReserve];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 添加宴会厅预定
- (void)CreateBanquetlReserve{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateBanquetlReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"BanquetCustomer"] = [NSString stringWithFormat:@"%@,%@",self.nameTF.text,self.phoneTF.text];
    params[@"BanquetId"] = self.listModel.Id;
    params[@"ReserveTime"] = @"";
    params[@"Type"] = @"";
    params[@"DinnerTime"] = self.dateStr;
    params[@"MealId"] = self.selectCanBiaoID;
    params[@"TableNumber"] = [self.zhuoshu stringByReplacingOccurrencesOfString:@"桌" withString:@""];
    NSDictionary *dict = self.listModel.Data_1[0];
    NSString *str = dict[@"EarnestType"];
    if (str.length > 0) {
        params[@"EarnestType"] = str;
    }else{
        params[@"EarnestType"] = @"";
    }
    params[@"EarnestMoney"] = @"0";
    params[@"EarnestTime"] = @"";
    params[@"Meno"] = self.remark;
    params[@"ScheduledPeopleId"] = UserId_New;
    params[@"RepresentativeId"] = @"";
    params[@"AdminId"] = UserId_New;
    params[@"AdminName"] = UserName_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提交成功" message:@"您的预订已经提交申请,等待商家接单,您也可以主动联系商家" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
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
