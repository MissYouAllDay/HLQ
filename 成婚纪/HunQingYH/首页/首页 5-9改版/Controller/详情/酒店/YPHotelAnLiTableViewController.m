//
//  YPHotelAnLiTableViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelAnLiTableViewController.h"
#import "HRAnLiModel.h"
#import "HRZhuChi02Cell.h"
#import "YPMyAnliDetailController.h"
#import "YPSupplierHomePageHeader.h"

@interface YPHotelAnLiTableViewController ()

@property (nonatomic, strong) NSMutableArray<HRAnLiModel *> *anLiArr;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation YPHotelAnLiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    [self CaseInfoInfoList];
    
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

#pragma mark - getter
- (NSMutableArray<HRAnLiModel *> *)anLiArr{
    if (!_anLiArr) {
        _anLiArr =[NSMutableArray array];
    }
    return _anLiArr;
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
    
    return self.anLiArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    HRZhuChi02Cell *cell = [HRZhuChi02Cell cellWithTableView:tableView];
    cell.model =self.anLiArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.titleLab.hidden =NO;
        cell.numLab.hidden =NO;
        cell.numLab.text =[NSString stringWithFormat:@"%zd",self.anLiArr.count];
        cell.titleLab.text =@"案例";
    }else{
        cell.titleLab.hidden =YES;
        cell.numLab.hidden =YES;
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YPMyAnliDetailController *detailVC = [YPMyAnliDetailController new];
    detailVC.SupplierID =self.SupplierID;
    HRAnLiModel *model =self.anLiArr[indexPath.row];
    detailVC.CaseID = model.CaseID;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark 获取案例列表 18-08-18 添加 案例需要单调
- (void)CaseInfoInfoList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/CaseInfoInfoList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = self.SupplierID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            
            self.anLiArr = [HRAnLiModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

@end
