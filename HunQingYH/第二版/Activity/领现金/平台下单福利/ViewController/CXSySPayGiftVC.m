//
//  CXInviteHotelStayLogVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXSySPayGiftVC.h"
#import "CXSuspayGiftCell.h" // 优惠券cell

@interface CXSySPayGiftVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;    // tableview

@property (nonatomic, strong) UIView  *tableHeaderView;    // headerView
@end

@implementation CXSySPayGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"平台下单福利";
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"kefu" highImageName:@"kefu" target:self action:@selector(showTelAlert)];
    self.navigationItem.rightBarButtonItems = @[item];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
}


// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXSuspayGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXSuspayGiftCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXSuspayGiftCell" owner:nil options:nil] lastObject];
    }
    
    cell.bgImg.image = [UIImage imageNamed:@"宝宝照"];
    return cell;
}

// MARK: - Until
//  客服电话
- (void)showTelAlert {
    
    NSString *mobile = kefuTel;
    NSString *mobileCpmplete = [NSString stringWithFormat:@"tel://%@",mobile];
      NSURL *url = [NSURL URLWithString:mobileCpmplete];
      [[UIApplication sharedApplication] openURL:url];
}

// MARK: - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenContentHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 200;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(50))];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_tableHeaderView.bounds];
        img.backgroundColor = [UIColor orangeColor];
        img.image = [UIImage imageNamed:@"giftAlert"];
        
        [_tableHeaderView addSubview:img];
    }
    
    return _tableHeaderView;
}


@end
