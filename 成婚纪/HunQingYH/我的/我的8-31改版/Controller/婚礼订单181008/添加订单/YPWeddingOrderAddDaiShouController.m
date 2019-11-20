//
//  YPWeddingOrderAddDaiShouController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderAddDaiShouController.h"
#import "YPWeddingOrderAddInputCell.h"
#import "YPWeddingOrderAddGuanlianCell.h"
#import "YPWeddingOrderJieDanNamePhoneCell.h"
#import "BRDatePickerView.h"
#import "YPWeddingOrderSupplierListController.h"//搜索商家
#import "YPWeddingOrderSearchUserPhoneController.h"//搜索手机号

@interface YPWeddingOrderAddDaiShouController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

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
/**消费金额*/
@property (nonatomic, strong) UITextField *priceTF;
/**婚礼日期*/
@property (nonatomic, copy) NSString *dateStr;
/**消费类型*/
@property (nonatomic, copy) NSString *typeStr;
/**关联商家名称*/
@property (nonatomic, copy) __block NSString *guanlianName;
/**关联商家ID*/
@property (nonatomic, copy) __block NSString *guanlianID;

/*******************************/

@end

@implementation YPWeddingOrderAddDaiShouController{
    UIView *_navView;
    
    NSString *_guanlian;//0: 婚礼桥平台 1: 平台商家
    UIButton *_pingtaiBtn;
    UIButton *_shangjiaBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    
    _guanlian = 0;//默认婚礼桥平台
    
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
    titleLab.text = @"添加代收订单";
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
    
    if (_guanlian.integerValue == 0) {//婚礼桥平台
        return 8;
    }else{//平台商家
        return 9;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPWeddingOrderAddInputCell *cell = [YPWeddingOrderAddInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        cell.addressBook.hidden = NO;
        [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
        
        cell.nameLabel.text = @"客户名称";
        cell.inputTF.placeholder = @"请输入客户姓名";
        cell.inputTF.enabled = YES;
        self.nameTF = cell.inputTF;
    }else if (indexPath.row == 2){
        cell.nameLabel.text = @"客户手机";
        cell.inputTF.placeholder = @"请输入手机号码";
        cell.inputTF.enabled = YES;
        self.phoneTF = cell.inputTF;
    }else if (indexPath.row == 3){
        cell.nameLabel.text = @"消费金额";
        cell.inputTF.placeholder = @"请输入消费金额";
        cell.inputTF.enabled = YES;
        self.priceTF = cell.inputTF;
    }else if (indexPath.row == 4){
        cell.nameLabel.text = @"婚礼日期";
        cell.inputTF.placeholder = @"请选择婚礼日期";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.inputTF.enabled = NO;
        if (self.dateStr.length > 0) {
            cell.inputTF.text = self.dateStr;
        }else{
            cell.inputTF.text = @"";
        }
    }else if (indexPath.row == 5){
        cell.nameLabel.text = @"消费类型";
        cell.inputTF.placeholder = @"请选择消费类型";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.inputTF.enabled = NO;
        if (self.typeStr.length > 0) {
            cell.inputTF.text = self.typeStr;
        }else{
            cell.inputTF.text = @"";
        }
    }else if (indexPath.row == 6){
        YPWeddingOrderAddGuanlianCell *cell = [YPWeddingOrderAddGuanlianCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _pingtaiBtn = cell.pingtai;
        _shangjiaBtn = cell.shangjia;
        
        if (_guanlian.integerValue == 0) {
            [_pingtaiBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
            _pingtaiBtn.backgroundColor = RGB(250, 80, 120);
            [_shangjiaBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
            _shangjiaBtn.backgroundColor = CHJ_bgColor;
        }else{
            [_shangjiaBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
            _shangjiaBtn.backgroundColor = RGB(250, 80, 120);
            [_pingtaiBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
            _pingtaiBtn.backgroundColor = CHJ_bgColor;
        }
        
        [cell.pingtai addTarget:self action:@selector(pingtaiClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.shangjia addTarget:self action:@selector(shangjiaClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        if (_guanlian.integerValue == 0) {//平台
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIButton *btn1 = [[UIButton alloc]init];
            [btn1 setTitle:@"提交" forState:UIControlStateNormal];
            [btn1 setTitleColor:WhiteColor forState:UIControlStateNormal];
            btn1.backgroundColor = RGB(250, 80, 120);
            btn1.layer.cornerRadius = 3;
            btn1.clipsToBounds = YES;
            [btn1 addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn1];
            [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(18);
                make.right.mas_equalTo(-18);
                make.height.mas_equalTo(48);
                make.top.mas_equalTo(20);
                make.bottom.mas_equalTo(-10);
            }];
            
            return cell;
        }else{//商家
            if (indexPath.row == 7) {
                YPWeddingOrderAddInputCell *cell = [YPWeddingOrderAddInputCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.addressBook.hidden = YES;
                cell.nameLabel.hidden = YES;
                cell.inputTF.placeholder = @"请选择关联商家";
                cell.inputTF.enabled = NO;
                if (self.guanlianName.length > 0) {
                    cell.inputTF.text = self.guanlianName;
                }
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]init];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIButton *btn1 = [[UIButton alloc]init];
                [btn1 setTitle:@"提交" forState:UIControlStateNormal];
                [btn1 setTitleColor:WhiteColor forState:UIControlStateNormal];
                btn1.backgroundColor = RGB(250, 80, 120);
                btn1.layer.cornerRadius = 3;
                btn1.clipsToBounds = YES;
                [btn1 addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn1];
                [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(18);
                    make.right.mas_equalTo(-18);
                    make.height.mas_equalTo(48);
                    make.top.mas_equalTo(20);
                    make.bottom.mas_equalTo(-10);
                }];
                
                return cell;
            }
        }
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
    }else if (indexPath.row == 4) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.row == 5){
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"消费类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"首款", @"再款", @"尾款", @"全款", nil];
        [sheet showInView:self.view];
    }
    if (_guanlian.integerValue == 1) {//平台
        if (indexPath.row == 7) {
            YPWeddingOrderSupplierListController *list = [[YPWeddingOrderSupplierListController alloc]init];
            list.zhiYeArr = @[].mutableCopy;
            
            __weak typeof(self) WeakSelf = self;
            list.supBlock = ^(NSString * _Nonnull name, NSString * _Nonnull supID) {
                WeakSelf.guanlianName = name;
                WeakSelf.guanlianID = supID;
                [WeakSelf.tableView reloadRow:7 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:list animated:YES];
            
        }
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
    [self.tableView reloadRow:5 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
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

- (void)pingtaiClick{
    _guanlian = @"0";
    [_pingtaiBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    _pingtaiBtn.backgroundColor = RGB(250, 80, 120);
    [_shangjiaBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    _shangjiaBtn.backgroundColor = CHJ_bgColor;
    
    [self.tableView reloadData];
}

- (void)shangjiaClick{
    _guanlian = @"1";
    [_shangjiaBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    _shangjiaBtn.backgroundColor = RGB(250, 80, 120);
    [_pingtaiBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    _pingtaiBtn.backgroundColor = CHJ_bgColor;
    
    [self.tableView reloadData];
}

- (void)submitClick{
    NSLog(@"submitClick");
    
    if (self.jiedanPhoneTF.text.length == 0) {
        [EasyShowTextView showText:@"请输入接单人手机号" inView:self.tableView];
    }else if (self.nameTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户姓名" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户手机" inView:self.tableView];
    }else if (self.priceTF.text.length == 0){
        [EasyShowTextView showText:@"请输入消费金额" inView:self.tableView];
    }else if (self.dateStr.length == 0){
        [EasyShowTextView showText:@"请选择婚礼日期" inView:self.tableView];
    }else if (self.typeStr.length == 0){
        [EasyShowTextView showText:@"请选择消费类型" inView:self.tableView];
    }else{
        [self CreateFacilitatorReceivables];
    }
}

#pragma mark - 网络请求
#pragma mark 服务商提交代收款流水
- (void)CreateFacilitatorReceivables{
    
    NSString *url = @"/api/HQOAApi/CreateFacilitatorReceivables";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"FacilitatorId"] = FacilitatorId_New;
    if (self.guanlianID.length > 0) {
        params[@"DistributionFacilitatorId"] = self.guanlianID;
    }else{
        params[@"DistributionFacilitatorId"] = @"00000000-0000-0000-0000-000000000000";
    }
    params[@"Money"] = self.priceTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"UserName"] = self.nameTF.text;
    params[@"WeddingDate"] = self.dateStr;
    params[@"Meno"] = self.typeStr;
    params[@"SinglePersonUserId"] = self.jiedanID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加代收订单成功!" inView:self.tableView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
