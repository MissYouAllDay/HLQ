//
//  CXUserReceiveVC.m
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 用户领取伴手礼 - - - - - - - - - - - - - - - - - -

#import "CXUserReceiveVC.h"
#import "BRDatePickerView.h"
#import "CXInputCell.h"     // 输入文本框
#import "CXTitleAndDetailCell.h" // 默认文本框
#import "YPGetFacilitatorFlowRecord.h"   //  model

@interface CXUserReceiveVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *topImg;
@property (nonatomic, strong) UIView *tableViewFootView;
@property (nonatomic, strong) YPGetFacilitatorFlowRecord *model;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) UIButton *subBtn; // 提交按钮

@end

@implementation CXUserReceiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我要领取";
    self.titleArr = @[@"姓        名",@"手 机 号",@"婚        期",@"桌        数",@"餐        标",@"意向酒店"];
    self.detailArr = @[@"请输入姓名",@"请输入手机号",@"请选择婚期",@"请输入桌数",@"请输入餐标",@"其输入酒店名称"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - STATUS_BAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.tableViewFootView;
        _tableView.tableHeaderView = self.topImg;
        _tableView.backgroundColor =  [UIColor colorWithHexString:@"#F5F5F5"];
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}
#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    // 婚期。 桌数
//    if (indexPath.row == 2 || indexPath.row == 3) {
//        CXTitleAndDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXTitleAndDetailCell"];
//        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"CXTitleAndDetailCell" owner:nil options:nil] lastObject];
//        }
//        cell.nameLab.text = self.titleArr[indexPath.row];
//        cell.detailLab.text = self.detailArr[indexPath.row];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    
    CXInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXInputCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXInputCell" owner:nil options:nil] lastObject];
    }
    cell.nameLab.text = self.titleArr[indexPath.row];
    cell.inoutTF.placeholder = self.detailArr[indexPath.row];
    cell.inoutTF.delegate = self;
    cell.inoutTF.tag = indexPath.row + 1000;
    
    
    switch (indexPath.row) {
        case 0:  cell.inoutTF.text = self.model.UserName;  break;
        case 1:  cell.inoutTF.text = self.model.Phone;  break;
        case 2:  cell.inoutTF.text = self.model.WeddingDate;  break;
        case 3:  cell.inoutTF.text = self.model.TablesNumber;  break;
        case 4:  cell.inoutTF.text = self.model.MealMark;  break;
        case 5:  cell.inoutTF.text = self.model.Meno;  break;
        default:  break;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 1002 ) {
        [CXDataManager hiddenKeyBoard];
        [self selectDate ];
        return NO;
    }
    if (textField.tag == 1003 ) {
        [CXDataManager hiddenKeyBoard];
        [self showTabNumAlert ];
        return NO;
    }
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    switch (textField.tag - 1000) {
        case 0: self.model.UserName = textField.text; break;
        case 1: self.model.Phone = textField.text; break;
        case 4: self.model.MealMark = textField.text; break;
        case 5: self.model.Meno = textField.text; break;
        default:
            break;
    }
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return Line375(55);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        [self selectDate];
    }
    if ( indexPath.row == 3) {
        [self showTabNumAlert];
    }
}

#pragma mark - - - - - - - - - - - - - - - 选择日期。 选择桌数 - - - - - - - - - - - - - - - - -
- (void)selectDate {
    
    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
        NSString *text = [NSString stringWithFormat:@"%@  年  %@  月  %@  日",arr[0],arr[1],arr[2]];
        self.model.WeddingDate =  [NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]];
        
        CXInputCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.inoutTF.text = text;
        
    }];
}

- (void)showTabNumAlert {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 1; i < 101; i ++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%d  桌",i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            CXTitleAndDetailCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
//            cell.detailLab.text = [NSString stringWithFormat:@"%d  桌",i];
            CXInputCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.inoutTF.text =  [NSString stringWithFormat:@"%d  桌",i];
            self.model.TablesNumber = [NSString stringWithFormat:@"%d",i];
        }];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - - - - - - - - - - - - - - - 提交数据 - - - - - - - - - - - - - - - - -
- (void)subBtnAction:(UIButton *)sender {
    
    if (![YPGetFacilitatorFlowRecord checkouUserSubData:self.model]) { return;  }
    
    NSString *url = @"/api/HQOAApi/CreateJSJTable";
    NSDictionary *param = [YPGetFacilitatorFlowRecord changeInputInfoToSubData:self.model];
     [EasyShowLodingView showLoding];
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:param Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
            
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


#pragma mark - - - - - - - - - - - - - - - 懒蛋 - - - - - - - - - - - - - - - - -
- (UIView *)tableViewFootView {
    if (!_tableViewFootView) {
        _tableViewFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tableViewFootView addSubview:subBtn];

        subBtn.frame = CGRectMake((ScreenWidth - Line375(80))/2, 0, Line375(80), Line375(30));
        [subBtn setTitle:@"提交" forState:UIControlStateNormal];
        
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = subBtn.bounds;
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[RGB(255, 0, 123) CGColor],(id)[RGB(255, 83, 103) CGColor]]];//渐变数组
        [subBtn.layer addSublayer:gradientLayer];
        [subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        subBtn.layer.cornerRadius = 5;
        subBtn.clipsToBounds = YES;
    }
    return _tableViewFootView;
}

- (UIImageView *)topImg {
    
    if (!_topImg) {
        _topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(77))];
        _topImg.image = [UIImage imageNamed:@"revice"];
    }
    return _topImg;
}


- (YPGetFacilitatorFlowRecord *)model {
    
    if (!_model) {
        _model = [[YPGetFacilitatorFlowRecord alloc] init];
        _model.IdentityId = UserId_New;
    }
    return _model;
}


@end
