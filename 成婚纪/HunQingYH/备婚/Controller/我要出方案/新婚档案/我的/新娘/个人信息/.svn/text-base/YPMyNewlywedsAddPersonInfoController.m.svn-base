//
//  YPMyNewlywedsAddPersonInfoController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyNewlywedsAddPersonInfoController.h"
#import "YPImgInputCell.h"
#import "WSDatePickerView.h"

@interface YPMyNewlywedsAddPersonInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) JVFloatLabeledTextField *borthTimeTF;
@property (nonatomic, strong) JVFloatLabeledTextField *xingzuoTF;
@property (nonatomic, strong) JVFloatLabeledTextField *jiguanTF;
@property (nonatomic, strong) JVFloatLabeledTextField *zhiyeTF;
@property (nonatomic, strong) JVFloatLabeledTextField *qqTF;
@property (nonatomic, strong) JVFloatLabeledTextField *weChatTF;
@property (nonatomic, strong) JVFloatLabeledTextField *nameTF;
@property (nonatomic, strong) JVFloatLabeledTextField *phoneTF;

@end

@implementation YPMyNewlywedsAddPersonInfoController{
    UIView *_navView;
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
    titleLab.text = @"个人信息";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
//    //设置导航栏右边
//    UIButton *doneBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [doneBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [doneBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
//    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_navView addSubview:doneBtn];
//    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.right.mas_equalTo(-15);
//    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YPImgInputCell *cell = [YPImgInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.inputTF.placeholder = @"出生日期";
        cell.inputTF.enabled = NO;
        if (self.info.DateOfBirth.length > 0) {
            cell.inputTF.text = self.info.DateOfBirth;
        }
        
        self.borthTimeTF = cell.inputTF;

    }else if (indexPath.row == 1) {
        cell.inputTF.placeholder = @"星座";
        
        if (self.info.Constellation.length > 0) {
            cell.inputTF.text = self.info.Constellation;
        }
        
        self.xingzuoTF = cell.inputTF;
    }else if (indexPath.row == 2) {
        cell.inputTF.placeholder = @"籍贯";
        
        if (self.info.PlaceOfOrigin.length > 0) {
            cell.inputTF.text = self.info.PlaceOfOrigin;
        }
        
        self.jiguanTF = cell.inputTF;
    }else if (indexPath.row == 3) {
        cell.inputTF.placeholder = @"职业";
        
        if (self.info.Occupation.length > 0) {
            cell.inputTF.text = self.info.Occupation;
        }
        
        self.zhiyeTF = cell.inputTF;
    }else if (indexPath.row == 4) {
        cell.inputTF.placeholder = @"QQ";
        
        if (self.info.QQNumber.length > 0) {
            cell.inputTF.text = self.info.QQNumber;
        }
        
        self.qqTF = cell.inputTF;
    }else if (indexPath.row == 5) {
        cell.inputTF.placeholder = @"微信";
        
        if (self.info.WechatNumber.length > 0) {
            cell.inputTF.text = self.info.WechatNumber;
        }
        
        self.weChatTF = cell.inputTF;
    }else if (indexPath.row == 6) {
        cell.inputTF.placeholder = @"姓名";
        
        if (self.info.Name.length > 0) {
            cell.inputTF.text = self.info.Name;
        }
        
        self.nameTF = cell.inputTF;
    }else if (indexPath.row == 7) {
        cell.inputTF.placeholder = @"手机号";
        
        if (self.info.Phone.length > 0) {
            cell.inputTF.text = self.info.Phone;
        }
        
        self.phoneTF = cell.inputTF;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = CHJ_bgColor;
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:NavBarColor];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(view);
            make.right.mas_equalTo(-15);
        }];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            NSLog(@"选择的年月日：%@",date);
            
            self.borthTimeTF.text = date;
            
//            [self.tableView reloadData];
            
        }];
        datepicker.doneButtonColor = NavBarColor;
        datepicker.dateLabelColor = NavBarColor;
        
        [datepicker show];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)doneBtnClick{
//    NSLog(@"doneBtnClick");
//}

- (void)btnClick{
    NSLog(@"保存");
    
    [self UpNewPeopleInfo];
}

#pragma mark - 网络请求
#pragma mark 修改自己个人资料
- (void)UpNewPeopleInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/UpNewPeopleInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    params[@"Name"] = self.nameTF.text;
    params[@"DateOfBirth"] = self.borthTimeTF.text;
    params[@"PlaceOfOrigin"] = self.jiguanTF.text;
    params[@"Constellation"] = self.xingzuoTF.text;
    params[@"Occupation"] = self.zhiyeTF.text;
    params[@"Phone"] = self.phoneTF.text;
    params[@"QQNumber"] = self.qqTF.text;
    params[@"WechatNumber"] = self.weChatTF.text;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"修改成功!"];
            
            if ([self.addDelegate respondsToSelector:@selector(yp_addSuccess)]) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.addDelegate yp_addSuccess];
            }
            
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
