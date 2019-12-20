//
//  YPHomeController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPHomeController.h"
#import "CJAreaPicker.h"//城市选择
#import "DataSource.h"
#import "YANScrollMenu.h"
#import "FL_Button.h"
#import <BRPickerView.h>
#import "NSDate+BRAdd.h"
#import "HRHomeCell.h"
#import "HRHomeSearchViewController.h"
#import "HRHotelViewController.h"
//详情
#import "HRZhuChiXQViewController.h"
#import "HRZHiYeModel.h"
#import "HRGYSModel.h"
#define ItemHeight 90
#define IMG(name)           [UIImage imageNamed:name]

@interface YPHomeController ()<YANScrollMenuProtocol,UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,LLNoDataViewTouchDelegate>
{
     UIView *navView;
    UITableView *thistableView;
    NSInteger row;
    NSInteger item;
    FL_Button *topheaderSFBtn;
    FL_Button *topheaderAddressBtn;
    FL_Button *navTimeBtn;
    FMDatabase *dataBase;
    FL_Button *navAddressBtn;
    UILabel *messageLab;
    NSString *selectZhiYeName;
    
}
/**职业数组*/
@property(nonatomic,strong)NSMutableArray  *zhiYeArr;
/**供应商数组*/
@property(nonatomic,strong)NSMutableArray  *GYSArr;
@property(nonatomic,assign)NSInteger parentID;
@property(nonatomic,strong)NSString *selectZhiYeCode;
@property(nonatomic,strong)NSString *selectTime;
//@property (nonatomic, strong) YANScrollMenu *menu;
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray<DataSource *> *dataSource;
@end

@implementation YPHomeController
-(NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}
- (NSMutableArray<DataSource *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(NSMutableArray *)GYSArr{
    if (!_GYSArr) {
        _GYSArr =[NSMutableArray array];
           }
    return _GYSArr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectZhiYeCode =@"";
    NSDate *currentDate = [NSDate date];//获取当前日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    self.selectTime =[dateFormatter stringFromDate:currentDate];
    [self getZhiYeList];
     [self moveToDBFile];//迁移数据库
   
    row = 2;
    item = 5;
    
    
    [self createNav];
   
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];

    
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
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
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
   
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",huanCun,_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"AreaID"];
    }
  
   
    
    [self closeDataBase];
    //网络请求数据

    [self getGYSList];
}

- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //导航栏地址选择按钮
    navAddressBtn = [FL_Button fl_shareButton];
    [navAddressBtn setBackgroundColor:[UIColor whiteColor]];
    [navAddressBtn setImage:[UIImage imageNamed:@"下拉_Red"] forState:UIControlStateNormal];
    NSString *city =[[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    if (! [self checkCityInfo]) {
        [navAddressBtn setTitle:@"" forState:UIControlStateNormal];
    }else{
        [navAddressBtn setTitle:city forState:UIControlStateNormal];
    }
    
    [navAddressBtn setTitleColor:NavBarColor forState:UIControlStateNormal];
    [navAddressBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    navAddressBtn.status = FLAlignmentStatusLeft;
    navAddressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
   
    [navView addSubview:navAddressBtn];
    [navAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(navView.mas_left).offset(10);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    //导航栏档期选择按钮
    navTimeBtn = [FL_Button fl_shareButton];
    [navTimeBtn setBackgroundColor:[UIColor whiteColor]];
    [navTimeBtn setImage:[UIImage imageNamed:@"档期"] forState:UIControlStateNormal];
    [navTimeBtn setTitle:[NSString stringWithFormat:@"  %@",self.selectTime] forState:UIControlStateNormal];
    navTimeBtn.layer.borderWidth=1;
    navTimeBtn.layer.borderColor =[UIColor grayColor].CGColor;
    [navTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    navTimeBtn.status = FLAlignmentStatusNormal;
    navTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navTimeBtn addTarget:self action:@selector(timeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:navTimeBtn];
    [navTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
        make.centerX.mas_equalTo(navView);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    
    //导航栏右边搜索按钮
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"搜索_Red"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(navView).mas_offset(-15);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    
}
#pragma mark - Prepare UI
- (void)prepareUI{
    UIView *messageView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, 20)];
    messageView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:messageView];
    messageLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth, 20)];
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    messageLab.text =[NSString stringWithFormat:@"%@,他们有空。点击上方按钮，重新规划婚期↑",[dateString substringFromIndex:5]];
    messageLab.font =kFont(12);
    messageLab.textColor =[UIColor whiteColor];
    [messageView addSubview:messageLab];
    
    
    thistableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    thistableView.delegate =self;
    thistableView.dataSource =self;
    thistableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    thistableView.tableHeaderView = [self addHeaderView];
    [self.view addSubview:thistableView];
 
    
    
}
-(UIView*)addHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ItemHeight*row + kPageControlHeight+60)];
    headerView.backgroundColor =WhiteColor;
    
    YANScrollMenu *headrscrowMenu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ItemHeight*row + kPageControlHeight)];
    headrscrowMenu.currentPageIndicatorTintColor = NavBarColor;
   headrscrowMenu.delegate = self;
    
    
    [YANMenuItem appearance].textFont = [UIFont systemFontOfSize:15];
    [YANMenuItem appearance].textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
    [headerView addSubview:headrscrowMenu];
    
    //
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headrscrowMenu.frame), ScreenWidth, 10)];
    lineView.backgroundColor =bgColor;
    [headerView addSubview:lineView];
    
    UIView *headerSXView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), ScreenWidth, 48)];
    headerSXView.backgroundColor =[UIColor whiteColor];

    [headerView addSubview:headerSXView];

    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headerSXView.frame), ScreenWidth, 2)];
    lineView2.backgroundColor =bgColor;
    [headerView addSubview:lineView2];


//    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-1,10, 2, 30)];
//    lineView2.backgroundColor =bgColor;
//    [headerSXView addSubview:lineView2];

    topheaderSFBtn = [FL_Button fl_shareButton];
    [topheaderSFBtn setBackgroundColor:[UIColor whiteColor]];
    [topheaderSFBtn setImage:[UIImage imageNamed:@"下拉_Gray"] forState:UIControlStateNormal];
    [topheaderSFBtn setTitle:@"全部" forState:UIControlStateNormal];
    [topheaderSFBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    topheaderSFBtn.status = FLAlignmentStatusCenter;
    topheaderSFBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [topheaderSFBtn addTarget:self action:@selector(sfBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerSXView addSubview:topheaderSFBtn];
    [topheaderSFBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerSXView);
        make.left.mas_equalTo(headerSXView);
        make.right.mas_equalTo(headerSXView);
        make.bottom.mas_equalTo(headerSXView).offset(-1);
        make.top.mas_equalTo(headerSXView);
    }];
//
//
//
//    topheaderAddressBtn = [FL_Button fl_shareButton];
//    [topheaderAddressBtn setBackgroundColor:[UIColor whiteColor]];
//    [topheaderAddressBtn setImage:[UIImage imageNamed:@"下拉_Gray"] forState:UIControlStateNormal];
//    if (! [self checkCityInfo]) {
//         [topheaderAddressBtn setTitle:@"" forState:UIControlStateNormal];
//    }else{
//         [topheaderAddressBtn setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"] forState:UIControlStateNormal];
//    }
//
//    [topheaderAddressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    topheaderAddressBtn.status = FLAlignmentStatusCenter;
//    topheaderAddressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [topheaderAddressBtn addTarget:self action:@selector(topheaderAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerSXView addSubview:topheaderAddressBtn];
//    [topheaderAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(lineView2);
//        make.right.mas_equalTo(headerSXView);
//        make.left.mas_equalTo(lineView2.mas_right);
//        make.bottom.mas_equalTo(headerSXView).offset(-1);
//        make.top.mas_equalTo(headerSXView);
//    }];
//
//
//    UIView *lineView3 =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-1,10, 2, 30)];
//    lineView3.backgroundColor =bgColor;
//    [headerSXView addSubview:lineView3];
//    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(topheaderSFBtn.mas_bottom);
//        make.bottom.mas_equalTo(headerSXView) ;
//        make.left.mas_equalTo(headerSXView);
//        make.right.mas_equalTo(headerSXView);
//    }];
    
    return headerView;
}
#pragma mark -  Data
- (void)createData{
    

    for (HRZHiYeModel *model in self.zhiYeArr) {
        DataSource *object = [[DataSource alloc] init];
        object.text = model.OccupationName;
        object.image = model.Icon;
        object.placeholderImage = IMG(@"占位图");
        
        [self.dataSource addObject:object];
        
    }
//    for (NSUInteger idx = 0; idx< self.zhiYeArr.count; idx ++) {
//        
//        DataSource *object = [[DataSource alloc] init];
//        object.text = titles[idx];
//        object.image = images[idx];
//        object.placeholderImage = IMG(@"placeholder");
//        
//        [self.dataSource addObject:object];
//        
//    }
    
    
}
#pragma mark - YANScrollMenuProtocol
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return row;
}
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return item;
}
- (NSUInteger)numberOfMenusInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return self.dataSource.count;
}
- (id<YANMenuObject>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    return self.dataSource[idx];
}

- (void)scrollMenu:(YANScrollMenu *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    NSString *tips = [NSString stringWithFormat:@"IndexPath: [ %ld - %ld ]\nTitle:   %@",indexPath.section,indexPath.row,self.dataSource[idx].text];
    
      [topheaderSFBtn setTitle:self.dataSource[idx].text forState:UIControlStateNormal];
    [thistableView setContentOffset:CGPointMake(0.0, 200.0) animated:YES];
    for (HRZHiYeModel *model in self.zhiYeArr) {

        if ([model.OccupationName isEqualToString:self.dataSource[idx].text]) {
            self.selectZhiYeCode =model.OccupationCode;
        }
        
    }
    [self getGYSList];
    
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:tips preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [alert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [alert addAction:action];
//    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
- (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return YANEdgeInsetsMake(kScale(10), 0, kScale(5), 0, kScale(5));
}
#pragma mark --------tableViewDataScource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.GYSArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRHomeCell *cell = [HRHomeCell cellWithTableView:tableView];
    cell.model =self.GYSArr[indexPath.row];
    return cell;
}


#pragma mark ---------tableViewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HRGYSModel *model = _GYSArr[indexPath.row];

    NSLog(@"%@",model.ProfessionID);
    for (HRZHiYeModel *zyModel in self.zhiYeArr) {
        if ([model.ProfessionID isEqualToString:zyModel.OccupationCode]) {
             NSLog(@"%@  - %@",model.ProfessionID  ,zyModel.OccupationName);
            selectZhiYeName =zyModel.OccupationName;
        }
    }
    if ([model.ProfessionID isEqualToString:@"SF_1001000"]) {
        //酒店
            HRHotelViewController *hotelVC = [HRHotelViewController new];
            hotelVC.Name =model.Name;
            hotelVC.Headportrait =model.Headportrait;
            hotelVC.SupplierID =model.SupplierID;
            hotelVC.zhiyeName =@"酒店";
            [self.navigationController pushViewController:hotelVC animated:YES];
    }else if ([model.ProfessionID isEqualToString:@"SF_2001000"]) {
        //婚车
        
        HRHotelViewController *hotelVC = [HRHotelViewController new];
        hotelVC.Name =model.Name;
        hotelVC.Headportrait =model.Headportrait;
        hotelVC.SupplierID =model.SupplierID;
        hotelVC.zhiyeName =@"婚车";
        [self.navigationController pushViewController:hotelVC animated:YES];
    }else  {
        
        
        
        //主持人
            HRZhuChiXQViewController *zcXQ = [HRZhuChiXQViewController new];
            zcXQ.SupplierID =model.SupplierID;
            zcXQ.Name =model.Name;
            zcXQ.Headportrait =model.Headportrait;
            zcXQ.zhiyeName =selectZhiYeName;
            [self.navigationController pushViewController:zcXQ animated:YES];
    }

   

    
}

#pragma mark -----------CJAreaPickerDelegate----
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"locationOfSubcity"];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    NSLog(@"缓存城市设置为%@",huanCun);
//    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
    [self selectDataBase];
    
}
-(void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}
#pragma mark ---------target-----------
-(void)timeBtnClick{
    //婚期
//    [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:UIDatePickerModeDate defaultSelValue:[NSDate currentDateString] minDateStr:[NSDate currentDateString] maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
//
//        self.selectTime =selectValue;
//        [navTimeBtn setTitle:[NSString stringWithFormat:@" %@",self.selectTime] forState:UIControlStateNormal];
//         messageLab.text =[NSString stringWithFormat:@"%@,他们有空。点击上方按钮，重新规划婚期↑",[self.selectTime substringFromIndex:5]];
//        [self getGYSList];
//    }];
}

-(void)sfBtnClick{
    //身份选择器回调方法
    
    
    NSMutableArray *zytitleArr = [NSMutableArray arrayWithObject:@"全部"];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        [zytitleArr addObject:model.OccupationName];
    }
//    [BRStringPickerView showStringPickerWithTitle:@"请选择身份" dataSource:zytitleArr defaultSelValue: topheaderSFBtn.titleLabel.text isAutoSelect:YES resultBlock:^(id selectValue) {
//        
//        [topheaderSFBtn setTitle:selectValue forState:UIControlStateNormal];
//        if ([selectValue isEqualToString:@"全部"]) {
//            self.selectZhiYeCode =@"";
//        }else{
//            for (HRZHiYeModel *model in self.zhiYeArr) {
//                
//                if ([model.OccupationName isEqualToString:selectValue]) {
//                    self.selectZhiYeCode =model.OccupationCode;
//                }
//                
//            }  
//        }
//       
//        [self getGYSList];
//        
//    }];

}
-(void)searchBtnClick{
    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
    searchVC.zhiYeArr =self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}


-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}
-(void)topheaderAddressBtnClick{
    
    //header子区域地址
//    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
//        [topheaderAddressBtn setTitle:selectAddressArr[2] forState:UIControlStateNormal];
////        weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
//    }];
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
  
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
    
}
-(BOOL)checkCityInfo{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"] ) {
        //如果不存在城市缓存
        return NO;
    }else{
        return YES;
    }
    
}
#pragma mark - LLNoDataViewTouchDelegate
- (void)didTouchLLNoDataView{
    
    [self getGYSList];
    
    thistableView.tableFooterView = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ----------网络请求----------------
#pragma mark 获取所有职业列表
- (void)getZhiYeList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetAllOccupationList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Type"] = @"2";//0、获取所有 1、注册（不包含公司、用户、婚车）2、主页（不包含 用户、车手）
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.zhiYeArr removeAllObjects];
            self.zhiYeArr =[HRZHiYeModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            NSLog(@"职业列表数组个数%zd",self.zhiYeArr.count);
            [self createData];
            [self prepareUI];
            if (![self checkCityInfo]) {
               [self cityBtnClick];
            }else{
                [self getGYSList];
            }
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}
- (void)getGYSList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetSupplierInfoList";
    
    if ([self.selectZhiYeCode isEqualToString:@""]) {
        HRZHiYeModel *model = self.zhiYeArr[0];
        self.selectZhiYeCode =@"";
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

        params[@"UserID"]   = myID;
        params[@"OccupationCode"] =self.selectZhiYeCode;;
        params[@"WeddingDate"]  = self.selectTime;
        params[@"Region"]       = areaID;
        params[@"NameAndPhone"] = @"";
        params[@"PageIndex"]    = @"1";
        params[@"PageCount"]    = @"10000";
       NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.GYSArr removeAllObjects];
            self.GYSArr  =[HRGYSModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];

//            //
            NSLog(@"列表：%@",object);
            [thistableView reloadData];
            if (self.GYSArr.count > 0) {
                
                thistableView.tableFooterView = nil;
            }else{
                
//                [EasyShowTextView showText:@"当前暂无数据!"];

                [self showNoDataEmptyView];
                
//                LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHeight-250-64) LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
//                dataView.delegate = self;
//                thistableView.tableFooterView = dataView;
//
//                //实例一次，再次修改提示文本信息
//                dataView.tipLabel.text = @"当前没有加载到数据";
                
            }

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        [self showNetErrorEmptyView];
        
    }];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getZhiYeList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

@end
