//
//  YPReHomeSupplierListController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeSupplierListController.h"
//详情
#import "HRHotelViewController.h"
#import "HRZhuChiXQViewController.h"
//#import "HRHomeCell.h"
//#import "HRGYSModel.h"
#import "YPGetWebSupplierList.h"
#import "HRZHiYeModel.h"
#import "YPReHomeSupplierListCell.h"
#import "YPSupplierOtherInfoController.h"//2-6 重做 其他供应商信息
#import "YPGetDefaultSupplierInfoList.h"//5-22 默认供应商模型
#import "YPReReHomeDefaultSupplierHeadCell.h"
#import "YPReReHomeNoSupplierCell.h"

@interface YPReHomeSupplierListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/**供应商数组*/
@property (nonatomic, strong) NSMutableArray *GYSArr;
/**默认供应商数组*/
@property (nonatomic, strong) NSMutableArray<YPGetDefaultSupplierInfoList *> *listMarr;

@end

@implementation YPReHomeSupplierListController{
    UIView *_navView;
    NSString *selectZhiYeName;
    NSInteger _pageIndex;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pageIndex = 1;
    
    [self setupNav];
    [self setupUI];
    
    [self GetWebSupplierList];
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    if (self.titleStr.length > 0) {
        titleLab.text = self.titleStr;
    }else{
        titleLab.text = @"全部供应商";
    }
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetWebSupplierList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetWebSupplierList];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.GYSArr.count != 0 ? self.GYSArr.count : self.listMarr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.GYSArr.count > 0) {
        YPGetWebSupplierList *gysModel = self.GYSArr[indexPath.row];
        
        YPReHomeSupplierListCell *cell = [YPReHomeSupplierListCell cellWithTableView:tableView];
        cell.gysModel = gysModel;
        return cell;
    }else{
        
        if (indexPath.row == 0) {
            YPReReHomeDefaultSupplierHeadCell *cell = [YPReReHomeDefaultSupplierHeadCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = [NSString stringWithFormat:@"成婚纪推荐%@",self.titleStr];
            return cell;
        }else{
            
            YPGetDefaultSupplierInfoList *info = self.listMarr[indexPath.row - 1];
            
            YPReReHomeNoSupplierCell *cell = [YPReReHomeNoSupplierCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:info.Headportrait] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            if (info.Name.length > 0) {
                cell.titleLabel.text = info.Name;
            }else{
                cell.titleLabel.text = @"无姓名";
            }
            if (info.TotalCount.length > 0) {
                cell.anli.text = [NSString stringWithFormat:@"%zd",[info.TotalCount integerValue]];
            }else{
                cell.anli.text = @"0";
            }
            if (info.StateCount.length > 0) {
                cell.dongtai.text = [NSString stringWithFormat:@"%zd",[info.StateCount integerValue]];
            }else{
                cell.dongtai.text = @"0";
            }
            NSLog(@"supplierID = %@",info.SupplierID);
            if (info.RegionName.length > 0) {
                if ([info.SupplierID isEqualToString:@"6000000000000001"]) {
                    cell.region.text = @"全国";
                }else{
                    cell.region.text = info.RegionName;
                }
            }else{
                cell.region.text = @"无地区";
            }
            return cell;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.GYSArr.count > 0) {
        return 143;
    }else{
        if (indexPath.row == 0) {
            return 45;
        }else{
            return 110;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.GYSArr.count > 0) {
        return 0.1;
    }else{
        return 350;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.GYSArr.count > 0) {
        return nil;
    }else{
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ReReHome_NoSupplier"]];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"该地区暂无入驻商家";
        label.textColor = GrayColor;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgV.mas_bottom).mas_offset(15);
            make.centerX.mas_equalTo(imgV);
        }];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //2-11 修改 登录判断
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
    
        if (self.GYSArr.count > 0) {
            YPGetWebSupplierList *model = _GYSArr[indexPath.row];
            
            NSLog(@"%@",model.ProfessionID);
            for (HRZHiYeModel *zyModel in self.professionArr) {
                if ([model.ProfessionID isEqualToString:zyModel.OccupationCode]) {
                    NSLog(@"%@  - %@",model.ProfessionID  ,zyModel.OccupationName);
                    selectZhiYeName =zyModel.OccupationName;
                }
            }
            if ([model.ProfessionID isEqualToString:@"SF_1001000"]) {
                //酒店
                HRHotelViewController *hotelVC = [HRHotelViewController new];
                hotelVC.Name =model.Name;
                hotelVC.Headportrait =model.ImgUrl;
                hotelVC.SupplierID =[model.SupplierID integerValue];
                hotelVC.zhiyeName =@"酒店";
                hotelVC.UserID = model.UserID;//2-6 添加 动态使用
                [self.navigationController pushViewController:hotelVC animated:YES];
            }else if ([model.ProfessionID isEqualToString:@"SF_2001000"]) {
                //婚车
                
                HRHotelViewController *hotelVC = [HRHotelViewController new];
                hotelVC.Name =model.Name;
                hotelVC.Headportrait =model.ImgUrl;
                hotelVC.SupplierID =[model.SupplierID integerValue];
                hotelVC.zhiyeName =@"婚车";
                hotelVC.UserID = model.UserID;//2-6 添加 动态使用
                [self.navigationController pushViewController:hotelVC animated:YES];
            }else  {
                
                //2-6 重做 其他(除酒店/婚车)
                YPSupplierOtherInfoController *otherInfo = [[YPSupplierOtherInfoController alloc]init];
                otherInfo.Name = model.Name;
                otherInfo.Headportrait = model.ImgUrl;
                otherInfo.SupplierID = [model.SupplierID integerValue];
                otherInfo.zhiyeName = selectZhiYeName;
                otherInfo.UserID = model.UserID;//2-6 添加 动态使用
                [self.navigationController pushViewController:otherInfo animated:YES];
                
            }
            
        }else{
            
            YPGetDefaultSupplierInfoList *info = self.listMarr[indexPath.row - 1];
            
            NSLog(@"%@",info.ProfessionID);
            for (HRZHiYeModel *zyModel in self.professionArr) {
                if ([info.ProfessionID isEqualToString:zyModel.OccupationCode]) {
                    NSLog(@"%@  - %@",info.ProfessionID,zyModel.OccupationName);
                    selectZhiYeName = zyModel.OccupationName;
                }
            }
            if ([info.ProfessionID isEqualToString:@"SF_1001000"]) {
                //酒店
                HRHotelViewController *hotelVC = [HRHotelViewController new];
                hotelVC.Name = info.Name;
                hotelVC.Headportrait = info.Headportrait;
                hotelVC.SupplierID = [info.SupplierID integerValue];
                hotelVC.zhiyeName = @"酒店";
                hotelVC.UserID = info.UserID;//2-6 添加 动态使用
                [self.navigationController pushViewController:hotelVC animated:YES];
            }else if ([info.ProfessionID isEqualToString:@"SF_2001000"]) {
                //婚车
                
                HRHotelViewController *hotelVC = [HRHotelViewController new];
                hotelVC.Name = info.Name;
                hotelVC.Headportrait = info.Headportrait;
                hotelVC.SupplierID = [info.SupplierID integerValue];
                hotelVC.zhiyeName = @"婚车";
                hotelVC.UserID = info.UserID;//2-6 添加 动态使用
                [self.navigationController pushViewController:hotelVC animated:YES];
            }else  {
                
                //2-6 重做 其他(除酒店/婚车)
                YPSupplierOtherInfoController *otherInfo = [[YPSupplierOtherInfoController alloc]init];
                otherInfo.Name = info.Name;
                otherInfo.Headportrait = info.Headportrait;
                otherInfo.SupplierID = [info.SupplierID integerValue];
                otherInfo.zhiyeName = selectZhiYeName;
                otherInfo.UserID = info.UserID;//2-6 添加 动态使用
                [self.navigationController pushViewController:otherInfo animated:YES];
                
            }
            
        }
    }
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求
#pragma mark 获取web供应商列表
- (void)GetWebSupplierList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetWebSupplierList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.professionCode.length > 0) {
        params[@"OccupationCode"] = self.professionCode;//单个
    }else{
        params[@"OccupationCode"] = @"";//全部
    }
    params[@"IsHeat"]  = @"0";//0不是热门 1是热门
    params[@"RegionId"]  = areaID;
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    
    params[@"WeddingDate"] = @"";
    params[@"OrderType"] = @"2";//0首页排序 1热门排序(无用) 2动态时间排序
    params[@"NameOrPhone"] = @"";//模糊查询用
    
    NSLog(@"%@",params);
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            if (_pageIndex == 1) {
                
                [self.GYSArr removeAllObjects];
                self.GYSArr  = [YPGetWebSupplierList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
                
                [self.tableView reloadData];
                [self endRefresh];
            }else{
                NSArray *newArray = [YPGetWebSupplierList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.GYSArr addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [self.tableView reloadData];
                }
                
            }
            if (self.GYSArr.count == 0) {
                [self GetDefaultSupplierInfoList];
            }else{
                [self.tableView reloadData];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];

        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [self showNetErrorEmptyView];
        
    }];
}

#pragma mark 获取默认供应商列表
- (void)GetDefaultSupplierInfoList{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetDefaultSupplierInfoList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"OccupationCode"]  = self.professionCode;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            self.listMarr  = [YPGetDefaultSupplierInfoList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [self showNetErrorEmptyView];
        
    }];
}

#pragma mark - getter
-(NSMutableArray *)GYSArr{
    if (!_GYSArr) {
        _GYSArr =[NSMutableArray array];
    }
    return _GYSArr;
    
}

- (NSMutableArray<YPGetDefaultSupplierInfoList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
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
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetWebSupplierList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
