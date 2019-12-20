//
//  YPReActivityDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityDetailController.h"
#import "NewsDetailsHeaderView.h"
#import "SDAutoLayout.h"

@interface YPReActivityDetailController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong ) UITableView *tableView;
@property (nonatomic , strong ) NewsDetailsModel *detailModel;
@property (nonatomic , strong ) NewsDetailsHeaderView *headerView;

@end

@implementation YPReActivityDetailController{
    UIView *_navView;
    NSString *_Details;
    NSString *_ShareTitle;
    NSString *_ShareDescribe;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self.headerView updateHeight];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    
    // 初始化子视图
    
    [self initSubview];
    // 设置自动布局
    
    [self configAutoLayout];
    // 设置Block
    
    [self configBlock];
//    [self  loadData];
    
    [self GetFacilitatorActivityInfo];
    
}

-(void)initSubview{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT-50)];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _headerView = [[NewsDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    
    //18-11-02 不能点击放大查看大图 郝
    _headerView.userInteractionEnabled = NO;
    
    self.tableView.tableHeaderView = _headerView;
    
    UIButton *phoneBtn = [[UIButton alloc]init];
    [phoneBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [phoneBtn setBackgroundColor:RGBA(211, 169, 119, 1)];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - target
- (void)phoneBtnClick{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"15192055999"]]];
}

#pragma mark - 加载数据

- (void)loadData{
    
    NewsDetailsModel *dModel = [[NewsDetailsModel alloc]init];
    dModel.newsTitle = @"";
    dModel.newsId = @"";
    dModel.newsHtml = _Details;
    
    self.detailModel = dModel;
    self.headerView.model = dModel;
    
    [self.tableView reloadData];
    
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
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
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview: shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 传递滑动
    
    [self.headerView scroll:scrollView.contentOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - target
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnClick{
    [self showShareSDKWithUrl:[NSString stringWithFormat:@"http://www.chenghunji.com/Capital/FacilitatorActivityInfo?Id=%@",self.RecordId] withtitle:_ShareTitle withdes:_ShareDescribe withIcon:@"http://121.42.156.151:96/2/1/100089/2/0/4f8967b9-800c-446d-b58f-c64f52e59bb5.png"];
}

#pragma mark - 网络请求
#pragma mark 获取服务商活动详情
- (void)GetFacilitatorActivityInfo{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorActivityInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.RecordId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            _Details = [object objectForKey:@"Details"];
            _ShareTitle = [object objectForKey:@"ShareTitle"];
            _ShareDescribe = [object objectForKey:@"ShareDescribe"];
            
            [self loadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - shareSDK
- (void)showShareSDKWithUrl:(NSString*)url withtitle:(NSString *)title withdes:(NSString*)des withIcon:(NSString *)icon{

    [HRShareView showShareViewWithPublishContent:@{@"title" : title,
                                                   @"text"  : des,
                                                   @"image" : icon,
                                                   @"url"   : url}
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeQQFriend) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                      }
                                                      if (type == SSDKPlatformTypeCopy) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                      }
                                                      
                                                  }
                                                      break;
                                                  case SSDKResponseStateFail:
                                                  {
                                                      
                                                      [EasyShowTextView showErrorText:@"分享失败"];
                                                  }
                                                      break;
                                                  case SSDKResponseStateCancel:
                                                  {
                                                      
                                                      [EasyShowTextView showText:@"取消分享"];
                                                  }
                                                      break;
                                                  default:
                                                      break;
                                              }
                                              
                                          }];
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
