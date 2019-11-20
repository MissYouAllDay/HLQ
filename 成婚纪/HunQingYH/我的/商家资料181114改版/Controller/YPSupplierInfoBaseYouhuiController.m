//
//  YPSupplierInfoBaseYouhuiController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/14.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPSupplierInfoBaseYouhuiController.h"
#import "YPSupplierInfoBaseYouhuiListCell.h"
#import "YPSupplierInfoAddYouhuiController.h"//添加基础优惠
#import "YPGetFacilitatorBasicPreferences.h"

@interface YPSupplierInfoBaseYouhuiController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) __block NSMutableArray<YPGetFacilitatorBasicPreferences *> *dataSource;

@end

@implementation YPSupplierInfoBaseYouhuiController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetFacilitatorBasicPreferences];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).mas_offset(15);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"基础优惠";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"管理" forState:UIControlStateNormal];
    [moreBtn setTitleColor:RGBS(51) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = kFont(16);
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-48-HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"添加优惠" forState:UIControlStateNormal];
    [addBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [addBtn setBackgroundColor:RGB(250, 80, 120)];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(48);
        make.bottom.mas_equalTo(-HOME_INDICATOR_HEIGHT);
    }];
}

- (void)setupNoDataView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoYouHui"]];
    [view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.centerX.mas_equalTo(view);
    }];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-48-HOME_INDICATOR_HEIGHT);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
    
    YPSupplierInfoBaseYouhuiListCell *cell = [YPSupplierInfoBaseYouhuiListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [NSString stringWithFormat:@"优惠 %ld",indexPath.row+1];
    if (base.Discount.length > 0) {
        cell.contentLabel.text = base.Discount;
    }else{
        cell.contentLabel.text = @"无优惠";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
    
    YPSupplierInfoAddYouhuiController *add = [[YPSupplierInfoAddYouhuiController alloc]init];
    add.titleStr = @"修改优惠";
    add.placeHolder = @"请填写基础优惠内容";
    add.limitCount = 150;
    add.editRemark = base.Discount;
    add.recordID = base.Id;
    [self.navigationController pushViewController:add animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            YPGetFacilitatorBasicPreferences *base = self.dataSource[indexPath.row];
            [self DeleteFacilitatorBasicPreferencesWithRecordID:base.Id];
        }
            break;
        default:
            break;
    }
}

#pragma mark - target
- (void)backVC{
    
    //返回优惠数量
    self.baseCountBlock(self.dataSource.count);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.tableView.editing = YES;
        [sender setTitle:@"完成" forState:UIControlStateSelected];
    }else{
        [sender setTitle:@"管理" forState:UIControlStateNormal];
        self.tableView.editing = NO;
    }
}

- (void)addBtnClick{
    NSLog(@"addBtnClick");
    
    YPSupplierInfoAddYouhuiController *add = [[YPSupplierInfoAddYouhuiController alloc]init];
    add.titleStr = @"添加优惠";
    add.placeHolder = @"请填写基础优惠内容";
    add.limitCount = 150;
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark 获取服务商基础优惠
- (void)GetFacilitatorBasicPreferences{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorBasicPreferences";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.dataSource removeAllObjects];
            self.dataSource = [YPGetFacilitatorBasicPreferences mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.tableView reloadData];
            if (self.dataSource.count == 0) {
                [self setupNoDataView];
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

#pragma mark 删除服务商基础优惠
- (void)DeleteFacilitatorBasicPreferencesWithRecordID:(NSString *)recordID{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/DeleteFacilitatorBasicPreferences";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = recordID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [EasyShowTextView showSuccessText:@"删除优惠成功!" inView:self.tableView];
            [self GetFacilitatorBasicPreferences];
            
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

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorBasicPreferences *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
