//
//  HRGuanZhuViewController.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRGuanZhuViewController.h"
#import "HRDTOneImageCell.h"
#import "HRDTTwoImageCell.h"
#import "HRDTThreeImageCell.h" 
@interface HRGuanZhuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *thisTableView;
}
@end

@implementation HRGuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    [self createUI];
    
}
-(void)createUI{
    thisTableView  = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    thisTableView.delegate =self;
    thisTableView.dataSource =self;
    thisTableView.backgroundColor =CHJ_bgColor;
    [self.view addSubview:thisTableView];
}

#pragma mark -----------tableviewDatascource -------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row ==0){
        HRDTOneImageCell *cell = [HRDTOneImageCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.row ==1){
        HRDTTwoImageCell *cell = [HRDTTwoImageCell cellWithTableView:tableView];
        return cell;
    }else{
        HRDTThreeImageCell * cell = [HRDTThreeImageCell cellWithTableView:tableView];
        return cell;
    }
}
#pragma mark -----------tableviewDelegate -------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth;
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
