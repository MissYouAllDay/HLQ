//
//  YPWeddingOrderAddWedFanHuanController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/7.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderAddWedFanHuanController.h"
#import "YPWeddingOrderAddInputCell.h"
#import "YPWeddingOrderJieDanNamePhoneCell.h"
#import "YPWeddingOrderReturnPriceCell.h"
//#import "YPGetIntervalAmountParamList.h"//额度区间
#import "YPWeddingOrderReturnRulesController.h"//返还说明

@interface YPWeddingOrderAddWedFanHuanController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

/*******************************/
/**客户姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**客户手机*/
@property (nonatomic, strong) UITextField *phoneTF;
/**消费金额*/
@property (nonatomic, strong) UITextField *shouldPayTF;
/**扣除金额*/
@property (nonatomic, copy) NSString *retuPrice;
/*******************************/

//@property (nonatomic, strong) NSMutableArray<YPGetIntervalAmountParamList *> *eduMarr;

@end

@implementation YPWeddingOrderAddWedFanHuanController{
    UIView *_navView;
    NSString *_Proportion;
    NSString *_Describe;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetFacilitatorIdWeddingReturnProportion];
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
    titleLab.text = @"添加婚礼返还订单";
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
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPWeddingOrderAddInputCell *cell = [YPWeddingOrderAddInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.addressBook.hidden = YES;
    if (indexPath.row == 0) {
        
        cell.addressBook.hidden = NO;
        [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
        
        cell.nameLabel.text = @"客户名称";
        cell.inputTF.placeholder = @"请输入客户姓名";
        cell.inputTF.enabled = YES;
        cell.inputTF.font = kFont(15);
        self.nameTF = cell.inputTF;
    }else if (indexPath.row == 1){
        cell.nameLabel.text = @"客户手机";
        cell.inputTF.placeholder = @"请输入手机号码";
        cell.inputTF.enabled = YES;
        cell.inputTF.font = kFont(15);
        self.phoneTF = cell.inputTF;
    }else if (indexPath.row == 2){
        cell.nameLabel.text = @"消费金额";
        cell.inputTF.placeholder = @"请输入消费金额";
        cell.inputTF.enabled = YES;
        cell.inputTF.font = kFont(15);
        self.shouldPayTF = cell.inputTF;
        [cell.inputTF addTarget:self action:@selector(textFiledDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }else if (indexPath.row == 3){
        YPWeddingOrderReturnPriceCell *cell = [YPWeddingOrderReturnPriceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.titleLabel.text = @"扣除金额";
        cell.priceLabel.font = kFont(24);
        if (self.retuPrice.length > 0) {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@¥",self.retuPrice];
            cell.priceLabel.textColor = RGB(250, 80, 120);
        }else{
            cell.priceLabel.text = @"0¥";
            cell.priceLabel.textColor = RGBA(221, 221, 221, 1);
        }
        cell.whyBtn.hidden = NO;
        [cell.whyBtn addTarget:self action:@selector(whyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 4){
        YPWeddingOrderReturnPriceCell *cell = [YPWeddingOrderReturnPriceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.titleLabel.text = @"返还新人";
        cell.priceLabel.font = kFont(24);
        if (self.shouldPayTF.text.length > 0) {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@¥",self.shouldPayTF.text];
            cell.priceLabel.textColor = RGB(250, 80, 120);
        }else{
            cell.priceLabel.text = @"0¥";
            cell.priceLabel.textColor = RGBA(221, 221, 221, 1);
        }
        cell.whyBtn.hidden = YES;
        return cell;
    }else if (indexPath.row == 5){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"提交订单" forState:UIControlStateNormal];
        [btn1 setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn1.layer.cornerRadius = 3;
        btn1.clipsToBounds = YES;
        btn1.backgroundColor = RGB(250, 80, 120);
        [btn1 addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.height.mas_equalTo(48);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-10);
            make.right.mas_equalTo(-18);
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
}

#pragma mark - UITextFieldDelegate
- (void)textFiledDidChanged:(UITextField *)sender{
    if (sender == self.shouldPayTF) {

        NSInteger num = sender.text.integerValue;

        self.retuPrice = [NSString stringWithFormat:@"%.1f",num * (01-_Proportion.floatValue)];

        if (num == 0) {
            self.retuPrice = @"";
        }

        [self.tableView reloadRow:3 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
        //18-11-13 返还新人
        [self.tableView reloadRow:4 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
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

- (void)submitBtnClick{
    //平台 -- 线下
    if (self.nameTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户姓名" inView:self.tableView];
    }else if (self.phoneTF.text.length == 0){
        [EasyShowTextView showText:@"请输入客户手机" inView:self.tableView];
    }else if (self.shouldPayTF.text.length == 0){
        [EasyShowTextView showText:@"请输入消费金额" inView:self.tableView];
    }else{
        [self CreateFacilitatorWeddingReturn];
    }
}

- (void)whyBtnClick{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:_Describe message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}

#pragma mark - 网络请求
#pragma mark 根据服务商Id获取分配比例
- (void)GetFacilitatorIdWeddingReturnProportion{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorIdWeddingReturnProportion";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            _Proportion = [object valueForKey:@"Proportion"];
            _Describe = [object valueForKey:@"Describe"];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 服务商提交婚礼返还
- (void)CreateFacilitatorWeddingReturn{
    
    NSString *url = @"/api/HQOAApi/CreateFacilitatorWeddingReturn";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Name"] = self.nameTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"FacilitatorId"] = FacilitatorId_New;
    params[@"Money"] = self.shouldPayTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"添加婚礼返还订单成功!" inView:self.tableView];
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
