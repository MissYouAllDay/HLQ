//
//  HRNewsDetailViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRNewsDetailViewController.h"
#import "NewsDetailsAPI.h"
#import "NewsDetailsHeaderView.h"
#import "SDAutoLayout.h"
@interface HRNewsDetailViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong ) UITableView *tableView;
@property (nonatomic , strong ) NewsDetailsAPI *api;
@property (nonatomic , strong ) NewsDetailsModel *model;
@property (nonatomic , strong ) NewsDetailsHeaderView *headerView;
@end
@implementation HRNewsDetailViewController

{
    UIView *_navView;
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

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self.headerView updateHeight];
}

- (void)initData{
    
    _api = [[NewsDetailsAPI alloc] init];
    
   
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
 

    // 初始化数据
    
    [self initData];
    
    // 初始化子视图
    
    [self initSubview];
    // 设置自动布局
    
    [self configAutoLayout];
    // 设置Block
    
    [self configBlock];
    [self  loadData];
    
//    [self GetNewsDetail];
}

-(void)initSubview{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT)];

    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _headerView = [[NewsDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    
    self.tableView.tableHeaderView = _headerView;
}
#pragma mark - 加载数据

- (void)loadData{
    
    __weak typeof(self) weakSelf = self;
    
    [self.api loadDataWithNewsId:self.newsId ResultBlock:^(NewsDetailsModel *model) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!strongSelf) return ;
        
        if (model) {
            
            strongSelf.model = model;
            strongSelf.headerView.model = model;

            
          
            
            [strongSelf.tableView reloadData];
            
       
            
        } else {
            
            // 请求失败 提示用户
        }
        
    }];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}
#pragma mark - 设置自动布局

- (void)configAutoLayout{
    
   
    
    self.tableView.sd_layout
    .topSpaceToView(_navView, 0.0f)
    .bottomSpaceToView(self.view, 0.0f)
    .leftSpaceToView(self.view, 0.0f)
    .rightSpaceToView(self.view, 0.0);
    
    self.headerView.sd_layout
    .xIs(0)
    .yIs(0)
    .widthRatioToView(self.tableView, 1.0f);
}

#pragma mark - 设置Block

- (void)configBlock{
    
    __weak typeof(self) weakSelf = self;
    
    self.headerView.loadedFinishBlock = ^(BOOL result) {
        
        if (!weakSelf) return ;
        
        if (result) {
            
            weakSelf.tableView.hidden = NO;
            
            weakSelf.tableView.alpha = 0.0f;
            
            [UIView animateWithDuration:0.3f animations:^{
                
                weakSelf.tableView.alpha = 1.0f;
            }];
            NSLog(@"加载成功");
            
        } else {
            
            // 加载失败 提示用户
            NSLog(@"加载失败");
        }
        
    };
    
    self.headerView.updateHeightBlock = ^(NewsDetailsHeaderView *view) {
        
        if (!weakSelf) return ;
        
        weakSelf.tableView.tableHeaderView = view;
    };
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 传递滑动
    
    [self.headerView scroll:scrollView.contentOffset];
}
//#pragma mark - 网络请求
//- (void)GetNewsDetail{
//
//    [EasyShowLodingView showLoding];
//
//    NSString *url = @"/api/HQOAApi/GetInformationArticleInfo";
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"InformationArticleID"] =self.newsId;
//    params[@"GetType"] = @"1";
//
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            NSLog(@"资讯详情：%@",object);
//
//
//        }else{
//
//            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
//        }
//
//    } Failure:^(NSError *error) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
//
//    }];
//
//}


@end
