//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletDetailLogVC.h"
#import "CXMyWalletDetailLogCell.h"  // cell

#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXMyWalletDetailLogVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tabView;    // <#这里是个注释哦～#>
@end

@implementation CXMyWalletDetailLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"明细";
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
    
    CXMyWalletDetailLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXMyWalletDetailLogCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyWalletDetailLogCell" owner:nil options:nil] lastObject];
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
