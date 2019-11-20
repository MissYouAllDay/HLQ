//
//  HRHotelTingTableViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHotelTingTableViewController.h"
#import "YPMeYanHuiTingListCell.h"
#import "YPGetBanquetHallList.h"
#import "YPHYTHDetailController.h"
//#import "HRHotelTingXQViewController.h"
#import "YPMeYanHuiTingDetailController.h"//宴会厅详情
#import "HRCarCell.h"
#import "HRCarStyleModel.h"
#import "YPSupplierHomePageHeader.h"

@interface HRHotelTingTableViewController ()
@property(nonatomic,strong)NSMutableArray<YPGetBanquetHallList *> *dataArry;
@property (nonatomic, assign) BOOL canScroll;
@end

@implementation HRHotelTingTableViewController

#pragma mark - getter
- (NSMutableArray<YPGetBanquetHallList *> *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;

    
    if (JiuDian(self.zhiyeName)) {
        [self GetBanquetHallList];
    }else{
        [self getCheXingRequest];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil]; //其中一个TAB离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0
}

- (void)acceptMsg:(NSNotification *)notification {
    //NSLog(@"%@",notification);
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kGoTopNotificationName]) {
        self.canScroll = YES;
        self.tableView.showsVerticalScrollIndicator = YES;
    }else if([notificationName isEqualToString:kLeaveTopNotificationName]){
        self.tableView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:nil];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (JiuDian(self.zhiyeName)) {
        YPGetBanquetHallList *hall = self.dataArry[indexPath.row];
        
        YPMeYanHuiTingListCell *cell = [YPMeYanHuiTingListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:hall.HotelLogo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (hall.BanquetHallName.length > 0) {
            cell.titleLabel.text = hall.BanquetHallName;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        cell.tableCount.text = [NSString stringWithFormat:@"最多容纳%zd桌",hall.MaxTableCount.integerValue];
        cell.mianji.text = [NSString stringWithFormat:@"%.2f㎡",hall.Acreage.floatValue];
        cell.cenggao.text = [NSString stringWithFormat:@"%.2fm",hall.Height.floatValue];
        return cell;
    }else{
        HRCarCell *cell = [HRCarCell cellWithTableView:tableView];
        cell.carmodel =self.dataArry[indexPath.row];
        return cell;
    }
   
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YPGetBanquetHallList *model = self.dataArry[indexPath.row];
//    //19-08-24 修改
    YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
    [detail setDetailID:model.BanquetID];
    [self.navigationController yp_pushViewController:detail animated:YES];
    //18-11-19 修改
//    YPMeYanHuiTingDetailController *detail = [[YPMeYanHuiTingDetailController alloc]init];
//    detail.BanquetID = model.BanquetID;
//    [self.navigationController yp_pushViewController:detail animated:YES];
    
//    HRHotelTingXQViewController *xqVC = [HRHotelTingXQViewController new];
//    xqVC.BanquetID = model.BanquetID;
//    [self.navigationController pushViewController:xqVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 136;
}

#pragma mark - 根据服务商id获取宴会厅列表
- (void)GetBanquetHallList{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetBanquetHallList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =self.SupplierID;
  
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
//            NSLog(@"宴会厅详情%@",object);

            self.dataArry = [YPGetBanquetHallList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
            if (self.dataArry.count > 0) {
                [self hidenEmptyView];
            }else{
                [self showNoDataEmptyView];
            }
            
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
    NSString *url = @"/api/HQOAApi/GetSupperTeamInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"SupplierID"] =self.SupplierID;
    
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

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetBanquetHallList];
    }];
    
}

-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

@end
