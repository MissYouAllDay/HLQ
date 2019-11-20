//
//  YPMyWalletBalanceTiXianController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletBalanceTiXianController.h"
#import "YPMyWalletTiXianAccountCell.h"
#import "YPMyWalletTiXianPriceCell.h"
#import "YPMyWalletBalanceTiXianAccountController.h"//提现输入账号
#import "YPMyWalletTiXianSucController.h"//提现成功

@interface YPMyWalletBalanceTiXianController ()<UITableViewDelegate,UITableViewDataSource,YPMyWalletBalanceTiXianAccountDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**10*/
@property (nonatomic, strong) UIButton *shiBtn;
/**20*/
@property (nonatomic, strong) UIButton *ershiBtn;
/**30*/
@property (nonatomic, strong) UIButton *sanshiBtn;
/**50*/
@property (nonatomic, strong) UIButton *wushiBtn;
/**100*/
@property (nonatomic, strong) UIButton *yibaiBtn;
/**提现*/
@property (nonatomic, strong) UIButton *tiXianBtn;

/**提现账号*/
@property (nonatomic, copy) NSString *account;
/**提现金额*/
@property (nonatomic, copy) NSString *tiXianCount;

@end

@implementation YPMyWalletBalanceTiXianController{
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    
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
    titleLab.text = @"提现";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YPMyWalletTiXianAccountCell *cell = [YPMyWalletTiXianAccountCell cellWithTableView:tableView];
        if (self.account.length > 0) {
            cell.descLabel.text = self.account;
        }
        return cell;
    }else{
        YPMyWalletTiXianPriceCell *cell = [YPMyWalletTiXianPriceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.shiBtn = cell.shiBtn;
        self.ershiBtn = cell.ershiBtn;
        self.sanshiBtn = cell.sanshiBtn;
        self.wushiBtn = cell.wushiBtn;
        self.yibaiBtn = cell.yibaiBtn;
        self.tiXianBtn = cell.tiXianBtn;
        
        [cell.shiBtn addTarget:self action:@selector(shiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.ershiBtn addTarget:self action:@selector(ershiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.sanshiBtn addTarget:self action:@selector(sanshiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.wushiBtn addTarget:self action:@selector(wushiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.yibaiBtn addTarget:self action:@selector(yibaiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.tiXianBtn addTarget:self action:@selector(tiXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        YPMyWalletBalanceTiXianAccountController *account = [[YPMyWalletBalanceTiXianAccountController alloc]init];
        account.accountDelete = self;
        [self.navigationController pushViewController:account animated:YES];
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 90;
//    }else if (indexPath.row == 1){
//        return 250;
//    }
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shiBtnClick{
    NSLog(@"shiBtnClick");
    
    self.shiBtn.selected = !self.shiBtn.selected;
    if (self.shiBtn.isSelected) {
        self.shiBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00];
        self.tiXianCount = @"10";
    }else{
        self.shiBtn.backgroundColor = WhiteColor;
    }
    
    self.ershiBtn.selected = NO;
    self.ershiBtn.backgroundColor = WhiteColor;
    self.sanshiBtn.selected = NO;
    self.sanshiBtn.backgroundColor = WhiteColor;
    self.wushiBtn.selected = NO;
    self.wushiBtn.backgroundColor = WhiteColor;
    self.yibaiBtn.selected = NO;
    self.yibaiBtn.backgroundColor = WhiteColor;
}

- (void)ershiBtnClick{
    NSLog(@"ershiBtnClick");
    
    self.ershiBtn.selected = !self.ershiBtn.selected;
    if (self.ershiBtn.isSelected) {
        self.ershiBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00];
        self.tiXianCount = @"20";
    }else{
        self.ershiBtn.backgroundColor = WhiteColor;
    }
    
    self.shiBtn.selected = NO;
    self.shiBtn.backgroundColor = WhiteColor;
    self.sanshiBtn.selected = NO;
    self.sanshiBtn.backgroundColor = WhiteColor;
    self.wushiBtn.selected = NO;
    self.wushiBtn.backgroundColor = WhiteColor;
    self.yibaiBtn.selected = NO;
    self.yibaiBtn.backgroundColor = WhiteColor;
}

- (void)sanshiBtnClick{
    NSLog(@"sanshiBtnClick");
    
    self.sanshiBtn.selected = !self.sanshiBtn.selected;
    if (self.sanshiBtn.isSelected) {
        self.sanshiBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00];
        self.tiXianCount = @"30";
    }else{
        self.sanshiBtn.backgroundColor = WhiteColor;
    }
    
    self.shiBtn.selected = NO;
    self.shiBtn.backgroundColor = WhiteColor;
    self.ershiBtn.selected = NO;
    self.ershiBtn.backgroundColor = WhiteColor;
    self.wushiBtn.selected = NO;
    self.wushiBtn.backgroundColor = WhiteColor;
    self.yibaiBtn.selected = NO;
    self.yibaiBtn.backgroundColor = WhiteColor;
}

- (void)wushiBtnClick{
    NSLog(@"wushiBtnClick");
    
    self.wushiBtn.selected = !self.wushiBtn.selected;
    if (self.wushiBtn.isSelected) {
        self.wushiBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00];
        self.tiXianCount = @"50";
    }else{
        self.wushiBtn.backgroundColor = WhiteColor;
    }
    
    self.shiBtn.selected = NO;
    self.shiBtn.backgroundColor = WhiteColor;
    self.ershiBtn.selected = NO;
    self.ershiBtn.backgroundColor = WhiteColor;
    self.sanshiBtn.selected = NO;
    self.sanshiBtn.backgroundColor = WhiteColor;
    self.yibaiBtn.selected = NO;
    self.yibaiBtn.backgroundColor = WhiteColor;
}

- (void)yibaiBtnClick{
    NSLog(@"yibaiBtnClick");
    
    self.yibaiBtn.selected = !self.yibaiBtn.selected;
    if (self.yibaiBtn.isSelected) {
        self.yibaiBtn.backgroundColor = [UIColor colorWithRed:0.98 green:0.18 blue:0.44 alpha:1.00];
        self.tiXianCount = @"100";
    }else{
        self.yibaiBtn.backgroundColor = WhiteColor;
    }
    
    self.shiBtn.selected = NO;
    self.shiBtn.backgroundColor = WhiteColor;
    self.ershiBtn.selected = NO;
    self.ershiBtn.backgroundColor = WhiteColor;
    self.sanshiBtn.selected = NO;
    self.sanshiBtn.backgroundColor = WhiteColor;
    self.wushiBtn.selected = NO;
    self.wushiBtn.backgroundColor = WhiteColor;
}

- (void)tiXianBtnClick{
    NSLog(@"tiXianBtnClick");
    
    if (self.tiXianCount.length == 0) {
        [EasyShowTextView showText:@"请选择提现金额" inView:self.view];
    }else if (self.account.length == 0) {
        [EasyShowTextView showText:@"请输入提现账号" inView:self.view];
    }else{
        [self ApplicationPresentation];
    }
    
}

#pragma mark - YPMyWalletBalanceTiXianAccountDelegate
- (void)yp_tixianAccount:(NSString *)account{
    NSLog(@"---- %@",account);
    
    self.account = account;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 网络请求
#pragma mark 申请提现
- (void)ApplicationPresentation{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/ApplicationPresentation";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    params[@"Money"] = self.tiXianCount;
    params[@"AccountCode"] = self.account;
    params[@"AccountType"] = @"1";//1支付宝,2银行卡
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            YPMyWalletTiXianSucController *suc = [[YPMyWalletTiXianSucController alloc]init];
            [self.navigationController pushViewController:suc animated:YES];
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
