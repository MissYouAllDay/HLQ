//
//  CXInviteHotelStayLogVC.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInviteHotelStayLogVC.h"
#import "CXInviteHotelStayLogCell.h" // 邀请酒店记录cell

@interface CXInviteHotelStayLogVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;    // tableview
@end

@implementation CXInviteHotelStayLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"记录";
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"hotelStay" highImageName:@"hotelStay" target:self action:@selector(showTelAlert)];
    self.navigationItem.rightBarButtonItems = @[item];
    [self.view addSubview:self.tableView];
}


// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXInviteHotelStayLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXInviteHotelStayLogCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXInviteHotelStayLogCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

// MARK: - Until
//  客服电话
- (void)showTelAlert {
    
    NSString *mobile = @"";
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
        _tableView.rowHeight = 220;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}



@end
