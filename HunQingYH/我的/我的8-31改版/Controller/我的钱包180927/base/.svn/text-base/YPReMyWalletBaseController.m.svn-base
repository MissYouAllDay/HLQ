//
//  YPReMyWalletBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPReMyWalletBaseController.h"
#import "HRTiXianViewController.h"
#import "YPReMyWalletBalanceCell.h"
#import "YPReMyWalletBankCell.h"
#import "YPReMyWalletBankListController.h"//银行卡列表
#import "YPReMyWalletDetailListController.h"//明细
#import "YPGetFacilitatorMoneyFlowingWaterList.h"

@interface YPReMyWalletBaseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YPGetFacilitatorMoneyFlowingWaterList *listModel;

@end

@implementation YPReMyWalletBaseController{
    UIView *_navView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self GetFacilitatorMoneyFlowingWaterList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
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
    titleLab.text = @"我的钱包";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];

    UIButton *listBtn = [[UIButton alloc]init];
    [listBtn setTitle:@"明细" forState:UIControlStateNormal];
    [listBtn setTitleColor:RGBS(102) forState:UIControlStateNormal];
    listBtn.titleLabel.font = kFont(16);
    [listBtn addTarget:self action:@selector(listBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:listBtn];
    [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.right.mas_equalTo(-18);
    }];
    

}

#pragma mark - UI
- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-62) style:UITableViewStylePlain];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = ClearColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.scrollEnabled = NO;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = CHJ_bgColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"提现" forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(255, 207, 139, 1) forState:UIControlStateNormal];
    btn.titleLabel.font = kFont(16);
    btn.backgroundColor = RGBA(51, 51, 51, 1);
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-12);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YPReMyWalletBalanceCell *cell = [YPReMyWalletBalanceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.balance.text = [NSString stringWithFormat:@"%zd",self.listModel.Balance.integerValue];
        return cell;
    }else{
        YPReMyWalletBankCell *cell = [YPReMyWalletBankCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.countLabel.text = [NSString stringWithFormat:@"%zd",self.listModel.AccountNumber.integerValue];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        YPReMyWalletBankListController *list = [[YPReMyWalletBankListController alloc]init];
        list.titleStr = @"我的银行卡";
        [self.navigationController pushViewController:list animated:YES];
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    HRTiXianViewController *tiVC = [HRTiXianViewController new];
    [self.navigationController pushViewController:tiVC animated:YES];
}

- (void)listBtnClick{
    NSLog(@"listBtnClick");
    YPReMyWalletDetailListController *detail = [[YPReMyWalletDetailListController alloc]init];
    detail.dataArr = self.listModel.Data;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取服务商流水/余额/账号数量
- (void)GetFacilitatorMoneyFlowingWaterList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorMoneyFlowingWaterList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10";
    if (YongHu(Profession_New)) {
        params[@"FacilitatorId"] = UserId_New;
        params[@"Type"] = @"1";//1新人,2服务商
    }else{
        params[@"FacilitatorId"] = FacilitatorId_New;
        params[@"Type"] = @"2";//1新人,2服务商
    }

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listModel.TotalCount        = [object objectForKey:@"TotalCount"];
            self.listModel.Balance           = [object objectForKey:@"Balance"];
            self.listModel.AccountNumber     = [object objectForKey:@"AccountNumber"];
            self.listModel.Data              = [YPGetFacilitatorMoneyFlowingWaterListData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
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
- (YPGetFacilitatorMoneyFlowingWaterList *)listModel{
    if (!_listModel) {
        _listModel = [[YPGetFacilitatorMoneyFlowingWaterList alloc]init];
    }
    return _listModel;
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
