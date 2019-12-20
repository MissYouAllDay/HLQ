//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletVC.h"
#import "CXStoreMyCouponListCell.h"  // cell
#import "CXMyWalletTableViewHeadView.h"     // 账户余额
#import "CXMyWalletTableViewCell.h"         //  cell

#import "CXMyWalletMoneyVC.h"           // 钱包
#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXMyWalletVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tabView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) CXMyWalletTableViewHeadView  *tableHeaderView;    // <#这里是个注释哦～#>
@end

@implementation CXMyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configerUI];
    self.view.backgroundColor = [UIColor whiteColor];
    [self defaSetting];
}

- (void)configerUI {
    [self.view addSubview:self.tabView];
    self.tabView.tableHeaderView = self.tableHeaderView;
}

- (void)defaSetting {
    
    self.tableHeaderView.moneyLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self pushCXMyWalletMoneyVC];
    }];
    [self.tableHeaderView.moneyLab addGestureRecognizer:tap];
}



// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXMyWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXMyWalletTableViewCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyWalletTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Line375(118);
}

- (CXBaseTableView *)tabView {
    
    if (!_tabView) {
        
        _tabView = [[CXBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tabView.delegate = self;
        _tabView.dataSource = self;
        _tabView.backgroundColor = [CXUtils colorWithHexString:@"#F3F2F2"];
    }
    return _tabView;
}

- (CXMyWalletTableViewHeadView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"CXMyWalletTableViewHeadView" owner:nil options:nil] lastObject];
        _tableHeaderView.frame = CGRectMake(0, 0, ScreenWidth, Line375(185));
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabView.backgroundColor = [UIColor whiteColor];
    }
    return _tableHeaderView;
}

// MARK: - push
- (void)pushCXMyWalletMoneyVC {
    
    CXMyWalletMoneyVC *vc = [[CXMyWalletMoneyVC alloc] initWithNibName:@"CXMyWalletMoneyVC" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
