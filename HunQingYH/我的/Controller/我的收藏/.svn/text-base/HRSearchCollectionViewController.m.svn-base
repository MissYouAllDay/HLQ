//
//  HRSearchCollectionViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/9/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRSearchCollectionViewController.h"
#import "SearchView.h"
#import "YPMyCollectionCell.h"
#import "HRHotelViewController.h"
#import "YPCollectionList.h"
#import "HRZHiYeModel.h"
#import "YPSupplierHomePage181119Controller.h"//商家主页

@interface HRSearchCollectionViewController ()<SearchViewDelegate,SearchViewDataSource,UITableViewDelegate,UITableViewDataSource>{
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
@property(nonatomic,strong)NSMutableArray  *GYSArr;


@end

@implementation HRSearchCollectionViewController

-(NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}
-(NSMutableArray *)GYSArr{
    if (!_GYSArr) {
        _GYSArr =[NSMutableArray array];
    }
    return _GYSArr;
    
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
    NSLog(@"个数%lu",(unsigned long)self.GYSArr.count);
    return  self.GYSArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPCollectionList *list = self.GYSArr[indexPath.row];
    
    YPMyCollectionCell *cell = [YPMyCollectionCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (list.CollectionTitle.length > 0) {
        cell.titleLabel.text = list.CollectionTitle;
    }else{
        cell.titleLabel.text = @"无";
    }
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.CollectionLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    return cell;
}

#pragma mark --------tableviewDelegate ------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YPCollectionList *model = self.GYSArr[indexPath.row];
    
    
    for (HRZHiYeModel *zyModel in self.zhiYeArr) {
        if ([model.ProfessionID isEqualToString:zyModel.OccupationID]) {
            NSLog(@"%@  - %@",model.ProfessionID  ,zyModel.OccupationName);
            selectZhiYeName =zyModel.OccupationName;
        }
    }
    
    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = model.TypeID;
    hotelVC.profession = model.ProfessionID;
    [self.navigationController pushViewController:hotelVC animated:YES];
    
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
    [self CollectionList];
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
    NSString *path = [cachePath stringByAppendingString:@"/collection.plist"];
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


- (void)CollectionList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CollectionList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CollectorsType"] = @"0";//0用户、1公司
    params[@"CollectorsID"] = UserId_New;
    params[@"CollectionType"] = @"0";//0供应商、1方案、2宴会、3全部
    params[@"ProfessionID"] =@"";
    params[@"CollectionTitle"] = searchStr;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.GYSArr removeAllObjects];
            self.GYSArr = [YPCollectionList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [searchTableView reloadData];
            if (self.GYSArr.count > 0) {
                
            }else{
                
                [EasyShowTextView showText:@"当前暂无数据!"];

            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
@end
