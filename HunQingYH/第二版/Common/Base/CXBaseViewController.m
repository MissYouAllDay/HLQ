//
//  CXBaseViewController.m
//  HunQingYH
//
//  Created by apple on 2019/10/24.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXBaseViewController.h"

@interface CXBaseViewController ()

@end

@implementation CXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)showNoDataEmptyView:(UIView *)view withClickAction:(CXClickActionBlock)block{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"该区域暂无商家入驻\n快来抢占先机" subTitle:@"" imageName:@"HYTH_nodata.png" inview:view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
    
        block();
    }];
    
}
-(void)showNetErrorEmptyView:(UIView *)view withClickAction:(CXClickActionBlock)block{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
    
    }];
    
}
-(void)hidenEmptyView:(UIView *)view {
    [ EasyShowEmptyView hiddenEmptyView:view];
}

- (void)endRefresh:(UITableView *)tableView {
    
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshing];
}


@end
