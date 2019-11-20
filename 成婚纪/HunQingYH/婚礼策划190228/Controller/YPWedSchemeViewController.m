//
//  YPWedSchemeViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/28.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPWedSchemeViewController.h"
#import "YPWedSchemeHeadCell.h"
#import "YPGetWeddingPlanning.h"
#import "YPGetWeddingPackageList.h"
#import "YPWedSchemeThreeBtnCell.h"
#import "YPHome180904TaoCanAllListCell.h"
#import "YPReReHomeWedPackageDetailController.h"
#import "YPHome1809004TaoCanListController.h"
#import "UIImage+YPGradientImage.h"
#import "YPGetDemoPlanList.h"
#import "YPHome180904TaoCanListCell.h"
#import "YPReHomePlanDetailController.h"
#import "YPAllPictureViewController.h"
#import "YPSupplierHomePage181119Controller.h"
#pragma mark - Third
#import "FL_Button.h"
#import "CJAreaPicker.h"//地址选择

@interface YPWedSchemeViewController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YPGetWeddingPlanning *infoModel;
/**套餐模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWeddingPackageList *> *listMarr;
/** 共享方案 */
@property (nonatomic, strong) NSMutableArray<YPGetDemoPlanList *> *gxMarr;

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

@implementation YPWedSchemeViewController{
    UIView *_navView;
    FL_Button *navAddressBtn;
    //数据库
    FMDatabase *dataBase;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self GetWeddingPlanning];
    if (!UserId_New) {
        [self.navigationController.tabBarController setSelectedIndex:0];
        
    }
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
    [self setupNav];
    [self setupUI];
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //导航栏地址选择按钮
    navAddressBtn = [FL_Button fl_shareButton];
    [navAddressBtn setBackgroundColor:[UIColor whiteColor]];
    [navAddressBtn setImage:[UIImage imageNamed:@"home_loc"] forState:UIControlStateNormal];
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    [navAddressBtn setTitle:self.cityInfo forState:UIControlStateNormal];
    
    [navAddressBtn setTitleColor:RGBS(72) forState:UIControlStateNormal];//2-9 修改
    [navAddressBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    navAddressBtn.status = FLAlignmentStatusLeft;
    navAddressBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [_navView addSubview:navAddressBtn];
    [navAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).offset(18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"婚礼策划";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(navAddressBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-HOME_INDICATOR_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
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
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    // 第一个参数为是否开启边缘手势，开启则默认从边缘50距离内有效，第二个block为手势过程中我们希望做的操作
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        
        SliderMeViewController *mevc =[SliderMeViewController new];
        [self cw_showDefaultDrawerViewController:mevc];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return self.gxMarr.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YPWedSchemeHeadCell *cell = [YPWedSchemeHeadCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.bgImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.Banner] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.FacilitatorImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            if (self.infoModel.FacilitatorName.length > 0) {
                cell.titleLabel.text = self.infoModel.FacilitatorName;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            if (self.infoModel.FacilitatorAddress.length > 0) {
                cell.address.text = self.infoModel.FacilitatorAddress;
            }else{
                cell.address.text = @"无地址";
            }
            [cell.btn addTarget:self action:@selector(supplierBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            YPWedSchemeThreeBtnCell *cell = [YPWedSchemeThreeBtnCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.btn1.tag = 1001;
            cell.btn2.tag = 1002;
            cell.btn3.tag = 1003;
            [cell.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }else if (indexPath.section == 1){
        YPGetDemoPlanList *list = self.gxMarr[indexPath.row];
        
        YPHome180904TaoCanAllListCell *cell = [YPHome180904TaoCanAllListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imgV1 sd_setImageWithURL:[NSURL URLWithString:list.ShowImg] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (list.PlanTitle.length > 0) {
            cell.titleLabel.text = list.PlanTitle;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        if (list.PlanKeyWord.length > 0) {
            cell.tag1.text = [list.PlanKeyWord stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        }else{
            cell.tag1.text = @"无关键字";
        }
        if (list.Color.length > 0) {
            cell.priceLabel.text = list.Color;
        }else{
            cell.priceLabel.text = @"无色系";
        }
        return cell;
    }else{
        YPHome180904TaoCanListCell *cell = [YPHome180904TaoCanListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.listArr = self.listMarr.copy;
        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
            NSLog(@"-----%zd",indexPath.item);
            if (indexPath.item > 0) {
                YPGetWeddingPackageList *list = self.listMarr[indexPath.row];
                //6-13 婚礼套餐
                YPReReHomeWedPackageDetailController *detail = [[YPReReHomeWedPackageDetailController alloc]init];
                detail.packageId = list.Id;
                [self.navigationController pushViewController:detail animated:YES];
            }
        };
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ScreenWidth*0.66;
        }else{
            return 110;
        }
    }else if (indexPath.section == 1){
        return ScreenWidth*0.77;
    }else{
        return (ScreenWidth-36)*0.85;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 50;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 50;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(18, 0, ScreenWidth-36, 40);
    [btn setTitle:@"查看全部方案" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
    [btn setBackgroundImage:[UIImage gradientImageWithBounds:btn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage gradientImageWithBounds:btn.frame andColors:@[[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0], [UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(allFanan) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 20;
    btn.clipsToBounds = YES;
    if (section == 0 || section == 2) {
        return nil;
    }
    [view addSubview:btn];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 22];
    if (section == 0) {
        return nil;
    }else if (section == 1){
        label.text = @"商家方案";
    }else if (section == 2){
        label.text = @"共享方案";
    }
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(view);
    }];
    if (section == 2){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.size = CGSizeMake(51, 16);
        [btn setTitle:@"价格更低" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 10];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:btn.bounds andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage gradientImageWithBounds:btn.bounds andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
        btn.enabled = NO;
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).mas_offset(6);
            make.centerY.mas_equalTo(label);
        }];
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (self.gxMarr.count > 0) {
            
            YPGetDemoPlanList *list = self.gxMarr[indexPath.row];
            YPReHomePlanDetailController *detail = [[YPReHomePlanDetailController alloc]init];
            detail.planID = list.PlanID;
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}

#pragma mark - target
- (void)cityBtnClick{
    //地区
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

- (void)supplierBtnClick{
    YPSupplierHomePage181119Controller *hotelVC = [[YPSupplierHomePage181119Controller alloc]init];
    hotelVC.FacilitatorID = self.infoModel.FacilitatorId;
    hotelVC.profession = HunQing_New;
    [self.navigationController pushViewController:hotelVC animated:YES];
}

- (void)btnClick:(UIButton *)sender{
    NSLog(@"%zd",sender.tag);
    YPAllPictureViewController *all = [[YPAllPictureViewController alloc]init];
    if (sender.tag == 1001) {
        all.titleStr = @"商家简介";
        all.imgStr = self.infoModel.AbstractData;
    }else if (sender.tag == 1002){
        all.titleStr = @"服务内容";
        all.imgStr = self.infoModel.ContentData;
    }else if (sender.tag == 1003){
        all.titleStr = @"新人评价";
        all.imgStr = self.infoModel.EvaluateData;
    }
    [self.navigationController pushViewController:all animated:YES];
}

- (void)allFanan{
    YPHome1809004TaoCanListController *list = [[YPHome1809004TaoCanListController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark - 网络请求
#pragma mark 婚礼策划
- (void)GetWeddingPlanning{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPlanning";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AreaId"] = self.areaid;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.infoModel.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            self.infoModel.UserId = [object valueForKey:@"UserId"];
            self.infoModel.FacilitatorName = [object valueForKey:@"FacilitatorName"];
            self.infoModel.FacilitatorAddress = [object valueForKey:@"FacilitatorAddress"];
            self.infoModel.FacilitatorImage = [object valueForKey:@"FacilitatorImage"];
            self.infoModel.Banner = [object valueForKey:@"Banner"];
            self.infoModel.AbstractData = [object valueForKey:@"AbstractData"];
            self.infoModel.ContentData = [object valueForKey:@"ContentData"];
            self.infoModel.EvaluateData = [object valueForKey:@"EvaluateData"];
            
            [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            [self GetPlanList];
            [self GetWeddingPackageList];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showText:@"网络错误,请稍后重试!" inView:self.tableView];
        
    }];
    
}

#pragma mark 获取婚礼套餐列表
- (void)GetWeddingPackageList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Type"] = @"1";//0全部，1上架，2下架
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.listMarr = [YPGetWeddingPackageList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showText:@"网络错误,请稍后重试!" inView:self.tableView];
    }];
    
}

#pragma mark 查看方案列表
- (void)GetPlanList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetNewPeoplePlanList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PlanTitle"]        = @"";//标题
    params[@"PlanKeyWord"]      = @"";//关键字
    params[@"Color"]            = @"";//全部传空
    params[@"PageIndex"]        = @"1";
    params[@"PageCount"]        = @"5";
    //10-26 添加-筛选 5-24 改正序
    params[@"OrderStart"]       = @"1";//0倒序、1正序
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.gxMarr removeAllObjects];
            self.gxMarr = [YPGetDemoPlanList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]];
        }
        
    } Failure:^(NSError *error) {
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
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

- (YPGetWeddingPlanning *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetWeddingPlanning alloc]init];
    }
    return _infoModel;
}

- (NSMutableArray<YPGetWeddingPackageList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray<YPGetDemoPlanList *> *)gxMarr{
    if (!_gxMarr) {
        _gxMarr = [NSMutableArray array];
    }
    return _gxMarr;
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
    [self GetWeddingPlanning];
    
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
    
    [navAddressBtn setTitle:self.cityInfo forState:UIControlStateNormal];
    
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
