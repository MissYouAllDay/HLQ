//
//  YPFaBuKeYuanViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/4/1.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPFaBuKeYuanViewController.h"
#import "YPFBKYTwoBtnCell.h"
#import "YPFBKYInputCell.h"
#import <BRDatePickerView.h>
#import "CJAreaPicker.h"//地址选择

@interface YPFaBuKeYuanViewController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

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

@implementation YPFaBuKeYuanViewController{
    UIView *_navView;

    UITextField *_nameTF;
    UITextField *_phoneTF;
    NSString *_date;
    UITextField *_zhuoshuTF;
    UITextField *_canbiaoTF;
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
    [self setupNav];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).mas_offset(18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"发布客源";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *fabuBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [fabuBtn setTitle:@"发布需求" forState:UIControlStateNormal];
    [fabuBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [fabuBtn setBackgroundColor:CHJ_RedColor];
    fabuBtn.layer.cornerRadius = 4;
    fabuBtn.clipsToBounds = YES;
    fabuBtn.titleLabel.font = kFont(16);
    [fabuBtn addTarget:self action:@selector(fabuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:fabuBtn];
    [fabuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88, 32));
        make.right.mas_equalTo(-18);
        make.centerY.mas_equalTo(titleLab);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
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
    }else if (indexPath.row == 1){
        YPFBKYInputCell *cell = [YPFBKYInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameTF = cell.inputTF;
        cell.inputTF.enabled = YES;
        cell.inputTF.placeholder = @"请输入姓名";
        cell.titleLable.text = @"姓名";
        cell.endLabel.hidden = YES;
        return cell;
    }else if (indexPath.row == 2){
        YPFBKYInputCell *cell = [YPFBKYInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _phoneTF = cell.inputTF;
        cell.inputTF.enabled = YES;
        cell.inputTF.placeholder = @"请输入电话";
        cell.titleLable.text = @"电话";
        cell.endLabel.hidden = YES;
        return cell;
    }else if (indexPath.row == 3){
        YPFBKYInputCell *cell = [YPFBKYInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.inputTF.enabled = NO;
        cell.titleLable.text = @"婚期";
        cell.inputTF.placeholder = @"请选择婚期";
        cell.endLabel.hidden = YES;
        if (_date.length > 0) {
            cell.inputTF.text = _date;
        }else{
            cell.inputTF.text = @"";
        }
        return cell;
    }else if (indexPath.row == 4){
        YPFBKYInputCell *cell = [YPFBKYInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _zhuoshuTF = cell.inputTF;
        cell.inputTF.enabled = YES;
        cell.titleLable.text = @"桌数";
        cell.inputTF.placeholder = @"请输入桌数";
        cell.endLabel.hidden = NO;
        cell.endLabel.text = @"桌";
        return cell;
    }else if (indexPath.row == 5){
        YPFBKYInputCell *cell = [YPFBKYInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _canbiaoTF = cell.inputTF;
        cell.inputTF.enabled = YES;
        cell.titleLable.text = @"餐标";
        cell.inputTF.placeholder = @"请输入餐标";
        cell.endLabel.hidden = NO;
        cell.endLabel.text = @"元/桌";
        return cell;
    }else{
        YPFBKYInputCell *cell = [YPFBKYInputCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.inputTF.enabled = NO;
        cell.titleLable.text = @"区域";
        cell.inputTF.placeholder = @"请选择区域";
        cell.endLabel.hidden = YES;
        if (self.cityInfo.length > 0) {
            cell.inputTF.text = self.cityInfo;
        }else{
            cell.inputTF.text = @"";
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            _date = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else if (indexPath.row == 6){
        //地区
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
    }
}

#pragma mark - target
- (void)backVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fabuBtnClick{
    NSLog(@"fabuBtnClick");
    [self CreateJSJTable];
}

- (void)twoBtnClick:(UIButton *)sender{
    if (sender.tag == 1001) {
        _select = 0;
    }else if (sender.tag == 1002){
        _select = 1;
    }
    [self.tableView reloadRow:0 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 网络请求
#pragma mark 增加客源数据
- (void)CreateJSJTable{
    
    NSString *url = @"/api/HQOAApi/CreateJSJTable";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"Name"] = _nameTF.text;//0待处理,1有意向,2已合作,3已拒单,4修改备注
    params[@"phone"] = _phoneTF.text;
    params[@"Weddtime"] = _date;
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

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
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
        
        //6-5
        //        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
        //        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
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
