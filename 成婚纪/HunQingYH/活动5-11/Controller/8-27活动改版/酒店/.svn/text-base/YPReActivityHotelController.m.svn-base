//
//  YPReActivityHotelController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityHotelController.h"
#import "YPReActivityAllListController.h"
#import "YPReActivityHotelDingZhiontroller.h"
#import "YPReActivityHunQingDingZhiController.h"
#import "YPReActivityPersonOrderCell.h"
#import "YPReActivityListCell.h"
#import "YPGetFacilitatorActivityCoverMapList.h"
#import "YPReActivityDetailController.h"//富文本
#import "HRHotelViewController.h"
#import "YPSupplierOtherInfoController.h"
#import "YPSupplierHomePage181119Controller.h"//商家主页

@interface YPReActivityHotelController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetFacilitatorActivityCoverMapList *> *listMarr;

@end

@implementation YPReActivityHotelController

#pragma mark - 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self GetFacilitatorActivityCoverMapList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupUI];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = CHJ_bgColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1+self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YPReActivityPersonOrderCell *cell = [YPReActivityPersonOrderCell cellWithTableView:tableView];
        cell.backgroundColor = CHJ_bgColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.TopImg] placeholderImage:[UIImage imageNamed:@"占位"]];
        return cell;
    }else{
    
        YPGetFacilitatorActivityCoverMapList *list = self.listMarr[indexPath.row - 1];
        
        YPReActivityListCell *cell = [YPReActivityListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = CHJ_bgColor;
        cell.dataArr = list.Data;
        if (list.FacilitatorName.length > 0) {
            [cell.titleBtn setTitle:list.FacilitatorName forState:UIControlStateNormal];
        }else{
            [cell.titleBtn setTitle:@"无名称" forState:UIControlStateNormal];
        }
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.HeadImg] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
            NSLog(@"colCellClick -- %@-%@",sectionName,indexPath);
            
            YPReActivityDetailController *detail = [[YPReActivityDetailController alloc]init];
            YPGetFacilitatorActivityCoverMapListData *data = list.Data[indexPath.item];
            detail.RecordId = data.Id;
            [self.navigationController pushViewController:detail animated:YES];
        };
        
        cell.titleBtn.tag = indexPath.row-1 + 1000;
        [cell.titleBtn addTarget:self action:@selector(homePageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.allBtn.tag = indexPath.row-1 + 1000;
        [cell.allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 128;
    }else{
        return ScreenWidth*0.85*0.66+20+80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        if (JiuDian(self.IdentityId)) {
            YPReActivityHotelDingZhiontroller *dingzhi = [[YPReActivityHotelDingZhiontroller alloc]init];
            dingzhi.titleStr = @"酒店";
            dingzhi.IdentityId = self.IdentityId;
            [self.navigationController pushViewController:dingzhi animated:YES];
        }else if (HunQing(self.IdentityId)){
            YPReActivityHunQingDingZhiController *dingzhi = [[YPReActivityHunQingDingZhiController alloc]init];
            dingzhi.titleStr = @"婚庆";
            dingzhi.IdentityId = self.IdentityId;
            [self.navigationController pushViewController:dingzhi animated:YES];
        }else{//18-08-30 其他身份定制--未知
            YPReActivityHunQingDingZhiController *dingzhi = [[YPReActivityHunQingDingZhiController alloc]init];
            dingzhi.titleStr = @"其他";
            dingzhi.IdentityId = self.IdentityId;
            [self.navigationController pushViewController:dingzhi animated:YES];
        }
    }
    
}

#pragma mark - 网络请求
#pragma mark 根据身份获取活动服务商列表
- (void)GetFacilitatorActivityCoverMapList{
    
    NSString *url = @"/api/HQOAApi/GetFacilitatorActivityCoverMapList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.IdentityId;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"20";

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.listMarr = [YPGetFacilitatorActivityCoverMapList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorActivityCoverMapList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - target
- (void)allBtnClick:(UIButton *)sender{
    
    YPGetFacilitatorActivityCoverMapList *list = self.listMarr[sender.tag-1000];
    
    YPReActivityAllListController *all = [[YPReActivityAllListController alloc]init];
    if (list.FacilitatorName.length > 0) {
        all.titleStr = list.FacilitatorName;
    }else{
        all.titleStr = @"无名称";
    }
    all.IdentityId = self.IdentityId;
    all.dataArr = list.Data;
    [self.navigationController pushViewController:all animated:YES];
}

- (void)homePageClick:(UIButton *)sender{
    YPGetFacilitatorActivityCoverMapList *list = self.listMarr[sender.tag-1000];
    
    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = list.FacilitatorId;
    hotelVC.profession = self.IdentityId;
    [self.navigationController pushViewController:hotelVC animated:YES];
    
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
