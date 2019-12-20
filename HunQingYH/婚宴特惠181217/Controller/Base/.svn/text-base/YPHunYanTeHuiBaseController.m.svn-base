//
//  YPHunYanTeHuiBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHunYanTeHuiBaseController.h"
#import "YPBanquetListObj.h"
#pragma mark - Cell
#import "YPHYTHHeadImgCell.h"
#import "YPHYTHBaseListCell.h"
#import "YPHYTHThreeSelectView.h"
#import "YPHYTHNoDataCell.h"
#pragma mark - VC
#import "YPHYTHDetailController.h"//详情
#import "YPHYTHOrderBaseController.h"//订单
#import "YPHYTHSearchViewController.h"//搜索
#import "YPContractController.h"//联系我们
#pragma mark - Model
#import "YPGetPreferentialCommodityList.h"

#pragma mark - third
#import "FSCustomButton.h"
#import "CJAreaPicker.h"//地址选择
#import "BRDatePickerView.h"

@interface YPHunYanTeHuiBaseController ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *orderTableView;//排序

@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UIControl *orderControl;//排序
@property (nonatomic, strong) NSIndexPath *xlLastPath;//销量
@property (nonatomic, strong) NSIndexPath *jgLastPath;//价格

@property (nonatomic, strong) NSMutableArray<YPBanquetListObj *> *listMarr;

/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;
/***********************************地址选择*****************************************/

@end

@implementation YPHunYanTeHuiBaseController{
    UIView *_navView;
    
    FSCustomButton *_monthBtn;
    NSString *_month;
    UIButton *_searchBtn;
    
    //数据库
    FMDatabase *dataBase;
    NSInteger _pageIndex;
    
    NSString *_SortField;//0正序,1倒序
    NSString *_Sort;//0销量,1价格
    
    NSString *_img;//顶部图
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetPreferentialCommodityList];
    if (!UserId_New) {
        [self.navigationController.tabBarController setSelectedIndex:0];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    _pageIndex = 1;
    NSDate *date = [NSDate date];
    _month = [NSString stringWithFormat:@"%02ld",(long)date.month];
    
    self.xlLastPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.jgLastPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _SortField = @"1";//0正序,1倒序 -- 19-02-21 默认倒序1 高->低
    _Sort = @"0";//0销量,1价格
    
    [self setupNav];
    [self setupUI];
    
}

#pragma mark - UI
- (void)setupNav{
    
    NSDate *date = [NSDate date];
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    

    if (!_searchBtn) {
        _searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_searchBtn setTitle:@"  输入酒店/宴会厅名称" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:RGBS(199) forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 13];
    [_searchBtn setImage:[UIImage imageNamed:@"search_gray"] forState:UIControlStateNormal];
    _searchBtn.backgroundColor = RGBS(248);
    _searchBtn.layer.cornerRadius = 4;
    _searchBtn.clipsToBounds = YES;
    [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_searchBtn];
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth*0.55-18, 32));
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(32);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];

//    if (!_monthBtn) {
//        _monthBtn  = [[FSCustomButton alloc]init];
//    }
//    _monthBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"婚宴特惠  %02ld月",(long)date.month]];
//    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 6)];
//    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size: 16] range:NSMakeRange(6, 3)];
//    _monthBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [_monthBtn setAttributedTitle:attr forState:UIControlStateNormal];
//
//    [_monthBtn setImage:[UIImage imageNamed:@"HYTH_下拉"] forState:UIControlStateNormal];
//    [_monthBtn setTitleColor:BlackColor forState:UIControlStateNormal];
//    [_monthBtn setBackgroundColor:RGBS(248)];
////    _monthBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 18];
////    _monthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_monthBtn addTarget:self action:@selector(monthBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    _monthBtn.layer.cornerRadius = 4;
//    _monthBtn.clipsToBounds = YES;
//    [_navView addSubview:_monthBtn];
//    [_monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(ScreenWidth*0.45-18-12);
//        make.left.mas_equalTo(18);
//        make.centerY.mas_equalTo(_searchBtn);
//        make.height.mas_equalTo(32);
//    }];
//

}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
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
        [self GetPreferentialCommodityList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetPreferentialCommodityList];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.tableView == tableView) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableView == tableView) {
        if (section == 0) {
            return 1;
        }else{
            return self.listMarr.count == 0 ? 1 : self.listMarr.count;
        }
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tableView == tableView) {
        if (indexPath.section == 0) {
            YPHYTHHeadImgCell *cell = [YPHYTHHeadImgCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:_img] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            return cell;
        }else{
            
            if (self.listMarr.count == 0) {
                YPHYTHNoDataCell *cell = [YPHYTHNoDataCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.doneBtn addTarget:self action:@selector(ruzhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else{
                YPBanquetListObj *list = self.listMarr[indexPath.row];
                
                YPHYTHBaseListCell *cell = [YPHYTHBaseListCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.imgV sd_setImageWithURL:[NSURL URLWithString:list.HotelLogo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
                [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:list.HeadImg] placeholderImage:[UIImage imageNamed:@"图片占位"]];
                if (list.BanquetHallName.length > 0) {
                    cell.tingTitle.text = list.BanquetHallName;
                }else{
                    cell.tingTitle.text = @"当前无名称";
                }
                if (list.Name.length > 0) {
                    cell.titleLabel.text = list.Name;
                }else{
                    cell.titleLabel.text = @"当前无名称";
                }
                cell.canbiao.text = list.FloorPrice;
                cell.zhuoshu.text = [NSString stringWithFormat:@"%ld-%ld",list.MinTableNumber,list.MaxTableCount];
                cell.lijian.text = [NSString stringWithFormat:@"%@%%",list.Discount];
                cell.countLabel.text = [NSString stringWithFormat:@"%@",list.ReservedQuantity];
                return cell;
            }
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        if (_Sort.integerValue == 0) {//0销量,1价格
            NSInteger row = [indexPath row];
            NSInteger oldRow = [self.xlLastPath row];
            if (row == oldRow && self.xlLastPath!=nil) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            if (indexPath.row == 0) {
                cell.textLabel.text = @"销量 高→低";
                cell.textLabel.font = kFont(14);
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"销量 低→高";
                cell.textLabel.font = kFont(14);
            }
        }else if (_Sort.integerValue == 1) {//0销量,1价格
            NSInteger row = [indexPath row];
            NSInteger oldRow = [self.jgLastPath row];
            if (row == oldRow && self.jgLastPath!=nil) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            if (indexPath.row == 0) {
                cell.textLabel.text = @"价格 高→低";
                cell.textLabel.font = kFont(14);
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"价格 低→高";
                cell.textLabel.font = kFont(14);
            }
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView == tableView) {
        if (indexPath.section == 0) {
            return ScreenWidth*0.67;
        }else{
            return self.listMarr.count == 0 ? 450 : ScreenWidth*0.78;//366
        }
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.tableView == tableView) {
        if (section == 1) {
            return 40;
        }else{
            return 0.1;
        }
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.tableView == tableView) {
        if (section == 1) {
            YPHYTHThreeSelectView *view = [YPHYTHThreeSelectView yp_threeSelectView];
            [view.areaBtn addTarget:self action:@selector(areaBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [view.areaBtn setTitle:self.cityInfo forState:UIControlStateNormal];
            [view.xiaoliangBtn addTarget:self action:@selector(xiaoliangBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [view.priceBtn addTarget:self action:@selector(priceBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return view;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableView == tableView) {
        if (indexPath.section == 0) {
            
        }else{
            if (self.listMarr.count == 0) {
                
            }else{
                YPBanquetListObj *list = self.listMarr[indexPath.row];
                
                YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
                detail.detailID = list.BanquetID;
                [self.navigationController pushViewController:detail animated:YES];
            }
        }
    }else if (tableView == self.orderTableView) {
        if (_Sort.integerValue == 0) {//0销量,1价格
            NSInteger newRow = [indexPath row];
            NSInteger oldRow = (self.xlLastPath !=nil)?[self.xlLastPath row]:-1;
            if (newRow != oldRow) {
                UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.xlLastPath];
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                self.xlLastPath = indexPath;
                
                [self orderControlClick];
                if (indexPath.row == 0) {
                    _Sort = @"0";//0销量,1价格
                    _SortField = @"1";//0正序,1倒序
                }else if (indexPath.row == 1){
                    _Sort = @"0";//0销量,1价格
                    _SortField = @"0";//0正序,1倒序
                }
                
                _pageIndex = 1;//重置
                [self GetPreferentialCommodityList];
            }
        }else if (_Sort.integerValue == 1) {//0销量,1价格
            NSInteger newRow = [indexPath row];
            NSInteger oldRow = (self.jgLastPath !=nil)?[self.jgLastPath row]:-1;
            if (newRow != oldRow) {
                UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.jgLastPath];
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                self.jgLastPath = indexPath;
                
                [self orderControlClick];
                if (indexPath.row == 0) {
                    _Sort = @"1";//0销量,1价格
                    _SortField = @"1";//0正序,1倒序
                }else if (indexPath.row == 1){
                    _Sort = @"1";//0销量,1价格
                    _SortField = @"0";
                }
                
                _pageIndex = 1;//重置
                [self GetPreferentialCommodityList];
            }
        }
    }
}

//动画展示Cell
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray *arr = tableView.indexPathsForVisibleRows;
//    NSIndexPath *firstIndexPath = arr[0];
//
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    cell.layer.position = CGPointMake(0, cell.layer.position.y);
//    if (firstIndexPath.row < indexPath.row) {
//        cell.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1.0);
//    }else{
//        cell.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1.0);
//    }
//
//    cell.alpha = 0.0;
//
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DIdentity;
//        cell.alpha = 1.0;
//    }];
//}

#pragma mark - target
- (void)monthBtnClick{
    NSLog(@"monthBtnClick");
    NSDate *date = [NSDate date];
    
    [BRDatePickerView showDatePickerWithTitle:@"选择婚宴日期" dateType:BRDatePickerModeYM defaultSelValue:[NSString stringWithFormat:@"%zd-%@",date.year,_month] minDate:date maxDate:nil isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
//        [_monthBtn setTitle:[NSString stringWithFormat:@"婚宴特惠·%@月",arr[1]] forState:UIControlStateNormal];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"婚宴特惠  %@月",arr[1]]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 6)];
        [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size: 16] range:NSMakeRange(6, 3)];
        [_monthBtn setAttributedTitle:attr forState:UIControlStateNormal];
        
        _month = [NSString stringWithFormat:@"%@",arr[1]];
        
        _pageIndex = 1;//重置
        [self GetPreferentialCommodityList];
    }];
}

- (void)searchBtnClick{
    NSLog(@"searchBtnClick");
    YPHYTHSearchViewController *search = [[YPHYTHSearchViewController alloc]init];
    
//    YPHYTHOrderBaseController *order = [YPHYTHOrderBaseController new];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)areaBtnClick{
    NSLog(@"areaBtnClick");
    //地区
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];;
    picker.delegate = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

- (void)xiaoliangBtnClick{
    NSLog(@"xiaoliangBtnClick");
    _Sort = @"0";//0销量,1价格
    [self.view addSubview:self.orderControl];
}

- (void)priceBtnClick{
    NSLog(@"priceBtnClick");
    _Sort = @"1";//0销量,1价格
    [self.view addSubview:self.orderControl];
}

- (void)orderControlClick{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.orderTableView.frame = CGRectMake(0, -44*5, ScreenWidth, 44*5);
    } completion:^(BOOL finished) {
        [self.orderTableView removeFromSuperview];
        self.orderTableView = nil;
        [_orderControl removeFromSuperview];
    }];
}

- (void)ruzhuBtnClick{
    //联系我们
    YPContractController *contract = [[YPContractController alloc]init];
    [self.navigationController presentViewController:contract animated:YES completion:nil];
}

#pragma mark - 网络请求
#pragma mark 获取特惠商品列表
- (void)GetPreferentialCommodityList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetAllBanquetHallList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AreaId"] = self.areaid;
//    params[@"Name"] = @"";
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
//    params[@"Mouth"] = _month;
    params[@"SortField"] = _SortField;//0正序,1倒序
    params[@"Sort"] = _Sort;//0销量,1价格
//    params[@"FacilitatorId"] = @"";//19-02-22 添加 供应商主页使用

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {

                [self.listMarr removeAllObjects];

                _img = @"http://121.42.156.151:96/2/1/100000/2/3/795f83c0-66c2-42bc-8d61-abff1c52626c.jpg";
                
                self.listMarr = [YPBanquetListObj mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPBanquetListObj mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

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
        
        [self showNetErrorEmptyView];
        
    }];
    
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
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"该区域暂无商家入驻\n快来抢占先机" subTitle:@"" imageName:@"HYTH_nodata.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialCommodityList];
    }];
    
}
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialCommodityList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
}

#pragma mark - getter
- (NSString *)areaid{
    if (!_areaid) {
        self.areaid = [[NSUserDefaults standardUserDefaults]objectForKey:@"region_New"];
    }
    return _areaid;
}

- (NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo =  [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    }
    return _cityInfo;
}

- (NSMutableArray<YPBanquetListObj *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (UIControl *)orderControl{
    if (!_orderControl) {
        _orderControl = [[UIControl alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
        _orderControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    }
    if (!self.orderTableView) {
        self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -44*2, ScreenWidth, 44*2) style:UITableViewStylePlain];
    }
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    self.orderTableView.backgroundColor = WhiteColor;
    self.orderTableView.estimatedRowHeight = 0;
    self.orderTableView.estimatedSectionFooterHeight = 0;
    self.orderTableView.estimatedSectionHeaderHeight = 0;
    self.orderTableView.tableFooterView = [[UIView alloc]init];
    [_orderControl addSubview:self.orderTableView];
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.orderTableView.frame = CGRectMake(0, 0, ScreenWidth, 44*2);
        [_orderControl addSubview:self.orderTableView];
    } completion:nil];
    
    [_orderControl addTarget:self action:@selector(orderControlClick) forControlEvents:UIControlEventTouchUpInside];
    return _orderControl;
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self selectDataBase];
    
    _pageIndex = 1;//重置
    [self GetPreferentialCommodityList];
    
}

- (void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
}

#pragma mark --------数据库-------
-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    NSLog(@"sourcesPath %@",sourcesPath);
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSLog(@"documentPath %@",documentPath);
    
    NSString *desPath = [documentPath stringByAppendingPathComponent:@"region.db"];
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }
    
}
//打开数据库
- (void)openDataBase{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"region.db"];
    
    dataBase =[[FMDatabase alloc]initWithPath:dbFilePath];
    BOOL ret = [dataBase open];
    if (ret) {
        NSLog(@"打开数据库成功");
        
    }else{
        NSLog(@"打开数据库成功");
    }
    
}
//关闭数据库
- (void)closeDataBase{
    BOOL ret = [dataBase close];
    if (ret) {
        NSLog(@"关闭数据库成功");
    }else{
        NSLog(@"关闭数据库失败");
    }
}
//查询数据库
-(void)selectDataBase{
    [self openDataBase];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市为%@",huanCun);
    NSLog(@"_cityInfo*$#$#$##$$%@",self.cityInfo);
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",self.cityInfo,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        
        //6-5
        //        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"areaid"];
        //        NSLog(@"areaid ------- %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaid"]);
        self.areaid =idStr;
    }
    [self closeDataBase];
    
    [self.tableView reloadData];
    NSLog(@"~~~~~~ huanCun:%@ cityInfo:%@ areaid:%@ ",huanCun,self.cityInfo,self.areaid);
    
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
