//
//  YPReHomeSupplierListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeSupplierListController.h"
//详情
#import "HRHotelViewController.h"
#import "HRZhuChiXQViewController.h"
//#import "HRHomeCell.h"
//#import "HRGYSModel.h"
#import "YPGetWebSupplierList.h"
#import "HRZHiYeModel.h"
#import "YPReHomeSupplierListCell.h"
#import "YPSupplierOtherInfoController.h"//2-6 重做 其他供应商信息

@interface YPReHomeSupplierListController ()<UITableViewDelegate,UITableViewDataSource,LLNoDataViewTouchDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**供应商数组*/
@property(nonatomic,strong)NSMutableArray  *GYSArr;

@end

@implementation YPReHomeSupplierListController{
    UIView *_navView;
    NSString *selectZhiYeName;
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
    
    [self GetWebSupplierList];
}

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
    if (self.titleStr.length > 0) {
        titleLab.text = self.titleStr;
    }else{
        titleLab.text = @"全部供应商";
    }
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = bgColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = bgColor;
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
    return self.GYSArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPGetWebSupplierList *gysModel = self.GYSArr[indexPath.row];
    
    YPReHomeSupplierListCell *cell = [YPReHomeSupplierListCell cellWithTableView:tableView];
    cell.gysModel = gysModel;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 143;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //2-11 修改 登录判断
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
    
        YPGetWebSupplierList *model = _GYSArr[indexPath.row];
        
        NSLog(@"%@",model.ProfessionID);
        for (HRZHiYeModel *zyModel in self.professionArr) {
            if ([model.ProfessionID isEqualToString:zyModel.OccupationCode]) {
                NSLog(@"%@  - %@",model.ProfessionID  ,zyModel.OccupationName);
                selectZhiYeName =zyModel.OccupationName;
            }
        }
        if ([model.ProfessionID isEqualToString:@"SF_1001000"]) {
            //酒店
            HRHotelViewController *hotelVC = [HRHotelViewController new];
            hotelVC.Name =model.Name;
            hotelVC.Headportrait =model.ImgUrl;
            hotelVC.SupplierID =[model.SupplierID integerValue];
            hotelVC.zhiyeName =@"酒店";
            hotelVC.UserID = model.UserID;//2-6 添加 动态使用
            [self.navigationController pushViewController:hotelVC animated:YES];
        }else if ([model.ProfessionID isEqualToString:@"SF_2001000"]) {
            //婚车
            
            HRHotelViewController *hotelVC = [HRHotelViewController new];
            hotelVC.Name =model.Name;
            hotelVC.Headportrait =model.ImgUrl;
            hotelVC.SupplierID =[model.SupplierID integerValue];
            hotelVC.zhiyeName =@"婚车";
            hotelVC.UserID = model.UserID;//2-6 添加 动态使用
            [self.navigationController pushViewController:hotelVC animated:YES];
        }else  {

            //2-6 重做 其他(除酒店/婚车)
            YPSupplierOtherInfoController *otherInfo = [[YPSupplierOtherInfoController alloc]init];
            otherInfo.Name =model.Name;
            otherInfo.Headportrait =model.ImgUrl;
            otherInfo.SupplierID =[model.SupplierID integerValue];
            otherInfo.zhiyeName =@"婚车";
            otherInfo.UserID = model.UserID;//2-6 添加 动态使用
            [self.navigationController pushViewController:otherInfo animated:YES];
            
    //        //主持人
    //        HRZhuChiXQViewController *zcXQ = [HRZhuChiXQViewController new];
    //        zcXQ.SupplierID =[model.SupplierID integerValue];
    //        zcXQ.Name =model.Name;
    //        zcXQ.Headportrait =model.ImgUrl;
    //        zcXQ.zhiyeName =selectZhiYeName;
    //        [self.navigationController pushViewController:zcXQ animated:YES];
        }
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
//- (void)getGYSList{
//    MBProgressHUD *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
//    NSString *url = @"/api/User/GetSupplierInfoList";
//
//
//    NSString *selectTime;
//    NSDate *currentDate = [NSDate date];//获取当前日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//    selectTime = [dateFormatter stringFromDate:currentDate];
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    params[@"UserID"]   = myID;
//    if (self.professionCode.length > 0) {
//        params[@"OccupationCode"] = self.professionCode;//单个
//    }else{
//        params[@"OccupationCode"] = @"";//全部
//    }
//    params[@"WeddingDate"]  = selectTime;
//    params[@"Region"]       = areaID;
//    params[@"NameAndPhone"] = @"";
//    params[@"PageIndex"]    = @"1";
//    params[@"PageCount"]    = @"10000";
//    NSLog(@"%@",params);
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            [self.GYSArr removeAllObjects];
//            self.GYSArr  =[HRGYSModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
//
//            //            //
//            NSLog(@"列表：%@",object);
//
//
//            [self.tableView reloadData];
//
//            if (self.GYSArr.count > 0) {
//
//                self.tableView.tableFooterView = nil;
//            }else{
//
//                [MBProgressHUD wj_showPlainText:@"当前没有数据!" hideAfterDelay:1.0 view:self.view];
//
//                LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHeight-250-64) LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
//                dataView.delegate = self;
//                self.tableView.tableFooterView = dataView;
//
//                //实例一次，再次修改提示文本信息
//                dataView.tipLabel.text = @"当前没有加载到数据";
//
//            }
//
//        }else{
//
//            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:3.0 view:self.view];
//
//        }
//
//    } Failure:^(NSError *error) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//        [MBProgressHUD wj_showError:@"网络错误，请稍后重试" hideAfterDelay:3.0 toView:self.view];
//
//    }];
//}

#pragma mark 获取web供应商列表
- (void)GetWebSupplierList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetWebSupplierList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.professionCode.length > 0) {
        params[@"OccupationCode"] = self.professionCode;//单个
    }else{
        params[@"OccupationCode"] = @"";//全部
    }
    params[@"IsHeat"]  = @"0";//0不是热门 1是热门
    params[@"RegionId"]  = areaID;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10000";
    
    params[@"WeddingDate"] = @"";
    params[@"OrderType"] = @"2";//0首页排序 1热门排序(无用) 2动态时间排序
    params[@"NameOrPhone"] = @"";//模糊查询用
    
    NSLog(@"%@",params);
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.GYSArr removeAllObjects];
            self.GYSArr  = [YPGetWebSupplierList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            //            //
            NSLog(@"列表：%@",object);
            
            
            [self.tableView reloadData];
            
            if (self.GYSArr.count > 0) {
                
//                self.tableView.tableFooterView = nil;
                [self hidenEmptyView];
                
            }else{
                
//                [EasyShowTextView showText:@"当前无数据!"];
                
                [self showNoDataEmptyView];
                
//                LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHeight-250-64) LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
//                dataView.delegate = self;
//                self.tableView.tableFooterView = dataView;
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

#pragma mark - LLNoDataViewTouchDelegate
- (void)didTouchLLNoDataView{
    
    [self GetWebSupplierList];
    
    self.tableView.tableFooterView = nil;
}

#pragma mark - getter
-(NSMutableArray *)GYSArr{
    if (!_GYSArr) {
        _GYSArr =[NSMutableArray array];
    }
    return _GYSArr;
    
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"无数据" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetWebSupplierList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetWebSupplierList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
