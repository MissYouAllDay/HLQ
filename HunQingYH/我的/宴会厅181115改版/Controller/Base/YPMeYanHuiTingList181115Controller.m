//
//  YPMeYanHuiTingList181115Controller.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPMeYanHuiTingList181115Controller.h"
#import "YPMeYanHuiTingListCell.h"
#import "YPMeAddYanHuiTingController.h"//添加宴会厅
#import "YPMeYanHuiTingDetailMoreController.h"//宴会厅详情
#import "YPGetBanquetHallList.h"


@interface YPMeYanHuiTingList181115Controller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetBanquetHallList *> *hallList;

@end

@implementation YPMeYanHuiTingList181115Controller{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetBanquetHallList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
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
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"宴会厅管理";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
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
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:@"添加宴会厅" forState:UIControlStateNormal];
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
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NoTing"]];
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
    return self.hallList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPGetBanquetHallList *hall = self.hallList[indexPath.row];
    
    YPMeYanHuiTingListCell *cell = [YPMeYanHuiTingListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:hall.HotelLogo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    if (hall.BanquetHallName.length > 0) {
        cell.titleLabel.text = hall.BanquetHallName;
    }else{
        cell.titleLabel.text = @"无名称";
    }
    cell.tableCount.text = [NSString stringWithFormat:@"最多容纳%zd桌",hall.MaxTableCount.integerValue];
    cell.mianji.text = [NSString stringWithFormat:@"%.2f㎡",hall.Acreage.floatValue];
    cell.cenggao.text = [NSString stringWithFormat:@"%.2fm",hall.Height.floatValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 136;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPGetBanquetHallList *hall = self.hallList[indexPath.row];
    
    YPMeYanHuiTingDetailMoreController *detail = [[YPMeYanHuiTingDetailMoreController alloc]init];
    detail.BanquetID = hall.BanquetID;
    [self.navigationController yp_pushViewController:detail animated:YES];
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick{
    NSLog(@"addBtnClick");
    YPMeAddYanHuiTingController *addvc = [YPMeAddYanHuiTingController new];
//    addvc.leixingStr = @"1";
    [self.navigationController presentViewController:addvc animated:YES completion:nil];
}

#pragma mark - 网络请求
#pragma mark 根据服务商id获取宴会厅列表
- (void)GetBanquetHallList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetHallList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = FacilitatorId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.hallList = [YPGetBanquetHallList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.tableView reloadData];
            
            if (self.hallList.count == 0) {
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
        //        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        [self showNetErrorEmptyView];
        
    }];
}

#pragma mark - getter
- (NSMutableArray<YPGetBanquetHallList *> *)hallList{
    if (!_hallList) {
        _hallList = [NSMutableArray array];
    }
    return _hallList;
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetBanquetHallList];
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
