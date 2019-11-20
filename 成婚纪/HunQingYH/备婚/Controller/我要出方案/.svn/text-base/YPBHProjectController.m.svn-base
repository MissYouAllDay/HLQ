//
//  YPBHProjectController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPBHProjectController.h"
#import "YPBHProjectTwoBtnCell.h"
#import "YPBorderInputCell.h"
#import "YPBordHeadInputCell.h"
#import "YPNewlywedsController.h"//新婚档案

@interface YPBHProjectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *inviteCodeTF;
@property (nonatomic, strong) UITextField *otherPhoneTF;

@property (nonatomic, assign) NSInteger typeNum;

@end

@implementation YPBHProjectController{
    UIView *_navView;
    UIButton *_manBtn;
    UIButton *_womanBtn;
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
    _navView.backgroundColor = CHJ_bgColor;
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
    titleLab.text = @"免费领仪式对戒";//18-09-21 修改
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 6;
    return 5;//18-09-21 暂时隐藏 邀请码
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YPBHProjectTwoBtnCell *cell = [YPBHProjectTwoBtnCell cellWithTableView:tableView];
        cell.backgroundColor = CHJ_bgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.manBtn addTarget:self action:@selector(manBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.womanBtn addTarget:self action:@selector(womanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _manBtn = cell.manBtn;
        _womanBtn = cell.womanBtn;
        
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 2){
        YPBorderInputCell *cell = [YPBorderInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"姓   名";
            cell.inputTF.placeholder = @"请输入姓名";
            self.nameTF = cell.inputTF;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"手   机";
            cell.inputTF.placeholder = @"请输入手机号";
            self.phoneTF = cell.inputTF;
        }
        //18-09-21 暂时隐藏
//        else if (indexPath.row == 3){
//            cell.titleLabel.text = @"邀请码(选填)";
//            cell.inputTF.placeholder = @"请输入邀请码";
//            self.inviteCodeTF = cell.inputTF;
//        }
        return cell;
    }else if (indexPath.row == 3){
        
        YPBordHeadInputCell *cell = [YPBordHeadInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"TA 的手机";
        cell.inputTF.placeholder = @"请输入TA的手机号";
        self.otherPhoneTF = cell.inputTF;
        
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = CHJ_bgColor;
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [doneBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [doneBtn setBackgroundColor:NavBarColor];
        [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:doneBtn];
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(50);
            make.right.bottom.mas_equalTo(-50);
            make.height.mas_equalTo(50);
        }];
        doneBtn.layer.cornerRadius = 5;
        doneBtn.clipsToBounds = YES;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row == 3){
        return 120;
    }else if (indexPath.row == 4){
        return 150;
    }else {
        return 65;
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
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)manBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    self.typeNum = 1;
    
    if (sender.isSelected) {
        _womanBtn.selected = !sender.selected;
    }else if (_womanBtn.isSelected == NO && sender.isSelected == NO){
        sender.selected = YES;
    }
}

- (void)womanBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    self.typeNum = 2;
    
    if (sender.isSelected) {
        _manBtn.selected = !sender.selected;
    }else if (_manBtn.isSelected == NO && sender.isSelected == NO){
        sender.selected = YES;
    }
}

- (void)doneBtnClick{
    NSLog(@"完成");
    
    if (self.typeNum == 0) {

        [EasyShowTextView showText:@"请选择性别"];
        
    }else if (self.nameTF.text.length == 0){
        
        [EasyShowTextView showText:@"请填写姓名"];
        
    }else if (self.phoneTF.text.length == 0){
        
        [EasyShowTextView showText:@"请填写手机号"];
        
    }else if (self.otherPhoneTF.text.length == 0){
        
        [EasyShowTextView showText:@"请填写另一半的手机号"];
        
    }else {
        
        [self AddNewPeopleCustom];//添加订制
        
    }
}

#pragma mark - 网络请求
#pragma mark 添加新人订制
- (void)AddNewPeopleCustom{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddNewPeopleCustom";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    if (self.typeNum == 1) {//男
        
        params[@"AddType"]      = @"0";//提交者身份 0新郎,1新娘
        params[@"GroomName"]    = self.nameTF.text;//新郎姓名
        params[@"GroomPhone"]   = self.phoneTF.text;//新郎手机号
        params[@"BrideName"]    = @"";//新娘姓名
        params[@"BridePhone"]   = self.otherPhoneTF.text;//新娘手机号
        
    }else if (self.typeNum == 2){//女
        
        params[@"AddType"]      = @"1";//提交者身份 0新郎,1新娘
        params[@"GroomName"]    = @"";//新郎姓名
        params[@"GroomPhone"]   = self.otherPhoneTF.text;//新郎手机号
        params[@"BrideName"]    = self.nameTF.text;//新娘姓名
        params[@"BridePhone"]   = self.phoneTF.text;//新娘手机号
        
    }

    if (self.inviteCodeTF.text.length > 0) {
        params[@"InvitationCode"]   = self.inviteCodeTF.text;//邀请码
    }else{
        params[@"InvitationCode"]   = @"";//邀请码
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            YPNewlywedsController *weds = [[YPNewlywedsController alloc]init];
//            weds.typeNum = self.typeNum;
            [self.navigationController pushViewController:weds animated:YES];
            
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
