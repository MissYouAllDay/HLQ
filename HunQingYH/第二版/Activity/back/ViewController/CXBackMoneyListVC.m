//
//  CXBackMoneyListVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/9.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXBackMoneyListVC.h"
#import "YPHYTHBaseListCell.h"  // model
#import "CXBackMoneyLiseCell.h" // 婚庆、婚纱 cell

#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface CXBackMoneyListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tableView;    // <#这里是个注释哦～#>
@property (nonatomic, strong) NSMutableArray  *dataArr;    // <#这里是个注释哦～#>
@end

@implementation CXBackMoneyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);

    NSLog(@"你大爷的");
    [self.view addSubview:self.tableView];
}
// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.type == 0) {
        YPHYTHBaseListCell *cell = [YPHYTHBaseListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.allBackImg.hidden = NO;
        return cell;
    }else {
        CXBackMoneyLiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXBackMoneyLiseCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CXBackMoneyLiseCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.allBackImg.hidden = NO;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.type == 0 ? 70 : Line375(252);
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
    }
    return _tableView;
}

@end
