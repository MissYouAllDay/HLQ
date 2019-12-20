//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXStoreMyCouponListVC.h"
#import "CXStoreMyCouponListCell.h"  // cell
#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXStoreMyCouponListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tabView;    // <#这里是个注释哦～#>

@end

@implementation CXStoreMyCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);

    NSLog(@"你大爷的");
    [self.view addSubview:self.tabView];
}
// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXStoreMyCouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXStoreMyCouponListCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXStoreMyCouponListCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 37)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *time = [[UILabel alloc] initWithFrame:header.bounds];
    time.left = 15;
    
    time.font = FontW(14, UIFontWeightMedium);
    time.textColor = [CXUtils colorWithHexString:@"#B7B7B7"];
    time.text = @"12月12日";
    [header addSubview:time];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
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
