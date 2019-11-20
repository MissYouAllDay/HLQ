//
//  YPWeddingOrderSearchUserPhoneController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderSearchUserPhoneController.h"
#import "SearchView.h"
#import "HRGYSModel.h"
//6-4 替换
#import "YPReHomeSupplierListCell.h"
#import "HRZHiYeModel.h"

@interface YPWeddingOrderSearchUserPhoneController ()<SearchViewDelegate,SearchViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    UITableView *searchTableView;
    NSString *searchStr;
    UIView *navView;
    NSString *selectZhiYeName;
}
@property (nonatomic, strong) SearchView       *SearchView;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) NSMutableArray *keyWordArray; // 搜索关键字记录

@property (nonatomic,strong)NSMutableArray *dataArray;

/**供应商模型*/
@property (nonatomic, strong) NSMutableArray<YPGetUserByPhone *> *phoneMarr;

@end

@implementation YPWeddingOrderSearchUserPhoneController

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
    _SearchView.textField.placeholder = @"输入您想查找的接单人手机号";
//    _SearchView.textField.keyboardType =UIKeyboardTypeNumberPad;
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
    return  self.phoneMarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetUserByPhone *phoneModel = self.phoneMarr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    UILabel *label = [[UILabel alloc] init];
    if (phoneModel.NickName.length > 0) {
        label.text = phoneModel.NickName;
    }else{
        label.text = @"无姓名";
    }
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(cell.contentView);
    }];
    UILabel *phoneLabel = [[UILabel alloc] init];
    if (phoneModel.Phone.length > 0) {
        phoneLabel.text = phoneModel.Phone;
    }else{
        phoneLabel.text = @"无手机号";
    }
    phoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    phoneLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [cell.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).mas_offset(18);
        make.centerY.mas_equalTo(label);
    }];
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFont(13);
    addBtn.layer.cornerRadius = 2;
    addBtn.clipsToBounds = YES;
    addBtn.layer.borderColor = RGBA(221, 221, 221, 1).CGColor;
    addBtn.layer.borderWidth = 1;
    addBtn.tag = indexPath.row + 1000;
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18);
        make.centerY.mas_equalTo(cell.contentView);
        make.size.mas_equalTo(CGSizeMake(48, 27));
    }];
    
    return cell;
}

#pragma mark --------tableviewDelegate ------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)addBtnClick:(UIButton *)sender{
    YPGetUserByPhone *phoneModel = self.phoneMarr[sender.tag - 1000];
    if (self.searchBlock) {
        self.searchBlock(phoneModel);
    }
    [self backHome];
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
    if (keyword.length == 11) {
        searchStr =keyword;
        [self GetUserByPhone];
    }else{
        [EasyShowTextView showText:@"请输入11位手机号" inView:searchTableView];
    }
    
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
    NSString *path = [cachePath stringByAppendingString:@"/UserPhone.plist"];
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

#pragma mark - 网络请求
#pragma mark 手机号查询用户
- (void)GetUserByPhone{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetUserByPhone";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"UserPhone"] = searchStr;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.phoneMarr removeAllObjects];
            self.phoneMarr  = [YPGetUserByPhone mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            if (self.phoneMarr.count ==0) {
                [EasyShowTextView showText:@"未查询到用户信息，请输入正确的婚礼桥用户手机号"];
            }
            [searchTableView reloadData];
            if (self.phoneMarr.count > 0) {
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
- (NSMutableArray<YPGetUserByPhone *> *)phoneMarr{
    if (!_phoneMarr) {
        _phoneMarr = [NSMutableArray array];
    }
    return _phoneMarr;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:searchTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:searchTableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetUserByPhone];
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
