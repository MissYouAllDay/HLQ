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


@end

@implementation HRHotelJSTableViewController
-(NSMutableArray *)anLiArr{
    if (!_anLiArr) {
        _anLiArr =[NSMutableArray array];
    }
    return _anLiArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self getXQRequest];
    self.view.backgroundColor = bgColor;
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
        cell.desLab.text =self.BriefinTroduction;
        return cell;
    }else if(indexPath.row ==1){
        HRZhuChi01Cell *cell = [HRZhuChi01Cell cellWithTableView:tableView];
        cell.titleLab.text =@"地址";
        cell.desLab.text =self.Adress;
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
        return self.rowhight+30;
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
        detailVC.CaseID =[NSString stringWithFormat:@"%zd",model.CaseID];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    
}


@end
