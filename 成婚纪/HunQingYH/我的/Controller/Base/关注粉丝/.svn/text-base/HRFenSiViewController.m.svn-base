//
//  HRFenSiViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRFenSiViewController.h"
#import "HRLikeListCell.h"
@interface HRFenSiViewController ()<UITableViewDelegate,UITableViewDataSource>{
        UITableView *thisTableView;
}

@end

@implementation HRFenSiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
-(void)createUI{
    thisTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
    
    
}


#pragma mark --------tableviewDatasscoure -------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRLikeListCell *cell = [HRLikeListCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark --------tableviewDelegate -----------

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转到个人信息页面
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
