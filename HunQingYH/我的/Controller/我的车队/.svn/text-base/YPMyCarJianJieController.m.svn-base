//
//  YPMyCarJianJieController.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyCarJianJieController.h"
#import "YPMyCarJianJieImgCell.h"
#import "YPMyCarTextCell.h"
#import "YPMyCarAnLiCell.h"

@interface YPMyCarJianJieController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPMyCarJianJieController

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kNavH-40) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = bgColor;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YPMyCarJianJieImgCell *cell = [YPMyCarJianJieImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        YPMyCarTextCell *cell = [YPMyCarTextCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"名字";
            cell.descLabel.text = @"青岛市挨我婚车礼仪公司";
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"简介";
            cell.descLabel.text = @"青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司";
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"地址";
            cell.descLabel.text = @"青岛市挨我婚车礼仪公司青岛市挨我婚车礼仪公司";
        }else{
            
            YPMyCarAnLiCell *cell = [YPMyCarAnLiCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 4) {
                
                cell.titleLabel.hidden = NO;
                cell.numLabel.hidden = NO;
                
            }else if (indexPath.row == 5){
                
                cell.titleLabel.hidden = YES;
                cell.numLabel.hidden = YES;
            }
            
            return cell;
        }
        
        return cell;

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
