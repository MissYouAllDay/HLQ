//
//  YPMePhotoManListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/23.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMePhotoManListController.h"
#import "YPGetCustomerInfoBySupplier.h"
#import "YPGetCustomerInfoList.h"//新人获取供应商列表
#import "YPMePhotoXinRenListCell.h"//新人
#import "YPMePhotoSupplierListCell.h"//供应商
#import "YPMeXinRenPhotoController.h"//新人
#import "YPMeSupplierPhotoController.h"//供应商
#import "HRMeViedoViewController.h"
#import "YPPhotoVideoNoticeView.h"//用前须知

@interface YPMePhotoManListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<YPGetCustomerInfoBySupplier *> *listMarr;
///新人获取供应商列表
@property (nonatomic, strong) NSMutableArray<YPGetCustomerInfoList *> *xinrenMarr;

@property (nonatomic, strong) UIControl *control;

@end

@implementation YPMePhotoManListController{
    UIView *_navView;
    YPPhotoVideoNoticeView *_noticeView;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if ([self.professionStr integerValue] == 1) {//新人
        [self GetCustomerInfoList];
    }else{//供应商
        [self GetCustomerInfoBySupplier];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupNav];
    [self setupUI];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    if ([self.fromType isEqualToString:@"1"]) {
       titleLab.text = @"照片";
    }else{
        titleLab.text = @"视频";
    }
    
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    //设置导航栏右边更多
    UIButton *moreBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"问号"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(20, 40));
        make.right.mas_equalTo(_navView).mas_offset(-15);
        make.centerY.mas_equalTo(backBtn);
    }];
    
}

- (void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([self.professionStr integerValue] == 1) {//新人
            [self GetCustomerInfoList];
        }else{//供应商
            [self GetCustomerInfoBySupplier];
        }
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.professionStr integerValue] == 1) {//新人
        return self.xinrenMarr.count;
    }else{//供应商
        return self.listMarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.professionStr integerValue] == 1) {//新人 - 展示供应商列表
        
        YPGetCustomerInfoList *list = self.xinrenMarr[indexPath.row];
        
        YPMePhotoXinRenListCell *cell = [YPMePhotoXinRenListCell cellWithTableView:tableView];
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.Logo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
        cell.titleLabel.text = list.CorpName;
        return cell;
    }else{//供应商 - 展示新人列表
        
        YPGetCustomerInfoBySupplier *info = self.listMarr[indexPath.row];
        
        YPMePhotoSupplierListCell *cell = [YPMePhotoSupplierListCell cellWithTableView:tableView];
        cell.infoModel = info;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        
        UILabel *label = [[UILabel alloc]init];
        if ([self.professionStr integerValue] == 1) {//新人
            label.text = @"请从以下绑定您的婚庆公司中选择最终合作的";
        }else{//供应商
            label.text = [NSString stringWithFormat:@"已绑定新人 %zd人",self.listMarr.count];
        }
        label.textColor = LightGrayColor;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(view);
        }];
        
        return view;
    }else{
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.fromType isEqualToString:@"1"]) {
        //跳转照片
//        if ([self.professionStr integerValue] == 1) {//新人 - 展示供应商列表
//
//            YPGetCustomerInfoList *list = self.xinrenMarr[indexPath.row];
//
//            YPMeXinRenPhotoController *xinren = [[YPMeXinRenPhotoController alloc]init];
//            //        xinren.supplierID = list.
//            xinren.customID = list.CustomerInfoID;
//            xinren.corpName = list.CorpName;
//            [self.navigationController pushViewController:xinren animated:YES];
//
//        }else{//供应商 - 展示新人列表
        
            YPGetCustomerInfoBySupplier *info = self.listMarr[indexPath.row];
            
            YPMeSupplierPhotoController *corp = [[YPMeSupplierPhotoController alloc]init];
            corp.customerId = info.Customerid;
            if (info.GroomName.length > 0 && info.GroomPhoneNo.length > 0) {
                corp.manName = info.GroomName;
            }else if (info.BrideName.length > 0 && info.BridePhoneNo.length > 0){
                corp.manName = info.BrideName;
            }
            [self.navigationController pushViewController:corp animated:YES];
            
//        }
    }else{
    //跳转视频
        
        ///<<<<< .mine
//        YPGetCustomerInfoList *list = self.xinrenMarr[indexPath.row];
//
//        YPMeXinRenPhotoController *xinren = [[YPMeXinRenPhotoController alloc]init];
//        xinren.customID = list.CustomerInfoID;
//        xinren.corpName = list.CorpName;
//        [self.navigationController pushViewController:xinren animated:YES];
//
//    }else{//供应商 - 展示新人列表
//
//        YPGetCustomerInfoBySupplier *info = self.listMarr[indexPath.row];
//
//        YPMeSupplierPhotoController *corp = [[YPMeSupplierPhotoController alloc]init];
//        corp.customerId = info.Customerid;
//        if (info.GroomName.length > 0 && info.GroomPhoneNo.length > 0) {
//            corp.manName = info.GroomName;
//        }else if (info.BrideName.length > 0 && info.BridePhoneNo.length > 0){
//            corp.manName = info.BrideName;
//=======
//        if ([self.professionStr integerValue] == 1) {//新人 - 展示供应商列表
//
//            YPGetCustomerInfoList *list = self.xinrenMarr[indexPath.row];
//
////            YPMeXinRenPhotoController *xinren = [[YPMeXinRenPhotoController alloc]init];
////            //        xinren.supplierID = list.
////            xinren.customID = list.CustomerInfoID;
////            xinren.corpName = list.CorpName;
////            [self.navigationController pushViewController:xinren animated:YES];
//            HRMeViedoViewController *videoVC = [HRMeViedoViewController new];
//            videoVC.customerId =list.CustomerInfoID;
//            videoVC.fromType =@"1";
//            [self.navigationController pushViewController:videoVC animated:YES];
//        }else{//供应商 - 展示新人列表
        
            YPGetCustomerInfoBySupplier *info = self.listMarr[indexPath.row];
//
//            YPMeSupplierPhotoController *corp = [[YPMeSupplierPhotoController alloc]init];
//            corp.customerId = info.Customerid;
//            if (info.GroomName.length > 0 && info.GroomPhoneNo.length > 0) {
//                corp.manName = info.GroomName;
//            }else if (info.BrideName.length > 0 && info.BridePhoneNo.length > 0){
//                corp.manName = info.BrideName;
//            }
//            [self.navigationController pushViewController:corp animated:YES];
        
            HRMeViedoViewController *videoVC = [HRMeViedoViewController new];
            videoVC.customerId =info.Customerid;
            videoVC.fromType =@"2";
            videoVC.professionStr = @"0";//4-10 修改 只有 其他 进当前界面
            [self.navigationController pushViewController:videoVC animated:YES];
        
//>>>>>>> .r4080
//        }
        
    }
    
    
   
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    [self.view addSubview:self.control];
}

- (void)controlClick{

    [self.control removeFromSuperview];
}

#pragma mark - 网络请求
#pragma mark 客户获取婚礼信息列表
- (void)GetCustomerInfoList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCustomerInfoList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.xinrenMarr = [YPGetCustomerInfoList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self endRefresh];
            [self.tableView reloadData];
            
            if (self.xinrenMarr.count > 0) {
                
            }else{
                
                //                [EasyShowTextView showText:@"当前暂无数据!"];
                [self showNoDataEmptyView];
                
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

#pragma mark 根据供应商id获取客户信息
- (void)GetCustomerInfoBySupplier{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetCustomerInfoBySupplier";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UploadsId"] = UserId_New;//上传者id/供应商id
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetCustomerInfoBySupplier mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self endRefresh];
            [self.tableView reloadData];
            
            if (self.listMarr.count > 0) {
                
            }else{
                
                //                [EasyShowTextView showText:@"当前暂无数据!"];
//                [self showNoDataEmptyView];
                
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            
        }
        
    } Failure:^(NSError *error) {
        
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray<YPGetCustomerInfoBySupplier *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray<YPGetCustomerInfoList *> *)xinrenMarr{
    if (!_xinrenMarr) {
        _xinrenMarr = [NSMutableArray array];
    }
    return _xinrenMarr;
}

- (UIControl *)control{
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:self.view.frame];
        _control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        if (!_noticeView) {
            _noticeView = [YPPhotoVideoNoticeView yp_photoVideoNoticeView];
        }
        [_control addSubview:_noticeView];
        [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_control);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
        }];
    }
    [_control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [_noticeView.knowBtn addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    return _control;
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - 缺省
-(void)showNoDataEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"暂无数据" subTitle:@"" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
      
    }];
    
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
