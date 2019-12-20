//
//  HRHotelTingTableViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHotelTingTableViewController.h"
#import "HRTingCell.h"
#import "HRTingModel.h"
#import "HRHotelTingXQViewController.h"
#import "HRCarCell.h"
#import "HRCarStyleModel.h"
@interface HRHotelTingTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArry;
@end

@implementation HRHotelTingTableViewController
-(NSMutableArray *)dataArry{
    if (!_dataArry) {
        _dataArry =[NSMutableArray array];
        
    }
    return _dataArry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = bgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;

    
    if ([self.zhiyeName isEqualToString:@"酒店"]) {
      [self getTingListRequest];
    }else{
        [self getCheXingRequest];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.zhiyeName isEqualToString:@"酒店"]) {
        HRTingCell *cell = [HRTingCell cellWithTableView:tableView];
        cell.model =self.dataArry[indexPath.row];
        return cell;
    }else{
        HRCarCell *cell = [HRCarCell cellWithTableView:tableView];
        cell.carmodel =self.dataArry[indexPath.row];
        return cell;
    }
   
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HRTingModel *model = self.dataArry[indexPath.row];
    HRHotelTingXQViewController *xqVC = [HRHotelTingXQViewController new];
    xqVC.BanquetID =model.BanquetID;
    [self.navigationController pushViewController:xqVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (void)getTingListRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetBanquetHallList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"RummeryID"]   = [NSString stringWithFormat:@"%zd",self.RummeryID];
    params[@"SupplierID"] =[NSString stringWithFormat:@"%zd",self.SupplierID];
  
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            NSLog(@"宴会厅详情%@",object);

            self.dataArry=[HRTingModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}
-(void)getCheXingRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetSupperTeamInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"SupplierID"] =[NSString stringWithFormat:@"%zd",self.SupplierID];
    
//    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
                        NSLog(@"车型详情%@",object);
            [self.dataArry removeAllObjects];
            self.dataArry=[HRCarStyleModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];

}
@end
