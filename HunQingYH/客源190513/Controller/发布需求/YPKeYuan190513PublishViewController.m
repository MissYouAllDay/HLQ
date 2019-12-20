//
//  YPKeYuan190513PublishViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/13.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190513PublishViewController.h"
#import "YPInviteFriendsWedInputCell.h"
#import "YPInviteFriendsWedPhoneInputCell.h"
#import "CJAreaPicker.h"//地址选择
#import "BRDatePickerView.h"
#import "UIImage+YPGradientImage.h"
#import "YPKeYuan190514PublishRingController.h"
#import "YPFBKYTwoBtnCell.h"

@interface YPKeYuan190513PublishViewController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**新人姓名*/
@property (nonatomic, strong) UITextField *nameTF;
/**新人手机*/
@property (nonatomic, strong) UITextField *phoneTF;
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

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *phoneStr;

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

@implementation YPKeYuan190513PublishViewController{
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
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, ScreenWidth, ScreenHeight-1-TabBarHeight) style:UITableViewStyleGrouped];
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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"keyuan190513_banner"]];
        [cell.contentView addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(cell.contentView);
        }];
        return cell;
    }else {
        YPInviteFriendsWedInputCell *cell = [YPInviteFriendsWedInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
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
        }else if (indexPath.row == 2) {
            YPInviteFriendsWedPhoneInputCell *cell = [YPInviteFriendsWedPhoneInputCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"姓名";
            cell.inputTF.placeholder = @"请输入姓名";
            cell.inputTF.keyboardType = UIKeyboardTypeDefault;
            cell.inputTF.enabled = YES;
            self.nameTF = cell.inputTF;
            if (self.nameStr.length > 0) {
                self.nameTF.text = self.nameStr;
            }else{
                self.nameTF.text = @"";
            }
            cell.addressBook.hidden = YES;
//            [cell.addressBook addTarget:self action:@selector(addressBookClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.row == 3){
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
            cell.titleLabel.text = @"区域";
            cell.inputTF.text = @"请选择区域";
            cell.inputTF.enabled = NO;
            cell.inputTF.text = self.cityInfo;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenWidth*0.4;
    }else if (indexPath.row == 1){
        return 64;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 50) andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:CGRectMake(0, 0, ScreenWidth, 50) andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 20;
        btn.clipsToBounds = YES;
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(28);
            make.right.mas_equalTo(-28);
            make.bottom.mas_equalTo(view);
            make.height.mas_equalTo(40);
        }];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        YPKeYuan190514PublishRingController *ring = [[YPKeYuan190514PublishRingController alloc]init];
        [self.navigationController pushViewController:ring animated:YES];
    }else if (indexPath.row == 4) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
            self.dateStr = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.row == 7){
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
    [self CreateJSJTable];
}

- (void)twoBtnClick:(UIButton *)sender{
    if (sender.tag == 1001) {
        _select = 0;
    }else if (sender.tag == 1002){
        _select = 1;
    }
    [self.tableView reloadRow:1 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 网络请求
#pragma mark 增加客源数据
- (void)CreateJSJTable{
    
    NSString *url = @"/api/HQOAApi/CreateJSJTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Name"] = _nameTF.text;//0待处理,1有意向,2已合作,3已拒单,4修改备注
    params[@"phone"] = _phoneTF.text;
    params[@"Weddtime"] = self.dateStr;
    params[@"Meno"] = @"";
    if (_select == 0) {
        params[@"IdentityId"] = JiuDian_New;
    }else{
        params[@"IdentityId"] = HunQing_New;
    }
    params[@"TablesNumber"] = _zhuoshuTF.text;
    params[@"MealMark"] = _canbiaoTF.text;
    params[@"AreaId"] = self.areaid;
    params[@"Source"] = @"1";//0官方,1个人
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showText:@"发布成功!" inView:self.tableView];
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
    
    [self.tableView reloadRow:7 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
    
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
