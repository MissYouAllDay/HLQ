//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletBackMoneyLogVC.h"
#import "CXMyWalletBackMoneyLogCell.h"  // cell

#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXMyWalletBackMoneyLogVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tabView;    // <#这里是个注释哦～#>
@end

@implementation CXMyWalletBackMoneyLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"返现详情";
    [self configerUI];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)configerUI {
    [self.view addSubview:self.tabView];
}


// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXMyWalletBackMoneyLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXMyWalletBackMoneyLogCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyWalletBackMoneyLogCell" owner:nil options:nil] lastObject];
    }
    
    if (indexPath.row == 0) {
        [cell freeStatus];
    }else {
        [cell shareStatus];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Line375(68);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
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


@end
