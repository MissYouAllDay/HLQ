//
//  HRHotelJSTableViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHotelJSTableViewController.h"
#import "HRZhuChi01Cell.h"
#import "HRZhuChi02Cell.h"
#import "HRAnLiModel.h"
#import "YPMyAnliDetailController.h"
@interface HRHotelJSTableViewController ()

@property (nonatomic, strong) NSMutableArray<HRAnLiModel *> *anLiArr;

@end

@implementation HRHotelJSTableViewController

#pragma mark - getter
- (NSMutableArray<HRAnLiModel *> *)anLiArr{
    if (!_anLiArr) {
        _anLiArr =[NSMutableArray array];
    }
    return _anLiArr;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CaseInfoInfoList];
    
    self.view.backgroundColor = CHJ_bgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
   
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
    
    return self.anLiArr.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        HRZhuChi01Cell *cell = [HRZhuChi01Cell cellWithTableView:tableView];
        cell.titleLab.text =@"简介";
        if (self.BriefinTroduction.length > 0) {
            cell.desLab.text =self.BriefinTroduction;
        }else{
            cell.desLab.text = @"无简介";
        }
        return cell;
    }else if(indexPath.row ==1){
        HRZhuChi01Cell *cell = [HRZhuChi01Cell cellWithTableView:tableView];
        cell.titleLab.text =@"地址";
        if (self.Adress.length > 0) {
            cell.desLab.text =self.Adress;
        }else{
            cell.desLab.text = @"无地址";
        }
        return cell;
    }else{
        
        HRZhuChi02Cell *cell = [HRZhuChi02Cell cellWithTableView:tableView];
        cell.model =self.anLiArr[indexPath.row-2];
        if (indexPath.row ==2) {
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

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return self.rowhight+40;
    }else if (indexPath.row ==1){
        return 50;
    }else{
        return 180;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        
    }else if (indexPath.row ==1){
        
    }else{
        YPMyAnliDetailController *detailVC = [YPMyAnliDetailController new];
        detailVC.SupplierID =self.SupplierID;
        HRAnLiModel *model =self.anLiArr[indexPath.row-2];
        detailVC.CaseID = model.CaseID;
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    
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
