//
//  YPWeddingOrderAddBanShouLiController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderAddBanShouLiController.h"
#import "YPWeddingOrderAddInputCell.h"
#import "YPWeddingOrderJieDanNamePhoneCell.h"
#import "YPWeddingOrderReturnPriceCell.h"
#import "BRDatePickerView.h"
#import "YPGetIntervalAmountParamList.h"//额度区间
#import "YPWeddingOrderSearchUserPhoneController.h"//搜索手机号
#import "YPWeddingOrderReturnRulesController.h"//返还说明

@interface YPWeddingOrderAddBanShouLiController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

/*******************************/
/**接单人手机号*/
@property (nonatomic, strong) __block UITextField *jiedanPhoneTF;
/**接单人手机号*/
@property (nonatomic, copy) __block NSString *jiedanPhone;
/**接单人姓名*/
@property (nonatomic, copy) __block NSString *jiedanName;
/**接单人ID*/
@property (nonatomic, copy) __block NSString *jiedanID;
/**客户姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**客户手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**婚礼日期*/
@property (nonatomic, copy) NSString *dateStr;
/**应付金额*/
@property (nonatomic, strong) UITextField *shouldPayTF;
/**返还金额*/
@property (nonatomic, copy) NSString *retuPrice;
/**消费类型*/
@property (nonatomic, copy) NSString *typeStr;
/*******************************/

@property (nonatomic, strong) NSMutableArray<YPGetIntervalAmountParamList *> *eduMarr;

@end

@implementation YPWeddingOrderAddBanShouLiController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetIntervalAmountParamList];
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
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 18, 0, 18);
    self.tableView.separatorColor = LightGrayColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];

}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"添加伴手礼订单";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPWeddingOrderAddInputCell *cell = [YPWeddingOrderAddInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.addressBook.hidden = YES;
    if (indexPath.row == 0) {
        
        if (self.jiedanPhone.length > 0 || self.jiedanName.length > 0) {
            YPWeddingOrderJieDanNamePhoneCell *cell = [YPWeddingOrderJieDanNamePhoneCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.nameLabel.text = @"接单人";
            if (self.jiedanName.length > 0) {
                cell.titleLabel.text = self.jiedanName;
            }else{
                cell.titleLabel.text = @"无姓名";
            }
            if (self.jiedanPhone.length > 0) {
                cell.phoneLabel.text = self.jiedanPhone;
            }else{
                cell.phoneLabel.text = @"无手机号";
            }
            return cell;
        }else{
            cell.nameLabel.text = @"接单人";
            cell.inputTF.text = @"";
            cell.inputTF.placeholder = @"请选择接单人";
            cell.inputTF.enabled = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.inputTF.font = kFont(15);
            self.jiedanPhoneTF = cell.inputTF;
        }
    }else if (indexPath.row == 1) {
        cell.nameLabel.text = @"客户名称";
        cell.inputTF.placeholder = @"请输入客户姓名";
        cell.inputTF.enabled = YES;
        cell.inputTF.font = kFont(15);
        self.nameTF = cell.inputTF;
        
        cell.addressBook.hidden = NO;
        [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (indexPath.row == 2){
        cell.nameLabel.text = @"客户手机";
        cell.inputTF.placeholder = @"请输入手机号码";
        cell.inputTF.enabled = YES;
        cell.inputTF.font = kFont(15);
        self.phoneTF = cell.inputTF;
    }else if (indexPath.row == 3){
        cell.nameLabel.text = @"婚礼日期";
        cell.inputTF.placeholder = @"请选择婚礼日期";
        cell.inputTF.enabled = NO;
        cell.inputTF.font = kFont(15);
        if (self.dateStr.length > 0) {
            cell.inputTF.text = self.dateStr;
        }else{
            cell.inputTF.text = @"";
        }
    }else if (indexPath.row == 4){
        cell.nameLabel.text = @"应付金额";
        cell.inputTF.placeholder = @"请输入应付金额";
        cell.inputTF.enabled = YES;
        cell.inputTF.font = kFont(15);
        self.shouldPayTF = cell.inputTF;
        [cell.inputTF addTarget:self action:@selector(textFiledDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }else if (indexPath.row == 5){
        YPWeddingOrderReturnPriceCell *cell = [YPWeddingOrderReturnPriceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.priceLabel.font = kFont(24);
        if (self.retuPrice.length > 0) {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@¥",self.retuPrice];
            cell.priceLabel.textColor = RGB(250, 80, 120);
        }else{
            cell.priceLabel.text = @"0¥";
            cell.priceLabel.textColor = RGBA(221, 221, 221, 1);
        }
        [cell.whyBtn addTarget:self action:@selector(whyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 6){
        cell.nameLabel.text = @"消费类型";
        cell.inputTF.placeholder = @"请选择消费类型";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.inputTF.enabled = NO;
        cell.inputTF.font = kFont(15);
        if (self.typeStr.length > 0) {
            cell.inputTF.text = self.typeStr;
        }else{
            cell.inputTF.text = @"";
        }
    }else if (indexPath.row == 7){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"发送给平台" forState:UIControlStateNormal];
        [btn1 setTitleColor:BlackColor forState:UIControlStateNormal];
        btn1.layer.cornerRadius = 3;
        btn1.clipsToBounds = YES;
        btn1.layer.borderColor = LightGrayColor.CGColor;
        btn1.layer.borderWidth = 1;
        [btn1 addTarget:self action:@selector(pingtaiPayClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.height.mas_equalTo(48);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-10);
        }];
        UIButton *btn2 = [[UIButton alloc]init];
        [btn2 setTitle:@"客户线上支付" forState:UIControlStateNormal];
        [btn2 setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn2.backgroundColor = RGB(250, 80, 120);
        btn2.layer.cornerRadius = 3;
        btn2.clipsToBounds = YES;
        [btn2 addTarget:self action:@selector(xianshangPayClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.height.mas_equalTo(48);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(btn1.mas_right).mas_offset(10);
            make.width.mas_equalTo(btn1);
        }];

        return cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        YPWeddingOrderSearchUserPhoneController *search = [[YPWeddingOrderSearchUserPhoneController alloc]init];
        search.searchBlock = ^(YPGetUserByPhone * _Nonnull phoneModel) {
            self.jiedanPhoneTF.text = [NSString stringWithFormat:@"%@\n%@",phoneModel.NickName,phoneModel.Phone];
            self.jiedanPhone = phoneModel.Phone;
            self.jiedanName = phoneModel.NickName;
            self.jiedanID = phoneModel.UserId;
            [self.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:search animated:YES];
    }else if (indexPath.row == 3) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.row == 6){
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"消费类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"首款", @"再款", @"尾款", @"全款", nil];
        [sheet showInView:self.view];
    }
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.typeStr = @"首款";
    }else if (buttonIndex == 1){
        self.typeStr = @"再款";
    }else if (buttonIndex == 2){
        self.typeStr = @"尾款";
    }else if (buttonIndex == 3){
        self.typeStr = @"全款";
    }
    [self.tableView reloadRow:6 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITextFieldDelegate
- (void)textFiledDidChanged:(UITextField *)sender{
    if (sender == self.shouldPayTF) {
        
        NSInteger num = sender.text.integerValue;
        
        for (YPGetIntervalAmountParamList *list in self.eduMarr) {
            if (num >= list.StartingPrice.integerValue && num <= list.TerminationPrice.integerValue) {
                NSLog(@"%zd <= %zd <= %zd -- %@",list.StartingPrice.integerValue,num,list.TerminationPrice.integerValue,list.Reversion);
                self.retuPrice = list.Reversion;
            }
        }
        
        if (num == 0) {
            self.retuPrice = @"";
        }
        
        [self.tableView reloadRow:5 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }
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
        self.nameTF.text = object[@"name"];
        self.phoneTF.text = phone.copy;
    };
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pingtaiPayClick{
    //平台 -- 线下
    if (self.jiedanPhoneTF.text.length == 0) {
        [EasyShowTextView showText:@"请选择接单人" inView:self.tableView];
    }else if (self.nameTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户姓名" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户手机" inView:self.tableView];
    }else if (self.dateStr.length == 0){
        [EasyShowTextView showText:@"请选择婚礼日期" inView:self.tableView];
    }else if (self.shouldPayTF.text.length == 0){
        [EasyShowTextView showText:@"请输入应付金额" inView:self.tableView];
    }else if (self.typeStr.length == 0){
        [EasyShowTextView showText:@"请选择消费类型" inView:self.tableView];
    }else{
        [self CreateFacilitatorFlowRecordWithPaymentType:@"1"];//0线上,1线下
    }
}

- (void)xianshangPayClick{
    //线上
    
    if (self.jiedanPhoneTF.text.length == 0) {
        [EasyShowTextView showText:@"请输入接单人手机号" inView:self.tableView];
    }else if (self.nameTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户姓名" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户手机" inView:self.tableView];
    }else if (self.dateStr.length == 0){
        [EasyShowTextView showText:@"请选择婚礼日期" inView:self.tableView];
    }else if (self.shouldPayTF.text.length == 0){
        [EasyShowTextView showText:@"请输入应付金额" inView:self.tableView];
    }else if (self.typeStr.length == 0){
        [EasyShowTextView showText:@"请选择消费类型" inView:self.tableView];
    }else{
        [self CreateFacilitatorFlowRecordWithPaymentType:@"0"];//0线上,1线下
    }
}

- (void)whyBtnClick{
    
    YPWeddingOrderReturnRulesController *rule = [[YPWeddingOrderReturnRulesController alloc]init];
    rule.eduArr = self.eduMarr.copy;
    [self.navigationController pushViewController:rule animated:YES];
    
}

#pragma mark - 网络请求
#pragma mark 获取区间额度列表
- (void)GetIntervalAmountParamList{
    
    NSString *url = @"/api/HQOAApi/GetIntervalAmountParamList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"IdentityId"] = Profession_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.eduMarr removeAllObjects];
            
            self.eduMarr = [YPGetIntervalAmountParamList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 服务商提交伴手礼流水
- (void)CreateFacilitatorFlowRecordWithPaymentType:(NSString *)type{
    
    NSString *url = @"/api/HQOAApi/CreateFacilitatorFlowRecord";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"PaymentType"] = type;//0线上,1线下
    params[@"Money"] = self.shouldPayTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"UserName"] = self.nameTF.text;
    params[@"WeddingDate"] = self.dateStr;
    params[@"Meno"] = self.typeStr;
    params[@"SinglePersonUserId"] = self.jiedanID;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加伴手礼订单成功!" inView:self.tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetIntervalAmountParamList *> *)eduMarr{
    if (!_eduMarr) {
        _eduMarr = [NSMutableArray array];
    }
    return _eduMarr;
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
