//
//  YPReHomeShaiXuanController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeShaiXuanController.h"
//#import "CJAreaPicker.h"//城市选择
#import "DataSource.h"
#import "YANScrollMenu.h"
#import "FL_Button.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "HRHomeCell.h"
#import "HRHomeSearchViewController.h"
#import "HRHotelViewController.h"
#import "HRZHiYeModel.h"

#import "YPSupplierOtherInfoController.h"//2-6 重做 其他供应商信息

//18-08-10 修改
#import "YPGetFacilitatorList.h"

//#import "HRGYSModel.h"
#define ItemHeight 90
#define IMG(name)           [UIImage imageNamed:name]

@interface YPReHomeShaiXuanController ()<YANScrollMenuProtocol,UITableViewDelegate,UITableViewDataSource>
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
//*供应商数组
//@property(nonatomic,strong)NSMutableArray  *GYSArr;
@property(nonatomic,assign)NSInteger parentID;
@property(nonatomic,strong)NSString *selectZhiYeCode;
@property(nonatomic,strong)NSString *selectTime;
//@property (nonatomic, strong) YANScrollMenu *menu;
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray<DataSource *> *dataSource;

/**供应商模型*/
@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorList *> *supplierMarr;

@end

@implementation YPReHomeShaiXuanController
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
//-(NSMutableArray *)GYSArr{
//    if (!_GYSArr) {
//        _GYSArr =[NSMutableArray array];
//    }
//    return _GYSArr;
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    self.selectZhiYeCode =@"";
    NSDate *currentDate = [NSDate date];//获取当前日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    self.selectTime =[dateFormatter stringFromDate:currentDate];
    [self getZhiYeList];
//    [self moveToDBFile];//迁移数据库
    
    row = 2;
    item = 5;
    
    
    [self createNav];
    
}

- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(navView.mas_left);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
    }];
    
    //导航栏档期选择按钮
    navTimeBtn = [FL_Button fl_shareButton];
//    [navTimeBtn setBackgroundColor:[UIColor whiteColor]];
    [navTimeBtn setImage:[UIImage imageNamed:@"档期"] forState:UIControlStateNormal];
    [navTimeBtn setTitle:[NSString stringWithFormat:@"  %@",self.selectTime] forState:UIControlStateNormal];
//    navTimeBtn.layer.borderWidth=1;
//    navTimeBtn.layer.borderColor =[UIColor grayColor].CGColor;
    [navTimeBtn setBackgroundColor:RGB(246, 247, 249)];//2-9 修改
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
    [searchBtn setImage:[UIImage imageNamed:@"搜索_Gray"] forState:UIControlStateNormal];
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
    
    
    thistableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+20, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-20) style:UITableViewStylePlain];
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
    lineView.backgroundColor =CHJ_bgColor;
    [headerView addSubview:lineView];
    
    UIView *headerSXView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), ScreenWidth, 48)];
    headerSXView.backgroundColor =[UIColor whiteColor];
    
    [headerView addSubview:headerSXView];
    
    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headerSXView.frame), ScreenWidth, 2)];
    lineView2.backgroundColor =CHJ_bgColor;
    [headerView addSubview:lineView2];
    
    
    //    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-1,10, 2, 30)];
    //    lineView2.backgroundColor =CHJ_bgColor;
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
    
    NSString *tips = [NSString stringWithFormat:@"IndexPath: [ %ld - %ld ]\nTitle:   %@",(long)indexPath.section,indexPath.row,self.dataSource[idx].text];
    
    [topheaderSFBtn setTitle:self.dataSource[idx].text forState:UIControlStateNormal];
    [thistableView setContentOffset:CGPointMake(0.0, 200.0) animated:YES];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        
        if ([model.OccupationName isEqualToString:self.dataSource[idx].text]) {
            self.selectZhiYeCode =model.OccupationID;
        }
        
    }
    [self GetFacilitatorList];
    
    
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
    return self.supplierMarr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRHomeCell *cell = [HRHomeCell cellWithTableView:tableView];
    cell.model =self.supplierMarr[indexPath.row];
    return cell;
}


#pragma mark ---------tableViewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //2-11 修改 登录判断
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
    
        YPGetFacilitatorList *model = self.supplierMarr[indexPath.row];
        
        NSLog(@"%@",model.SupplierIdentity);
        for (HRZHiYeModel *zyModel in self.zhiYeArr) {
            if ([model.SupplierIdentity isEqualToString:zyModel.OccupationID]) {
                NSLog(@"%@  - %@",model.SupplierIdentity  ,zyModel.OccupationName);
                selectZhiYeName =zyModel.OccupationName;
            }
        }
//        if (JiuDian(model.SupplierIdentity)) {
//            //酒店
//            HRHotelViewController *hotelVC = [HRHotelViewController new];
//            hotelVC.FacilitatorID = model.Id;
//            hotelVC.profession = model.SupplierIdentity;
//            [self.navigationController pushViewController:hotelVC animated:YES];
////        }else if (HunChe(model.SupplierIdentity)) {
////            //婚车
////            
////            HRHotelViewController *hotelVC = [HRHotelViewController new];
////            hotelVC.FacilitatorID = model.Id;
////            [self.navigationController pushViewController:hotelVC animated:YES];
//        }else  {
//            
//            //2-6 重做 其他(除酒店/婚车)
//            YPSupplierOtherInfoController *otherInfo = [[YPSupplierOtherInfoController alloc]init];
//            otherInfo.FacilitatorID = model.Id;
//            [self.navigationController pushViewController:otherInfo animated:YES];
//
//        }
    }

}

#pragma mark ---------target-----------
-(void)timeBtnClick{
    //婚期
    //3-9 修改
    [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:BRDatePickerModeDate defaultSelValue:@"" resultBlock:^(NSString *selectValue) {
        self.selectTime =selectValue;
        [navTimeBtn setTitle:[NSString stringWithFormat:@" %@",self.selectTime] forState:UIControlStateNormal];
        messageLab.text =[NSString stringWithFormat:@"%@,他们有空。点击上方按钮，重新规划婚期↑",[self.selectTime substringFromIndex:5]];
        [self GetFacilitatorList];
    }];
//    [BRDatePickerView showDatePickerWithTitle: dateType: defaultSelValue: minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
//        //[[NSDate currentDateString] substringToIndex:10]
//        self.selectTime =selectValue;
//        [navTimeBtn setTitle:[NSString stringWithFormat:@" %@",self.selectTime] forState:UIControlStateNormal];
//        messageLab.text =[NSString stringWithFormat:@"%@,他们有空。点击上方按钮，重新规划婚期↑",[self.selectTime substringFromIndex:5]];
//        [self GetWebSupplierList];
//    }];
}

-(void)sfBtnClick{
    //身份选择器回调方法
    
    
    NSMutableArray *zytitleArr = [NSMutableArray arrayWithObject:@"全部"];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        [zytitleArr addObject:model.OccupationName];
    }
    
    //3-9 修改
    [BRStringPickerView showStringPickerWithTitle:@"请选择身份" dataSource:zytitleArr defaultSelValue:topheaderSFBtn.titleLabel.text resultBlock:^(id selectValue) {
        [topheaderSFBtn setTitle:selectValue forState:UIControlStateNormal];
        if ([selectValue isEqualToString:@"全部"]) {
            self.selectZhiYeCode =@"";
        }else{
            for (HRZHiYeModel *model in self.zhiYeArr) {
                
                if ([model.OccupationName isEqualToString:selectValue]) {
                    self.selectZhiYeCode =model.OccupationID;
                }
                
            }
        }
        
        [self GetFacilitatorList];
    }];
    
//    [BRStringPickerView showStringPickerWithTitle: dataSource: defaultSelValue:  isAutoSelect:YES resultBlock:^(id selectValue) {
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
//        [self GetWebSupplierList];
//        
//    }];
    
}
-(void)searchBtnClick{
    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
    searchVC.zhiYeArr =self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
    NSString *url = @"/api/HQOAApi/GetAllOccupationList";
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /**
     0、获取所有
     1、注册（不包含公司、用户、车手、员工）
     2、主页（不包含 用户、车手、员工）
     3、主页（不包含 用户、车手、员工,酒店）
     */
    params[@"Type"] = @"2";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.zhiYeArr removeAllObjects];
            self.zhiYeArr =[HRZHiYeModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
//            NSLog(@"职业列表数组个数%zd",self.zhiYeArr.count);
            [self createData];
            [self prepareUI];
//            if (![self checkCityInfo]) {
//                [self cityBtnClick];
//            }else{
                [self GetFacilitatorList];
//            }
            
            
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

#pragma mark - 网络请求
#pragma mark 获取服务商列表
- (void)GetFacilitatorList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetFacilitatorList";
    
    if ([self.selectZhiYeCode isEqualToString:@""]) {
        if (self.zhiYeArr.count > 0) {
            //            HRZHiYeModel *model = self.zhiYeArr[0];
            self.selectZhiYeCode = @"";
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"AreaID"] = areaID_New;
    params[@"Identity"] = self.selectZhiYeCode;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"50";
    params[@"Name"] = @"";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.supplierMarr removeAllObjects];
            self.supplierMarr  = [YPGetFacilitatorList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            NSLog(@"列表：%@",object);
            [thistableView reloadData];
            
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

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorList *> *)supplierMarr{
    if (!_supplierMarr) {
        _supplierMarr = [NSMutableArray array];
    }
    return _supplierMarr;
}


//#pragma mark - 缺省
//-(void)showNoDataEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:thistableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        [self GetWebSupplierList];
//    }];
//
//}
//-(void)showNetErrorEmptyView{
//
//    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:thistableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
//        [self getZhiYeList];
//    }];
//
//}
//-(void)hidenEmptyView{
//    [ EasyShowEmptyView hiddenEmptyView:self.view];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
