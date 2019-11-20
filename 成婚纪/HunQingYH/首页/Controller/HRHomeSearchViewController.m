//
//  HRHomeSearchViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHomeSearchViewController.h"
#import "SearchView.h"
#import "HRGYSModel.h"
#import "HRHomeCell.h"
#import "HRHotelViewController.h"
#import "HRZhuChiXQViewController.h"
#import "HRZHiYeModel.h"
#import "YPGetWebSupplierList.h"

@interface HRHomeSearchViewController ()<SearchViewDelegate,SearchViewDataSource,UITableViewDelegate,UITableViewDataSource,LLNoDataViewTouchDelegate>{
    UITableView *searchTableView;
    NSString *searchStr;
     UIView *navView;
     NSString *selectZhiYeName;
    
    
}
@property (nonatomic, strong) SearchView       *SearchView;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) NSMutableArray *keyWordArray; // 搜索关键字记录
//@property(nonatomic,strong)HRCusterModel *clickModel;//点击选择的cell对应的model

@property (nonatomic,strong)NSMutableArray *dataArray;
/**供应商数组*/
//@property(nonatomic,strong)NSMutableArray  *GYSArr;

/**供应商模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWebSupplierList *> *supplierMarr;

@end

@implementation HRHomeSearchViewController
-(NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}
//-(NSMutableArray *)GYSArr{
//    if (!_GYSArr) {
//        _GYSArr =[NSMutableArray array];
//    }
//    return _GYSArr;
//
//}
- (NSMutableArray *)testArray {
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc] init];
    }
    return _testArray;
}

- (NSMutableArray *)keyWordArray {
    
    if (!_keyWordArray) {
        // *** 当文件为空时，创建会失败
        _keyWordArray = [NSMutableArray arrayWithContentsOfFile:[self getCachePath]];
    }
    // ***  所以要再次判断
    if (!_keyWordArray) {
        _keyWordArray = [[NSMutableArray alloc] init];
    }
    return _keyWordArray;
}
- (void)loadView {
    
    _SearchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:self options:nil] lastObject];
    _SearchView.delegate = self;
    _SearchView.datasource = self;
    self.view = _SearchView;
    [_SearchView.textField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =bgColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backHome)
                                                 name:@"backHome" object:nil];
    //
  
}
- (void)backHome{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView{
    
    searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    searchTableView.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    searchTableView.dataSource =self;
    searchTableView.delegate = self;
    searchTableView.separatorStyle =UITableViewCellAccessoryNone;
//  searchTableView.tableHeaderView =[self addHeaderView];
    searchTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:searchTableView];
}
#pragma mark --------tableViewDatascoruce-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"个数%ld",self.supplierMarr.count);
    return  self.supplierMarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    
//    return cell;
    HRHomeCell *cell = [HRHomeCell cellWithTableView:tableView];
    cell.model =self.supplierMarr[indexPath.row];
    return cell;
}

#pragma mark --------tableviewDelegate ------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //2-11 修改 登录判断
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        YPGetWebSupplierList *model = self.supplierMarr[indexPath.row];
        
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
            hotelVC.Headportrait =model.ImgUrl;
            hotelVC.SupplierID =[model.SupplierID integerValue];
            hotelVC.zhiyeName =@"酒店";
            [self.navigationController pushViewController:hotelVC animated:YES];
        }else if ([model.ProfessionID isEqualToString:@"SF_2001000"]) {
            //婚车
            
            HRHotelViewController *hotelVC = [HRHotelViewController new];
            hotelVC.Name =model.Name;
            hotelVC.Headportrait =model.ImgUrl;
            hotelVC.SupplierID =[model.SupplierID integerValue];
            hotelVC.zhiyeName =@"婚车";
            [self.navigationController pushViewController:hotelVC animated:YES];
        }else  {
            
            
            
            //主持人
            HRZhuChiXQViewController *zcXQ = [HRZhuChiXQViewController new];
            zcXQ.SupplierID =[model.SupplierID integerValue];
            zcXQ.Name =model.Name;
            zcXQ.Headportrait =model.ImgUrl;
            zcXQ.zhiyeName =selectZhiYeName;
            [self.navigationController pushViewController:zcXQ animated:YES];
        }
    }

}
#pragma mark - CustomView代理


- (NSArray *)searchView:(SearchView *)searchView {
    
    // 此代理方法的作用是提供开始输入时所展示的全部搜索记录
    return self.keyWordArray;
}

- (void)searchView:(SearchView *)searchView didSelectKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到选中的关键字,后续一般为向服务器提交数据请求。
    NSLog(@"选中的关键字为:%@",keyword);
    
    [self checkKeyword:keyword];
}

- (void)searchView:(SearchView *)searchView didDeleteKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到删除的关键字后删除本地缓存的关键字。
    NSArray *keyArray = [self.keyWordArray copy];
    for (NSString *key in keyArray) {
        if ([key isEqualToString:keyword]) {
            [self.keyWordArray removeObject:key];
            [self seaveKayWord];
        }
    }
    NSLog(@"删除的关键字为:%@",keyword);
}

- (NSArray *)searchView:(SearchView *)searchView didInputKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到输入中的关键字后在本地缓存中模糊匹配,再把结果返回给视图,视图拿到匹配结果后,动态刷新候选关键字。
    [self.testArray removeAllObjects];
    for (NSString *key in self.keyWordArray) {
        if ([key containsString:keyword]) {
            [self.testArray addObject:key];
        }
    }
    NSLog(@"正在输入的关键字为:%@",keyword);
    return self.testArray;
}

- (void)searchView:(SearchView *)searchView shouldReturnKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到点击搜索按钮后搜索框中的关键字,在本地缓存中查找后再判断是否要保存到本地。
    BOOL isExist = NO;
    for (NSString *key in self.keyWordArray) {
        if ([key isEqualToString:keyword]) {
            isExist = YES;
        }
    }
    
    if (!isExist) {
        [self.keyWordArray insertObject:keyword atIndex:0];
        [self seaveKayWord];
    }
    NSLog(@"搜索的关键字为:%@",keyword);
    [self checkKeyword:keyword];
    
}
//判断输入字符并请求数据
-(void)checkKeyword:(NSString*)keyword{
    //    if ([keyword isEqualToString:@"全部"]||[keyword isEqualToString:@"住宿"]||[keyword isEqualToString:@"火锅"]||[keyword isEqualToString:@"酒吧"]||[keyword isEqualToString:@"小龙虾"]||[keyword isEqualToString:@"日韩料理"]||[keyword isEqualToString:@"甜点"]||[keyword isEqualToString:@"自助餐"]||[keyword isEqualToString:@"聚会宴请"]) {
    //        self.category =keyword;
    //        self.shopname =@"";
    //    }else{
    //        self.category=@"";
    //        self.shopname=keyword;
    //    }
        [self initTableView];
    //
    //    [self beginRequestFriend];
    NSLog(@"%@",keyword);
    searchStr =keyword;
    [self GetWebSupplierList];
}

#pragma mark - 数据缓存相关操作

- (void)seaveKayWord {
    
    // 此方法的作用是将关键字以数组的格式保存到本地。
    [self.keyWordArray writeToFile:[self getCachePath] atomically:YES];
}

- (NSString *)getCachePath {
    
    // 此方法的作用是获取本地缓存路径。
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *path = [cachePath stringByAppendingString:@"/keyword.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
-(void)dealloc{
    NSLog(@"移除通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)getGYSList{
//    MBProgressHUD *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
//    NSString *url = @"/api/User/GetSupplierInfoList";
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    params[@"UserID"]   = myID;
//    params[@"OccupationCode"] =@"";
//    params[@"WeddingDate"]  = @"";
//    params[@"Region"]       = areaID;
//    params[@"NameAndPhone"] = searchStr;
//    params[@"PageIndex"]    = @"1";
//    params[@"PageCount"]    = @"10000";
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            self.GYSArr  =[HRGYSModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
//            [searchTableView reloadData];
//
//        }else{
//
//            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:2.0 view:self.view];
//
//
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
    
    params[@"OccupationCode"] =@"";
    params[@"IsHeat"]  = @"0";//0不是热门 1是热门
    params[@"RegionId"]  = areaID;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10000";
    
    params[@"WeddingDate"] = @"";
    params[@"OrderType"] = @"2";//0首页排序 1热门排序(无用) 2动态时间排序
    params[@"NameOrPhone"] = searchStr;//模糊查询用
    NSLog(@"%@",params);
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.supplierMarr removeAllObjects];
            self.supplierMarr  = [YPGetWebSupplierList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            //            //
            NSLog(@"列表：%@",object);
            [searchTableView reloadData];
            if (self.supplierMarr.count > 0) {
                
//                searchTableView.tableFooterView = nil;
                
                [self hidenEmptyView];
                
            }else{
                
//                [EasyShowTextView showText:@"当前暂无数据!"];
                [self showNoDataEmptyView];
                
//                LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHeight-250-64) LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
//                dataView.delegate = self;
//                searchTableView.tableFooterView = dataView;
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
    
    searchTableView.tableFooterView = nil;
}

#pragma mark - getter
- (NSMutableArray<YPGetWebSupplierList *> *)supplierMarr{
    if (!_supplierMarr) {
        _supplierMarr = [NSMutableArray array];
    }
    return _supplierMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:searchTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:searchTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetWebSupplierList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

@end
