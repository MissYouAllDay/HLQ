//
//  YPHYTHSearchViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/15.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHSearchViewController.h"
#import "SearchView.h"
#import "YPGetPreferentialCommodityList.h"
#import "YPHYTHBaseListCell.h"
#import "YPHYTHDetailController.h"

@interface YPHYTHSearchViewController ()<SearchViewDelegate,SearchViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SearchView       *SearchView;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) NSMutableArray *keyWordArray; // 搜索关键字记录

@property (nonatomic, strong) NSMutableArray<YPGetPreferentialCommodityList *> *listMarr;

@end

@implementation YPHYTHSearchViewController{
    UITableView *searchTableView;
    NSString *searchStr;
    UIView *navView;
    NSString *selectZhiYeName;
}

#pragma mark - getter
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
    
    self.view.backgroundColor = CHJ_bgColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backHome)
                                                 name:@"backHome" object:nil];
}

- (void)backHome{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView{
    
    searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
    searchTableView.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    searchTableView.dataSource = self;
    searchTableView.delegate = self;
    searchTableView.separatorStyle = UITableViewCellAccessoryNone;
    searchTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:searchTableView];
}

#pragma mark --------tableViewDatascoruce-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listMarr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetPreferentialCommodityList *list = self.listMarr[indexPath.row];
    
    YPHYTHBaseListCell *cell = [YPHYTHBaseListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:list.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.FacilitatorImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    if (list.Name.length > 0) {
        cell.tingTitle.text = list.Name;
    }else{
        cell.tingTitle.text = @"当前无名称";
    }
    if (list.FacilitatorName.length > 0) {
        cell.titleLabel.text = list.FacilitatorName;
    }else{
        cell.titleLabel.text = @"当前无名称";
    }
    cell.canbiao.text = list.Price;
    cell.lijian.text = [NSString stringWithFormat:@"%zd%%",list.Discount];
    cell.countLabel.text = [NSString stringWithFormat:@"%zd",list.SalesVolume];
    return cell;
    
}

#pragma mark --------tableviewDelegate ------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetPreferentialCommodityList *list = self.listMarr[indexPath.row];
    
    YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
    detail.detailID = list.Id;
    [self.navigationController pushViewController:detail animated:YES];
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

    [self initTableView];
    NSLog(@"%@",keyword);
    searchStr =keyword;
    [self GetPreferentialCommodityList];
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
    NSString *path = [cachePath stringByAppendingString:@"/HYTHList.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
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

#pragma mark - 网络请求
#pragma mark 获取特惠商品列表
- (void)GetPreferentialCommodityList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetPreferentialCommodityList";
    NSDate *date = [NSDate date];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AreaId"] = areaID_New;
    params[@"Name"] = searchStr;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10";
    params[@"Mouth"] = [NSString stringWithFormat:@"%zd",date.month];
    params[@"SortField"] = @"0";//0正序,1倒序
    params[@"Sort"] = @"0";//0销量,1价格
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.listMarr = [YPGetPreferentialCommodityList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            if (self.listMarr.count == 0) {
                [self showNoDataEmptyView];
            }else{
                [self hidenEmptyView];
            }
            
            [searchTableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [self showNetErrorEmptyView];
        
    }];
    
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:searchTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialCommodityList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:searchTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialCommodityList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
