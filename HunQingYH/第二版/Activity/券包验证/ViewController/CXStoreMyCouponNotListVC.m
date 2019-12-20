//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXStoreMyCouponNotListVC.h"
#import "CXStoreMyCouponEndListCell.h"  // cell
#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXStoreMyCouponNotListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tabView;    // <#这里是个注释哦～#>

@end

@implementation CXStoreMyCouponNotListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);

    NSLog(@"你大爷的");
    [self.view addSubview:self.tabView];
}
// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXStoreMyCouponEndListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXStoreMyCouponEndListCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXStoreMyCouponEndListCell" owner:nil options:nil] lastObject];
    }
    
    cell.nameLab.text = @"张三";
    cell.telLab.text = @"155****1234";
    cell.statusLab.text = @"待验证";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (CXBaseTableView *)tabView {
    
    if (!_tabView) {
        
        _tabView = [[CXBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tabView.delegate = self;
        _tabView.dataSource = self;
    }
    return _tabView;
}

@end
