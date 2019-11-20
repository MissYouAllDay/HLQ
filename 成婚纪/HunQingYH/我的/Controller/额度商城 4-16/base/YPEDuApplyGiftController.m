//
//  YPEDuApplyGiftController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/17.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuApplyGiftController.h"
#import "YPFreeWeddingTitleCell.h"
#import "YPFreeWeddingInputCell.h"
#import "BRPickerView.h"

@interface YPEDuApplyGiftController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**姓名*/
@property (nonatomic, copy) NSString *nameStr;
/**手机*/
@property (nonatomic, copy) NSString *phoneStr;
/**婚期*/
@property (nonatomic, copy) NSString *selectTime;
/**预算*/
@property (nonatomic, copy) NSString *yusuanStr;
/**合作婚庆公司*/
@property (nonatomic, copy) NSString *corpName;
/**酒店*/
@property (nonatomic, copy) NSString *hotelStr;

@end

@implementation YPEDuApplyGiftController{
    UIView *_navView;
    UIButton *_upBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"我要申请礼品";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //提交  设置导航栏右边
    _upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_upBtn setTitleColor:GrayColor forState:UIControlStateNormal];
    [_upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_upBtn];
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        //        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        YPFreeWeddingTitleCell *cell = [YPFreeWeddingTitleCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.descLabel.text = @"下列信息非必填";
        return cell;
        
    }else{
        
        YPFreeWeddingInputCell *cell = [YPFreeWeddingInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.inputTF.tag = indexPath.row + 1000;
        cell.inputTF.delegate = self;
        
        if (indexPath.row == 1) {
            
            cell.titleLabel.text = @"姓名";
            cell.inputTF.placeholder = @"输入姓名";
            cell.inputTF.enabled = YES;
            
            if (self.nameStr.length > 0) {
                cell.inputTF.text = self.nameStr;
            }else{
                cell.inputTF.text = @"";
            }
            
        }else if (indexPath.row == 2){
            
            cell.titleLabel.text = @"手机";
            cell.inputTF.placeholder = @"输入手机";
            cell.inputTF.enabled = YES;
            
            if (self.phoneStr.length > 0) {
                cell.inputTF.text = self.phoneStr;
            }else{
                cell.inputTF.text = @"";
            }
            
        }else if (indexPath.row == 3){
            
            //婚期
            cell.titleLabel.text = @"婚期";
            cell.inputTF.enabled = NO;
            cell.inputTF.placeholder = @"选择婚期";
            if (self.selectTime.length > 0) {
                cell.inputTF.text = self.selectTime;
            }else{
                cell.inputTF.text = @"";
            }
            
        }else if (indexPath.row == 4){
            
            cell.titleLabel.text = @"预算";
            cell.inputTF.placeholder = @"输入预算";
            cell.inputTF.enabled = YES;
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
            
            if (self.yusuanStr.length > 0) {
                cell.inputTF.text = self.yusuanStr;
            }else{
                cell.inputTF.text = @"";
            }
            
        }else if (indexPath.row == 5){
            
            cell.titleLabel.text = @"合作婚庆公司";
            cell.inputTF.placeholder = @"输入您的合作婚庆公司";
            cell.inputTF.enabled = YES;
            
            if (self.corpName.length > 0) {
                cell.inputTF.text = self.corpName;
            }else{
                cell.inputTF.text = @"";
            }
            
        }else if (indexPath.row == 6){
            
            cell.titleLabel.text = @"酒店";
            cell.inputTF.placeholder = @"输入婚礼酒店";
            cell.inputTF.enabled = YES;
            
            if (self.hotelStr.length > 0) {
                cell.inputTF.text = self.hotelStr;
            }else{
                cell.inputTF.text = @"";
            }
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        //婚期
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            self.selectTime = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 1001) {
        self.nameStr = textField.text;
    }else if (textField.tag == 1002){
        self.phoneStr = textField.text;
    }else if (textField.tag == 1004){
        self.yusuanStr = textField.text;
    }else if (textField.tag == 1005){
        self.corpName = textField.text;
    }else if (textField.tag == 1006){
        self.hotelStr = textField.text;
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)upBtnClick{
    NSLog(@"提交");
    
    self.submitBlock();
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self WeddingAmountApplication];
}

#pragma mark - 网络请求
#pragma mark 婚礼返还额度申请
- (void)WeddingAmountApplication{
        
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/WeddingAmountApplication";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"UserId"] = UserId_New;
    params[@"Name"] = self.nameStr;
    params[@"Phone"] = self.phoneStr;
    params[@"Wedding"] = self.selectTime;
    params[@"AmountWedding"] = self.yusuanStr;
    params[@"WeddingCompanyName"] = self.corpName;
    params[@"HotelId"] = self.hotelStr;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"申请成功"];
            
            self.submitBlock();
            [self.navigationController popViewControllerAnimated:YES];
            
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
