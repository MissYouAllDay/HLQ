//
//  YPReActivityHunQingDingZhiController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityHunQingDingZhiController.h"
#import "YPReActivityDingZhiInputCell.h"
#import "YPReActivityDingZhiTypeCell.h"
#import "YPAddRemarkController.h"//添加备注
#import "BRDatePickerView.h"
#import "CJAreaPicker.h"//地址选择
#import "YPContractController.h"//联系我们

@interface YPReActivityHunQingDingZhiController ()<UITableViewDelegate,UITableViewDataSource,YPAddRemarkDelegate,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

//*************************************************
@property (nonatomic, copy) NSString *jiage;
@property (nonatomic, copy) NSString *hunqi;
@property (nonatomic, copy) NSString *beizhu;
//*************************************************
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

@implementation YPReActivityHunQingDingZhiController{
    UIView *_navView;
    //数据库
    FMDatabase *dataBase;
    
    //定制类别
    UIButton *_xinrenBtn;//新人
    UIButton *_benrenBtn;//本人
}

#pragma mark - 隐藏导航栏
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

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    }
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
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
    titleLab.text = self.titleStr;
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPReActivityDingZhiInputCell *cell = [YPReActivityDingZhiInputCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"区域";
        if (self.cityInfo.length > 0) {
            cell.contentLabel.text = self.cityInfo;
            cell.contentLabel.textColor = BlackColor;
        }else{
            cell.contentLabel.text = @"请选择您所在区域";
            cell.contentLabel.textColor = LightGrayColor;
        }
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"婚期";
        if (self.hunqi.length > 0) {
            cell.contentLabel.text = self.hunqi;
            cell.contentLabel.textColor = BlackColor;
        }else{
            cell.contentLabel.text = @"请选择您的婚期";
            cell.contentLabel.textColor = LightGrayColor;
        }
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"婚礼预算";
        if (self.jiage.length > 0) {
            cell.contentLabel.text = self.jiage;
            cell.contentLabel.textColor = BlackColor;
        }else{
            cell.contentLabel.text = @"请填写您的婚礼预算";
            cell.contentLabel.textColor = LightGrayColor;
        }
    }else if (indexPath.row == 3) {
        cell.titleLabel.text = @"备注";
        if (self.beizhu.length > 0) {
            cell.contentLabel.text = self.beizhu;
            cell.contentLabel.textColor = BlackColor;
        }else{
            cell.contentLabel.text = @"请填写您的特殊需求";
            cell.contentLabel.textColor = LightGrayColor;
        }
    }
//        else if (indexPath.row == 4) {
//        YPReActivityDingZhiTypeCell *cell = [YPReActivityDingZhiTypeCell cellWithTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        [cell.xinrenBtn addTarget:self action:@selector(xinrenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.benrenBtn addTarget:self action:@selector(benrenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        _xinrenBtn = cell.xinrenBtn;
//        _benrenBtn = cell.benrenBtn;
//
//        _benrenBtn.backgroundColor = RGBA(211, 169, 119, 1);
//        [_benrenBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//        _xinrenBtn.backgroundColor = RGBA(244, 244, 244, 1);
//        [_xinrenBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
//
//        return cell;
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return ScreenWidth*0.5;
    }else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return ScreenWidth*0.5;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingzhi_bg"]];
        [view addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(view);
        }];
        return view;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"推荐福利";
//        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
//        label.textColor = [UIColor colorWithRed:240/255.0 green:208/255.0 blue:167/255.0 alpha:1];
//        [view addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
//            make.left.mas_equalTo(15);
//        }];

        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @"请填写您的信息及需求，以备我们为您带来更为优质的婚礼服务！";
        label2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        label2.textColor = [UIColor colorWithRed:240/255.0 green:208/255.0 blue:167/255.0 alpha:1];
        label2.numberOfLines = 0;
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];

        UIButton *phoneBtn = [[UIButton alloc]init];
        [phoneBtn setImage:[UIImage imageNamed:@"dingzhi_phoneBtn"] forState:UIControlStateNormal];
        [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label2.mas_bottom).mas_offset(30);
            make.width.mas_equalTo((ScreenWidth-15*2-20)*0.5);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(50);
        }];
        
        UIButton *subBtn = [[UIButton alloc]init];
        [subBtn setImage:[UIImage imageNamed:@"dingzhi_submit"] forState:UIControlStateNormal];
//        [subBtn setImage:[UIImage imageNamed:@"dingzhiSubmitBtn"] forState:UIControlStateNormal];
        [subBtn addTarget:self action:@selector(subBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:subBtn];
        [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label2.mas_bottom).mas_offset(30);
//            make.top.mas_equalTo(100);
            make.width.mas_equalTo((ScreenWidth-15*2-20)*0.5);
//            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(50);
        }];
        
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {//区域
        
        //地区
        CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
        picker.delegate = self;
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:navc animated:YES completion:nil];
        
    }else if (indexPath.row == 1) {//婚期
        
        [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
            self.hunqi = selectValue;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }else if (indexPath.row == 2) {//价格
        YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
        addRemark.remarkDelegate = self;
        addRemark.titleStr = @"心理价格";
        addRemark.placeHolder = @"请填写心理价格";
        addRemark.limitCount = 30;
        addRemark.dingzhiTag = @"jiage";
        [self.navigationController pushViewController:addRemark animated:YES];
    }else if (indexPath.row == 3) {//备注
        YPAddRemarkController *addRemark = [[YPAddRemarkController alloc]init];
        addRemark.remarkDelegate = self;
        addRemark.titleStr = @"备注";
        addRemark.placeHolder = @"请填写备注";
        addRemark.limitCount = 150;
        addRemark.dingzhiTag = @"beizhu";
        [self.navigationController pushViewController:addRemark animated:YES];
    }
}

#pragma mark - YPAddRemarkDelegate
- (void)yp_PersonOrder:(NSString *)content AndTag:(NSString *)tag{
    if ([tag isEqualToString:@"jiage"]) {
        self.jiage = content;
    }else if ([tag isEqualToString:@"beizhu"]) {
        self.beizhu = content;
    }
    [self.tableView reloadData];
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
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)subBtnClick{
    NSLog(@"提交");
    
    [self AddFacilitatorCustomMade];
}

- (void)phoneBtnClick{
    NSLog(@"phoneBtnClick");
    
    YPContractController *contract = [[YPContractController alloc]init];
    [self presentViewController:contract animated:YES completion:nil];
}

- (void)xinrenBtnClick:(UIButton *)sender{
    
    _xinrenBtn.backgroundColor = RGBA(211, 169, 119, 1);
    [_xinrenBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    _benrenBtn.backgroundColor = RGBA(244, 244, 244, 1);
    [_benrenBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    
}

- (void)benrenBtnClick:(UIButton *)sender{
    _benrenBtn.backgroundColor = RGBA(211, 169, 119, 1);
    [_benrenBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    _xinrenBtn.backgroundColor = RGBA(244, 244, 244, 1);
    [_xinrenBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
}

#pragma mark - 网络请求
#pragma mark 添加私人订制
- (void)AddFacilitatorCustomMade{
    
    NSString *url = @"/api/HQOAApi/AddFacilitatorCustomMade";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Profession"] = self.IdentityId;
    params[@"UserId"] = UserId_New;
    if (self.areaid.length > 0) {
        params[@"RegionId"] = self.areaid;
    }else{
        params[@"RegionId"] = areaID_New;
    }
    if (self.hunqi.length > 0) {
        params[@"MarriagePeriod"] = self.hunqi;
    }else{
        params[@"MarriagePeriod"] = @"";
    }
    if (self.jiage.length > 0) {
        params[@"PsychologicalPrice"] = self.jiage;
    }else{
        params[@"PsychologicalPrice"] = @"";
    }
    
    params[@"TableNumber"] = @"";
    
    if (self.beizhu.length > 0) {
        params[@"Remarks"] = self.beizhu;
    }else{
        params[@"Remarks"] = @"";
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showText:@"提交成功!" inView:self.tableView];
            
            [self.navigationController popViewControllerAnimated:YES];
            
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
        self.areaid =[[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}
-(NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo = @"黄岛区";
    }
    return _cityInfo;
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
