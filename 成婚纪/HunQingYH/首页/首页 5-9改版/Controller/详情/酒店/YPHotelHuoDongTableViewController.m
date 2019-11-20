//
//  YPHotelHuoDongTableViewController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/30.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelHuoDongTableViewController.h"
#import "YPReActivityHotelDingZhiontroller.h"
#import "YPReActivityHunQingDingZhiController.h"
#import "YPReActivityAllListCell.h"
#import "YPReActivityDetailController.h"
#import "YPGetFacilitatorActivityList.h"
#import "YPWedPackageDetailWuLiaoController.h"//富文本
#import "YPSupplierHomePageHeader.h"
#import "YPGetPreferentialCommodityList.h"//19-02-22
#import "YPHYTHDetailController.h"
#import "YPHYTHBaseListCell.h"
#import "YPHYTHNoDataCell.h"
#import "YPContractController.h"

@interface YPHotelHuoDongTableViewController ()

@property (nonatomic, strong) NSMutableArray<YPGetPreferentialCommodityList *> *listMarr;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation YPHotelHuoDongTableViewController{
    NSInteger _pageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _pageIndex = 1;
    
    [self GetPreferentialCommodityList];
    
    self.view.backgroundColor = WhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = [UIView new];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetPreferentialCommodityList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetPreferentialCommodityList];
    }];
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listMarr.count == 0 ? 1 : self.listMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.listMarr.count == 0) {
        YPHYTHNoDataCell *cell = [YPHYTHNoDataCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.doneBtn addTarget:self action:@selector(ruzhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        YPGetPreferentialCommodityList *list = self.listMarr[indexPath.row];
        
        YPHYTHBaseListCell *cell = [YPHYTHBaseListCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:list.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.FacilitatorImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        if (list.Name.length > 0) {
            cell.tingTitle.text = list.Name;
        }else{
            cell.tingTitle.text = @"当前无名称";
        }
        if (list.FacilitatorName.length > 0) {
            cell.titleLabel.text = list.FacilitatorName;
        }else{
            cell.titleLabel.text = @"当前无名称";
        }
        cell.canbiao.text = list.Price;
        cell.zhuoshu.text = [NSString stringWithFormat:@"%@-%@",list.MinTable,list.MaxTable];
        cell.lijian.text = [NSString stringWithFormat:@"%zd%%",list.Discount];
        cell.countLabel.text = [NSString stringWithFormat:@"%zd",list.SalesVolume];
        return cell;
    }
    
//    YPGetPreferentialCommodityList *data = self.listMarr[indexPath.row];
//
//    YPReActivityAllListCell *cell = [YPReActivityAllListCell cellWithTableView:tableView];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:data.CoverMap] placeholderImage:[UIImage imageNamed:@"占位"]];
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.listMarr.count == 0 ? 450 : ScreenWidth*0.78;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.listMarr.count == 0) {
        
    }else{
        YPGetPreferentialCommodityList *list = self.listMarr[indexPath.row];
        
        YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
        detail.detailID = list.Id;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
//    YPGetPreferentialCommodityList *data = self.listMarr[indexPath.row];
//
//    YPWedPackageDetailWuLiaoController *detail  = [[YPWedPackageDetailWuLiaoController alloc]init];
//    detail.contentStr = data.Details;
//    //18-11-07 分享
//    detail.typeTag = 1;
//    detail.ShareTitle = data.ShareTitle;
//    detail.ShareDescribe = data.ShareDescribe;
//    detail.RecordID = data.Id;
//    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark - target
- (void)ruzhuBtnClick{
    //联系我们
    YPContractController *contract = [[YPContractController alloc]init];
    [self.navigationController presentViewController:contract animated:YES completion:nil];
}

#pragma mark - 网络请求
#pragma mark 获取特惠商品列表
- (void)GetPreferentialCommodityList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetPreferentialCommodityList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AreaId"] = areaID_New;
    params[@"Name"] = @"";
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    params[@"Mouth"] = @"0";
    params[@"SortField"] = @"0";//0正序,1倒序
    params[@"Sort"] = @"1";//0销量,1价格
    params[@"FacilitatorId"] = self.FacilitatorId;//19-02-22 添加 供应商主页使用
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                self.listMarr = [YPGetPreferentialCommodityList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetPreferentialCommodityList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                }
                
            }
            
            [self.tableView reloadData];
            [self endRefresh];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [EasyShowTextView showErrorText:@"网络错误,请稍后重试!" inView:self.tableView];
        
    }];
    
}
//#pragma mark 根据服务商id获取相关活动列表
//- (void)GetFacilitatorActivityList{
//    
//    NSString *url = @"/api/HQOAApi/GetFacilitatorActivityList";
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"FacilitatorId"] = self.FacilitatorId;
//    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
//    params[@"PageCount"] = @"10";
//    
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            
//            if (_pageIndex == 1) {
//                
//                [self.listMarr removeAllObjects];
//                
//                self.listMarr = [YPGetFacilitatorActivityList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
//                [self endRefresh];
//            }else{
//                NSArray *newArray = [YPGetFacilitatorActivityList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
//                
//                if (newArray.count == 0) {
//                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//                }else{
//                    [self.listMarr addObjectsFromArray:newArray];
//                    
//                    [self endRefresh];
//                    [self.tableView reloadData];
//                }
//                
//            }
//            
//            [self.tableView reloadData];
//            
//        }else{
//            
//            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
//            
//        }
//        
//    } Failure:^(NSError *error) {
//        
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
//        
//    }];
//}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - getter
- (NSMutableArray<YPGetFacilitatorActivityList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

@end
