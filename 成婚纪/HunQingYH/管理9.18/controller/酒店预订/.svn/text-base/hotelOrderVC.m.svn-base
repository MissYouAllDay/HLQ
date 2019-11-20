//
//  hotelOrderVC.m
//  HunQingYH
//
//  Created by Hiro on 2019/6/17.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "hotelOrderVC.h"
#import "hotelDanjianManageVC.h"
#import "hotelydtjVC.h"
#import "hotelRenManageVC.h"
#import "hotelCanBiaoVC.h"
#import "hotelRecordVC.h"
#import "YPMeYanHuiTingList181115Controller.h"//18-11-15 宴会厅管理

@interface hotelOrderVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *thisTableview;
}
@end

@implementation hotelOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blueColor];
    
    thisTableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-100-TAB_BAR_HEIGHT)];
    thisTableview.dataSource =self;
    thisTableview.delegate =self;
    [self.view addSubview:thisTableview];
    
}


#pragma mark ---------------------tableviewdatascource--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *restr =@"jiudianSystemcell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:restr];
    if (cell ==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:restr];
    }
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        cell.textLabel.text =@"宴会厅管理";
    }
    if (indexPath.row==1) {
        cell.textLabel.text =@"单间管理";
    }
    if (indexPath.row==2) {
        cell.textLabel.text =@"餐标管理";
    }
    if (indexPath.row==3) {
        cell.textLabel.text =@"人员管理";
    }
    if (indexPath.row==4) {
        cell.textLabel.text =@"预订统计";
    }
    if (indexPath.row==5) {
        cell.textLabel.text =@"操作记录";
    }
    return  cell;
    
}


#pragma mark -------------------tableviewdelegate --------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){
        YPMeYanHuiTingList181115Controller *yanhuiting = [[YPMeYanHuiTingList181115Controller alloc]init];
        [[self getviewController].navigationController pushViewController:yanhuiting animated:YES];
    }
    if (indexPath.row ==1) {
        hotelDanjianManageVC *danjianVC = [hotelDanjianManageVC new];
        [[self getviewController].navigationController pushViewController:danjianVC animated:YES];
        
    }
    if (indexPath.row==2) {
        hotelCanBiaoVC *canbiaovc =[hotelCanBiaoVC new];
        [[self getviewController].navigationController pushViewController:canbiaovc animated:YES];
    }
    if (indexPath.row==3) {
        hotelRenManageVC *renvc =[hotelRenManageVC new];
        [[self getviewController].navigationController pushViewController:renvc animated:YES];
    }
    if (indexPath.row ==4) {
        hotelydtjVC *tongjiVC =[hotelydtjVC new];
        [[self getviewController].navigationController pushViewController:tongjiVC animated:YES];
    }
    if (indexPath.row ==5) {
        hotelRecordVC *recordVC =[hotelRecordVC new];
        [[self getviewController].navigationController pushViewController:recordVC animated:YES];
    }
}

- (UIViewController *)getviewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
