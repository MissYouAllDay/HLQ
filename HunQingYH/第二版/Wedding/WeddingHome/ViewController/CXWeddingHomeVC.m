//
//  CXWeddingHomeVC.m
//  HunQingYH
//
//  Created by apple on 2019/10/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXWeddingHomeVC.h"

@interface CXWeddingHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation CXWeddingHomeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
       _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];

       _tableView.delegate = self;
       _tableView.dataSource = self;
       _tableView.backgroundColor = WhiteColor;
       _tableView.estimatedRowHeight = 0;
       _tableView.estimatedSectionFooterHeight = 0;
       _tableView.estimatedSectionHeaderHeight = 0;
       _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}


@end
