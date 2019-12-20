//
//  HRTiXianViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "HRTiXianViewController.h"
#import "HRTixianSelectCell.h"
#import "HRMoneyInputCell.h"
#import "HRAddZFBController.h"
#import "YPGetFacilitatorAccountNumberList.h"
#import "YPReMyWalletAddBankController.h"
#import "HRTiXianQueRenController.h"//确认界面

@interface HRTiXianViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UIView *_navView;
    NSInteger selectNum;
    NSString *_tixianCount;
    UITextField *_inputTF;
    NSString *_selectStr;//选中支付宝/卡号
    NSString *_selectID;//选中账号ID
    /**1: 支付宝  2: 银行卡*/
    NSString *_typeStr;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorAccountNumberList *> *listMarr;

/**支付宝账号*/
@property (nonatomic, copy) NSString *Number;
/**支付宝账号id*/
@property (nonatomic, copy) NSString *Id;
/**支付宝账户名称*/
@property (nonatomic, copy) NSString *AccountName;
/**可用状态
 0可用1不可用*/
@property (nonatomic, copy) NSString *AlipayType;

@end

@implementation HRTiXianViewController{
    UIButton *_submitBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    selectNum =0;
    
    [self GetFacilitatorAccountNumberList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
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
    titleLab.text = @"提现";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
  
}
-(void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-62) style:UITableViewStylePlain];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
    }
    _submitBtn.enabled = NO;
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateDisabled];
    [_submitBtn setTitleColor:RGBA(255, 207, 139, 1) forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = kFont(14);
    if (_submitBtn.isEnabled) {
        _submitBtn.backgroundColor = RGBA(51, 51, 51, 1);
    }else{
        _submitBtn.backgroundColor = RGBA(221, 221, 221, 1);
    }
    _submitBtn.layer.cornerRadius = 4;
    _submitBtn.clipsToBounds = YES;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_submitBtn];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-12);
    }];
    
}
#pragma mark -------tableviewDatascource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        return 2+self.listMarr.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section ==0) {
        HRMoneyInputCell *cell = [HRMoneyInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _inputTF = cell.inputTF;
        _inputTF.delegate = self;
        if (_tixianCount.length > 0) {
            _inputTF.text = _tixianCount;
        }
        
        return cell;
    }else{
        HRTixianSelectCell *cell = [HRTixianSelectCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row ==0) {
            cell.iconImageView.image =[UIImage imageNamed:@"tianxian_zhifubao"];
            cell.titleLab.text = @"支付宝";
            if (self.AlipayType.integerValue == 0) {//0可用1不可用
                cell.desLab.text = self.Number;
            }else{
                cell.desLab.text = @"添加支付宝账号";
            }
            
        }else if(indexPath.row == self.listMarr.count+1){//最后一行 添加银行卡
            cell.iconImageView.image =[UIImage imageNamed:@"tixian_addCard"];
            cell.titleLab.text = @"新增银行卡";
            cell.desLab.text = @"添加新的银行卡";
            
        }else{
            
            YPGetFacilitatorAccountNumberList *listModel = self.listMarr[indexPath.row-1];
            cell.iconImageView.image =[UIImage imageNamed:@"re_myWallet_bank"];
            if (listModel.AffiliatedBank.length > 0) {
                cell.titleLab.text = listModel.AffiliatedBank;
            }else{
                cell.titleLab.text = @"银行卡";
            }
            cell.desLab.text = listModel.Number;
        }
        
        if (selectNum == indexPath.row) {
            if (indexPath.row == 0) {//支付宝
                if (self.AlipayType.integerValue == 0) {//0可用1不可用
                    cell.selectFlag = YES;
                    _selectStr = self.Number;
                    _typeStr = @"1";//支付宝
                    _selectID = self.Id;
                }else{
                    cell.selectFlag = NO;
                }
            }else{
                cell.selectFlag = YES;
            }
        }else{
            cell.selectFlag = NO;
        }
       
        return cell;
    }
}
#pragma mark ------talbeviewDelegate ---------
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section ==0) {
//        return 100;
//    }else{
//        return 50;
//    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        
        selectNum =indexPath.row;
        [self.tableView reloadData];
        
        if (indexPath.row == 0) {
            if (self.AlipayType.integerValue == 1) {//0可用1不可用
                HRAddZFBController *addVC = [HRAddZFBController new];
                addVC.typeStr = @"0";//普通添加
                [self.navigationController pushViewController:addVC animated:YES];
            }else{
                _selectStr = self.Number;
                _typeStr = @"1";//支付宝
                _selectID = self.Id;
            }
        }else if (indexPath.row == self.listMarr.count+1){//最后一行
            YPReMyWalletAddBankController *addVC = [YPReMyWalletAddBankController new];
            addVC.typeStr = @"0";//普通添加
            [self.navigationController pushViewController:addVC animated:YES];
        }else{
            YPGetFacilitatorAccountNumberList *listModel = self.listMarr[selectNum-1];
            _selectStr = listModel.Number;
            _typeStr = @"2";//银行卡
            _selectID = listModel.Id;
        }
        
        [self textFieldDidEndEditing:_inputTF];//重新调用 刷新提交btn
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }else{
        return 50;

    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor =WhiteColor;
    if (section ==1) {
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text =@"提现至";
        titleLab.font =kFont(15);
        [headerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerView.mas_left).offset(15);
            make.bottom.mas_equalTo(headerView.mas_bottom);
        }];
    }
    if (section ==0) {
        return nil;
    }else{
        return headerView;

    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _inputTF) {
        _tixianCount = textField.text;
    }
    if (_tixianCount.length > 0 && _selectStr.length > 0) {
        _submitBtn.enabled = YES;
        _submitBtn.backgroundColor = RGBA(51, 51, 51, 1);
    }else{
        _submitBtn.enabled = NO;
        _submitBtn.backgroundColor = RGBA(221, 221, 221, 1);
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitBtnClick{
    HRTiXianQueRenController *sure = [[HRTiXianQueRenController alloc]init];
    sure.phoneOrAccount = _selectStr;
    sure.countNum = _tixianCount;
    sure.typeStr = _typeStr;
    sure.AccountNumberId = _selectID;
    [self.navigationController pushViewController:sure animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取账号列表
- (void)GetFacilitatorAccountNumberList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorAccountNumberList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (YongHu(Profession_New)) {
        params[@"FacilitatorId"] = UserId_New;
        params[@"Type"] = @"1";//1新人,2服务商
    }else{
        params[@"FacilitatorId"] = FacilitatorId_New;
        params[@"Type"] = @"2";//1新人,2服务商
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.Number = [object valueForKey:@"Number"];
            self.Id = [object valueForKey:@"Id"];
            self.AccountName = [object valueForKey:@"AccountName"];
            self.AlipayType = [object valueForKey:@"AlipayType"];

            self.listMarr = [YPGetFacilitatorAccountNumberList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorAccountNumberList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

@end
