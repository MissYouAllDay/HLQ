//
//  YPKeYuan190514PublishRingController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/14.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190514PublishRingController.h"
#import "YPInviteFriendsWedInputCell.h"
#import "YPInviteFriendsWedPhoneInputCell.h"
#import "BRDatePickerView.h"
#import "UIImage+YPGradientImage.h"
#import "CJAreaPicker.h"//地址选择
#import "YPFBKYTwoBtnCell.h"

@interface YPKeYuan190514PublishRingController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**新人姓名*/
@property (nonatomic, strong) UITextField *mannameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *manphoneTF;
/**新人姓名*/
@property (nonatomic, strong) UITextField *womannameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *womanphoneTF;
/**桌数*/
@property (nonatomic, strong) UITextField *zhuoshuTF;
/**餐标*/
@property (nonatomic, strong) UITextField *canbiaoTF;
/**新人婚期*/
@property (nonatomic, copy) NSString *dateStr;
/**桌数*/
@property (nonatomic, copy) NSString *zhuoshu;
/**餐标*/
@property (nonatomic, copy) NSString *canbiao;

@property (nonatomic, copy) NSString *mannameStr;
@property (nonatomic, copy) NSString *manphoneStr;
@property (nonatomic, copy) NSString *womannameStr;
@property (nonatomic, copy) NSString *womanphoneStr;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

@end

@implementation YPKeYuan190514PublishRingController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    NSInteger _select;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"只要您未定酒店或者未定婚庆的任何一项皆可领取" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    [self setupUI];
    [self setupNav];
}

#pragma mark - UI
#pragma mark - UI
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
    titleLab.text = @"免费对戒";
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
    [btn setTitle:@"免费领取, 提交" forState:UIControlStateNormal];
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
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50-HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"新郎姓名";
        cell.inputTF.placeholder = @"请输入新郎姓名";
        cell.inputTF.keyboardType = UIKeyboardTypeDefault;
        cell.inputTF.enabled = YES;
        self.mannameTF = cell.inputTF;
        if (self.mannameStr.length > 0) {
            self.mannameTF.text = self.mannameStr;
        }else{
            self.mannameTF.text = @"";
        }
        cell.addressBook.hidden = YES;
//        cell.addressBook.tag = 1000;
//        [cell.addressBook addTarget:self action:@selector(addressBookClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 1){
        cell.titleLabel.text = @"新郎手机";
        cell.inputTF.placeholder = @"请输入新郎手机";
        cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
        cell.inputTF.enabled = YES;
        self.manphoneTF = cell.inputTF;
        if (self.manphoneStr.length > 0) {
            self.manphoneTF.text = self.manphoneStr;
        }else{
            self.manphoneTF.text = @"";
        }
    }else if (indexPath.row == 2) {
        YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"新娘姓名";
        cell.inputTF.placeholder = @"请输入新娘姓名";
        cell.inputTF.keyboardType = UIKeyboardTypeDefault;
        cell.inputTF.enabled = YES;
        self.womannameTF = cell.inputTF;
        if (self.womannameStr.length > 0) {
            self.womannameTF.text = self.womannameStr;
        }else{
            self.womannameTF.text = @"";
        }
        cell.addressBook.hidden = YES;
//        cell.addressBook.tag = 2000;
//        [cell.addressBook addTarget:self action:@selector(addressBookClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 3){
        cell.titleLabel.text = @"新娘手机";
        cell.inputTF.placeholder = @"请输入新娘手机";
        cell.inputTF.keyboardType = UIKeyboardTypePhonePad;
        cell.inputTF.enabled = YES;
        self.womanphoneTF = cell.inputTF;
        if (self.womanphoneStr.length > 0) {
            self.womanphoneTF.text = self.womanphoneStr;
        }else{
            self.manphoneTF.text = @"";
        }
    }else if (indexPath.row == 4){
        cell.titleLabel.text = @"婚期";
        cell.inputTF.placeholder = @"请选择新人婚期";
        cell.inputTF.enabled = NO;
        if (self.dateStr.length > 0) {
            cell.inputTF.text = self.dateStr;
        }else{
            cell.inputTF.text = @"";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 5){
        cell.titleLabel.text = @"桌数";
        cell.inputTF.placeholder = @"请输入桌数";
        cell.inputTF.enabled = YES;
        self.zhuoshuTF = cell.inputTF;
        if (self.zhuoshu.length > 0) {
            self.zhuoshuTF.text = self.zhuoshu;
        }else{
            self.zhuoshuTF.text = @"";
        }
    }else if (indexPath.row == 6){
        cell.titleLabel.text = @"餐标";
        cell.inputTF.placeholder = @"请输入大概的餐标预算";
        cell.inputTF.enabled = YES;
        self.canbiaoTF = cell.inputTF;
        if (self.canbiao.length > 0) {
            self.canbiaoTF.text = self.canbiao;
        }else{
            self.canbiaoTF.text = @"";
        }
    }else if (indexPath.row == 7){
        YPFBKYTwoBtnCell *cell = [YPFBKYTwoBtnCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hotelBtn.tag = 1001;
        cell.hunqingBtn.tag = 1002;
        if (_select == 0) {
            cell.hotelBtn.selected = YES;
            cell.hunqingBtn.selected = NO;
        }else{
            cell.hotelBtn.selected = NO;
            cell.hunqingBtn.selected = YES;
        }
        [cell.hotelBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.hunqingBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 8){
        cell.titleLabel.text = @"区域";
        cell.inputTF.text = @"请选择区域";
        cell.inputTF.enabled = NO;
        cell.inputTF.text = self.cityInfo;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 7) {
        return 64;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 4) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.row == 8){
        //地区
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addressBookClick:(UIButton *)sender{
    YPAddressBookTool *tool = [YPAddressBookTool yp_shareAddressBookTool];
    tool.vc = self;
    [tool JudgeAddressBookPower];
    tool.successBlock = ^(NSDictionary * _Nonnull object) {
        NSMutableString *phone = [object[@"phone"] stringByReplacingOccurrencesOfString:@"-" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""].mutableCopy;
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""].mutableCopy;
        if (sender.tag == 1000) {
            self.mannameStr = object[@"name"];
            self.manphoneStr = phone.copy;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else if (sender.tag == 2000){
            self.womannameStr = object[@"name"];
            self.womanphoneStr = phone.copy;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    };
}

- (void)submitBtnClick{
    [self CreateNewPeopleFree];
}

- (void)twoBtnClick:(UIButton *)sender{
    if (sender.tag == 1001) {
        _select = 0;
    }else if (sender.tag == 1002){
        _select = 1;
    }
    [self.tableView reloadRow:7 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 网络请求
#pragma mark 新增新人免费领对戒
- (void)CreateNewPeopleFree{
    
    NSString *url = @"/api/HQOAApi/CreateNewPeopleFree";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"ManName"] = self.mannameTF.text;
    params[@"ManPhone"] = self.manphoneTF.text;
    params[@"WomenName"] = self.womannameTF.text;
    params[@"WomenPhone"] = self.womanphoneTF.text;
    params[@"WeddingTime"] = self.dateStr;
    params[@"CreateTime"] = @"";
    if (_select == 0) {
        params[@"NeedFacilitatorId"] = JiuDian_New;
    }else{
        params[@"NeedFacilitatorId"] = HunQing_New;
    }
    params[@"TablesNumber"] = _zhuoshuTF.text;
    params[@"MealStandard"] = _canbiaoTF.text;
    params[@"Area"] = self.areaid;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"提交成功,稍后我们的客服人员会联系您,请保持手机畅通!" inView:self.tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backVC];
            });
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
    }];
    
}

#pragma mark - getter
-(NSString *)areaid{
    if (!_areaid) {
        self.areaid = [[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
    //    [self GetWeddingPlanning];
    
}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);
    
    NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }
    
}
//打开数据库
- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库成功");
    }
    
}
//关闭数据库
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadRow:8 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    
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
