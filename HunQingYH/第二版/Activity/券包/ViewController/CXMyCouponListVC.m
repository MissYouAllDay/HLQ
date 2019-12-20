//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyCouponListVC.h"
#import "CXMyCouponListCell.h"      // list cell

#import "CXMyCouponNotUsedDetailVC.h"   // 未使用

#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXMyCouponListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tableView;    // <#这里是个注释哦～#>

@end

@implementation CXMyCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);

    NSLog(@"你大爷的");
    [self.view addSubview:self.tableView];
}
// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXMyCouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXMyCouponListCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXMyCouponListCell" owner:nil options:nil] lastObject];
    }
    
    switch (self.conpouType) {
        case ConpouTypeNotUsed:     [cell notUsed];     break;
        case ConpouTypeAlreadyUsed: [cell alreadyUsed]; break;
        case ConpouTypeExpired:     [cell expired];     break;
        default: break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.conpouType) {
        case ConpouTypeNotUsed:     [self pushCXMyCouponNotUsedDetailVC];     break;
        case ConpouTypeAlreadyUsed: [self pushCXMyCouponNotUsedDetailVC];     break;
        case ConpouTypeExpired:     [self pushCXMyCouponNotUsedDetailVC];     break;
        default: break;
    }
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (CXBaseTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[CXBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [CXUtils colorWithHexString:@"#F1F0F0"];
    }
    return _tableView;
}

// MARK: - push
// 未使用
- (void)pushCXMyCouponNotUsedDetailVC {
    
    CXMyCouponNotUsedDetailVC *vc = [[CXMyCouponNotUsedDetailVC alloc] init];
    [self.mainNa pushViewController:vc animated:YES];
}

@end
