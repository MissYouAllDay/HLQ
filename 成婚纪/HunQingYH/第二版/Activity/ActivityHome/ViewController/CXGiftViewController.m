//
//  CXGiftViewController.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXGiftViewController.h"
#import "CXGiftTableViewCell.h"
@interface CXGiftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CXGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = Line375(170);
        _tableView.estimatedRowHeight = UITableViewRowAnimationAutomatic;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXGiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXGiftTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXGiftTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.mainImg.image = [UIImage imageNamed:self.dataArr[indexPath.row]];
    return cell;
}

- (UIView *)listView {
    
    return self.view;
}

@end
