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
//#import "HRHomeCell.h"
//6-4 替换
#import "YPReHomeSupplierListCell.h"
//#import "HRHotelViewController.h"
#import "HRZHiYeModel.h"
//18-08-10 替换
//#import "YPGetWebSupplierList.h"
#import "YPGetFacilitatorList.h"//服务商列表
//#import "YPSupplierOtherInfoController.h"
#import "YPSupplierHomePage181119Controller.h"//18-11-20 供应商主页

@interface HRHomeSearchViewController ()<SearchViewDelegate,SearchViewDataSource,UITableViewDelegate,UITableViewDataSource>{
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
@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorList *> *supplierMarr;

@end

@implementation HRHomeSearchViewController

-(NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}

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
    
    self.view.backgroundColor =CHJ_bgColor;
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
    NSLog(@"个数%lu",(unsigned long)self.supplierMarr.count);
    return  self.supplierMarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    
//    return cell;
//    HRHomeCell *cell = [HRHomeCell cellWithTableView:tableView];
//    cell.model =self.supplierMarr[indexPath.row];
//    return cell;
    
    //17-6-4 18-08-10修改
    YPGetFacilitatorList *gysModel = self.supplierMarr[indexPath.row];
    
    YPReHomeSupplierListCell *cell = [YPReHomeSupplierListCell cellWithTableView:tableView];
    cell.gysModel = gysModel;
    return cell;
    
}

#pragma mark --------tableviewDelegate ------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
        
        //18-11-20
        YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
        hotelVC.FacilitatorID = model.Id ;
        hotelVC.profession = model.SupplierIdentity;
        [self.navigationController pushViewController:hotelVC animated:YES];
        
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
    [self GetFacilitatorList];
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

#pragma mark 获取服务商列表
- (void)GetFacilitatorList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetFacilitatorList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"AreaID"] = areaID_New;
    params[@"Identity"]  = @"";
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"50";
    params[@"Name"] = searchStr;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.supplierMarr removeAllObjects];
            self.supplierMarr  = [YPGetFacilitatorList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            NSLog(@"列表：%@",object);
            [searchTableView reloadData];
            if (self.supplierMarr.count > 0) {
                
                [self hidenEmptyView];
                
            }else{
                
                [self showNoDataEmptyView];

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

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorList *> *)supplierMarr{
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
        [self GetFacilitatorList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

@end
