//
//  YPHome190223Controller.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190223Controller.h"
#pragma mark - VC
#import "YPReLoginRegistSucController.h"//注册成功
#import "HRCodeScanningVC.h"//扫一扫
#import "HRHomeSearchViewController.h"//搜索
#import "YPReReHomeWedPackageDetailController.h"//套餐详情
#import "YPHome1809004TaoCanListController.h"//更多套餐
#import "YPContractController.h"//联系我们
#import "YPHYTHDetailController.h"//特惠详情
#import "YPFreeWeddingController.h"//免费办婚礼
#import "HRBaoMIViewController.h"//爆米花
#import "YPBHAssureController.h"//婚礼担保
//#import "YPBHProjectController.h"//我要出方案
#import "YPKeYuan190514PublishRingController.h"//19-05-19 免费领对戒
#import "YPNewlywedsController.h"
#import "HRFAStoreViewController.h"//方案商城
#import "YPEDuBaseController.h"//婚礼返还
#import "YPHunJiaJieController.h"//婚嫁节
#import "YPPassengerDistributionController.h"//客源分配
#import "YPInviteFriendsWedNormalController.h"//邀请结婚
#import "YPInviteFriendsWedVIPController.h"
#import "YPHome190226FindSupplierController.h"//找商家
#import "YPHome190226HunQianBiKanController.h"//备婚指南
#import "YPReFindController.h"//婚礼秀
#import "YPHomeHotelReserveController.h"//全部预定酒店
#import "YPHomeQueryTingController.h"//查找宴会厅
#import "YPKeYuan190514RecommendInviteController.h"//19-05-29 邀请结婚
#import "CXUserReceiveVC.h" // 用户提交用户资料
#import "CXReceiveVC.h" // 领取伴手礼

#pragma mark - Model
#import "HRZHiYeModel.h"
#import "YPGetWeddingPackageList.h"
#import "YPGetPreferentialCommodityList.h"
#import "YPGetWebBannerUrl.h"
#import "YPGetInvitationProfit.h"
#import "YPBanquetListObj.h"

#pragma mark - View
#import "YPPassengerDistributionBannerCell.h"
#import "YPHome190223FiveBtnCell.h"
#import "YPHome190223MoreActivityCell.h"
#import "YPHome180904TaoCanListCell.h"
#import "YPHYTHNoDataCell.h"
#import "YPHYTHBaseListCell.h"
#import "YPGetWeChatActivityList.h"
#import "YPHome190416QueryHotelCell.h"

#pragma mark - Third
#import "CJAreaPicker.h"//城市选择
#import "FL_Button.h"
#import "PopoverView.h"
#import "WJAdsView.h"//广告弹出
#import "DXAlertView.h"
#import "UIImage+ImgSize.h"   //获取网络图片尺寸
#import <JXCategoryView.h>
#import "JXGradientView.h"
#import <BRPickerView.h>

@interface YPHome190223Controller ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,WJAdsViewDelegate,JXCategoryViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) NSString *currentLocation;
@property (nonatomic, assign) NSInteger parentID;

//数据
/**职业数组*/
@property (nonatomic, strong) NSMutableArray *zhiYeArr;
/**套餐模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWeddingPackageList *> *listMarr;
/**特惠数组*/
@property (nonatomic, strong) NSMutableArray<YPBanquetListObj *> *teHuiMarr;

/**首页banner模型 -- 08-06 banner修改*/
@property (nonatomic, strong) NSMutableArray<YPGetWebBannerUrl *> *bannerURLMarr;
/**顶部banner模型 -- 08-06 banner修改*/
@property (nonatomic, strong) NSMutableArray<YPGetWebBannerUrl *> *topBannerModelMarr;
/** 顶部图片数组 */
@property (nonatomic, strong) NSMutableArray *topBannerImageArray;
/** 婚礼返还图片数组 */
@property (nonatomic, strong) NSMutableArray *fanHuanImageArray;

@property (nonatomic, copy) NSString *SortField;
///18-09-28 活动列表
@property (nonatomic, strong) NSMutableArray<YPGetWeChatActivityList *> *activityMarr;

///18-10-18 邀请结婚模型
@property (nonatomic, strong) YPGetInvitationProfit *profitModel;

//广告弹窗相关
/**是否弹窗 0不弹窗 1弹窗*/
@property(nonatomic,assign)NSInteger  Popup;
/**广告弹窗跳转地址*/
@property(nonatomic,copy)NSString  *ADJumpUrl;
/**广告弹窗图片地址*/
@property(nonatomic,copy)NSString  *ADImgurl;
/**分享地址*/
@property (nonatomic,copy) NSString *ShareUrl;
/**分享标题*/
@property (nonatomic,copy) NSString *ShareTitle;
/**分享描述*/
@property (nonatomic,copy) NSString *ShareDescribe;
/**分享图标*/
@property (nonatomic,copy) NSString *ShareImg;

/**婚宴标题*/
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, copy) NSString *selectMonth;

/**查找宴会厅时间*/
@property (nonatomic, copy) NSString *tingDateStr;
/**查找宴会厅桌数*/
@property (nonatomic, copy) NSString *tingZhuoShu;

@end

@implementation YPHome190223Controller{
    UIView *_navView;
    NSInteger _pageIndex;
    
    FMDatabase *dataBase;
    FL_Button *navAddressBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self getZhiYeList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registSuc:) name:@"RegistSuccess" object:nil];
    [self showNetErrorEmptyView];
    _pageIndex = 1;
    self.selectMonth = @"1";//特惠月份
    NSDate *date = [NSDate date];
    self.tingDateStr = [NSString stringWithFormat:@"%zd年%zd月%zd日",date.year,date.month,date.day];
    self.tingZhuoShu = @"1桌";
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FirstKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FirstKEY];
        [self moveToDBFile];//迁移数据库
    }
    [self setupNav];
    [self setupUI];
//    //定位
    [self setupLocation];
    //3DTOUCH通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToScanVCClick) name:@"TOScanVC" object:nil];
}

- (void)setupUI{
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self GetPreferentialCommodityListWithMonth:self.selectMonth];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex ++;
        [self GetPreferentialCommodityListWithMonth:self.selectMonth];
    }];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //导航栏地址选择按钮
    navAddressBtn = [FL_Button fl_shareButton];
    [navAddressBtn setBackgroundColor:[UIColor whiteColor]];
    [navAddressBtn setImage:[UIImage imageNamed:@"home_loc"] forState:UIControlStateNormal];
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    if (! [self checkCityInfo]) {
        [navAddressBtn setTitle:@"黄岛区" forState:UIControlStateNormal];
    }else{
        [navAddressBtn setTitle:city forState:UIControlStateNormal];
    }
    
    [navAddressBtn setTitleColor:RGBS(72) forState:UIControlStateNormal];//2-9 修改
    [navAddressBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    navAddressBtn.status = FLAlignmentStatusLeft;
    navAddressBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [_navView addSubview:navAddressBtn];
    [navAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navView.mas_left).offset(18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    
    //扫一扫 -- 6-25 修改
    UIButton *scanCodeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanCodeBtn setImage:[UIImage imageNamed:@"add_gray"] forState:UIControlStateNormal];
    [scanCodeBtn addTarget:self action:@selector(scanCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:scanCodeBtn];
    [scanCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(navAddressBtn);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor =RGBS(248);
    searchView.clipsToBounds =YES;
    searchView.layer.cornerRadius =4;
    [_navView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(navAddressBtn);
        make.left.mas_equalTo(navAddressBtn.mas_right).offset(15);
        make.right.mas_equalTo(scanCodeBtn.mas_left).offset(-15);
        make.height.mas_equalTo(36);
    }];
    //导航栏右边搜索按钮
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"home190223_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.left.mas_equalTo(14);
        make.centerY.mas_equalTo(searchView);
    }];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"输入你想查找的商家及服务";
    label.textColor = RGBS(190);
    label.font = kFont(13);
    [searchView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchBtn);
        make.left.mas_equalTo(searchBtn.mas_right).mas_offset(10);
        make.right.mas_greaterThanOrEqualTo(-10);
    }];
    UIButton *clearBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor =[UIColor clearColor];
    [clearBtn setTitle:@"" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(searchView.mas_right);
        make.left.mas_equalTo(searchBtn.mas_right);
        make.centerY.mas_equalTo(searchView);
    }];
    
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    // 第一个参数为是否开启边缘手势，开启则默认从边缘50距离内有效，第二个block为手势过程中我们希望做的操作
    [self cw_registerShowIntractiveWithEdgeGesture:YES transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
       
        SliderMeViewController *mevc =[SliderMeViewController new];
        [self cw_showDefaultDrawerViewController:mevc];
    }];
}

#pragma mark - 注册成功通知
- (void)registSuc:(NSNotification *)notif{
    YPReLoginRegistSucController *suc = [[YPReLoginRegistSucController alloc]init];
    if (YongHu(notif.userInfo[@"professionType"])) {//新人
        suc.professionType = 1;
    }else{
        suc.professionType = 0;
    }
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:suc];
    [self presentViewController:firstNav animated:YES completion:nil];
}

#pragma mark - 定位
- (void)setupLocation{
    
    self.locationManager = [[AMapLocationManager alloc] init];
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
//        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
//            NSLog(@"reGeocode:%@", regeocode);
            //formattedAddress  格式化地址
            self.currentLocation = regeocode.district;//区
            
        }
    }];
    
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 2 || section == 3 || section == 4) {
        return 1;
    }else{
        return self.teHuiMarr.count == 0 ? 1 : self.teHuiMarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YPPassengerDistributionBannerCell *cell = [YPPassengerDistributionBannerCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.urlArr = self.topBannerImageArray.copy;
        cell.scrollView.layer.cornerRadius = 6;
        cell.scrollView.clipsToBounds = YES;
        cell.scrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            /**
             
             HLDB  婚礼担保
             MFCFA 免费出方案
             MFBC 免费保存视频照片
             CHJJM 婚礼桥加盟
             MFBHL 免费办婚礼(APP)
             DLKYFP 客源分配代码 18-10-30
             */
            YPGetWebBannerUrl *listModel = self.topBannerModelMarr[currentIndex];
            
            if (listModel.HTMLURL.length > 0) {
                
                NSLog(@"clickItemOperationBlockHTMLURL -- %@",listModel.HTMLURL);
                HRWebViewController *webVC =[HRWebViewController new];
                webVC.webUrl = listModel.HTMLURL;
                webVC.isShareBtn = YES;
                webVC.shareURL = listModel.HTMLURL;
                [self.navigationController pushViewController:webVC animated:YES];
                
            }else if ([listModel.BannerCode isEqualToString:@"MFBHL"]){//MFBHL 免费办婚礼(APP)
                
                YPFreeWeddingController *wed = [[YPFreeWeddingController alloc]init];
                [self.navigationController pushViewController:wed animated:YES];
                
            }else if ([listModel.BannerCode isEqualToString:@"DLKYFP"]){//18-10-30 客源分配
                
                YPPassengerDistributionController *test = [[YPPassengerDistributionController alloc]init];
                [self.navigationController pushViewController:test animated:YES];
            }else if ([listModel.BannerCode isEqualToString:@"MFBHL_SS"]){//  领取伴手礼

                CXUserReceiveVC *test = [[CXUserReceiveVC alloc]init];
                [self.navigationController pushViewController:test animated:YES];
            }
        };
        [cell.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-36, (ScreenWidth-36)*0.4));
        }];
        return cell;
    }else if (indexPath.section == 1){
        YPHome190223FiveBtnCell *cell = [YPHome190223FiveBtnCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cehuaBtn.tag = 5000;
        cell.dinghunyanBtn.tag = 5001;
        cell.hunlixiuBtn.tag = 5002;
        cell.beihunBtn.tag = 5003;
        cell.zhaoshangjiaBtn.tag = 5004;
        [cell.cehuaBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.dinghunyanBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.hunlixiuBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.beihunBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhaoshangjiaBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 2){
        // MARK: -------------------------- 查找宴会厅 --------------------------
        YPHome190416QueryHotelCell *cell = [YPHome190416QueryHotelCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.dateBtn setTitle:self.tingDateStr forState:UIControlStateNormal];
        [cell.zhuoshuBtn setTitle:self.tingZhuoShu forState:UIControlStateNormal];
        [cell.dateBtn addTarget:self action:@selector(tingDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.zhuoshuBtn addTarget:self action:@selector(tingZhuoshuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.lookBtn addTarget:self action:@selector(queryHotelLookBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.allBtn addTarget:self action:@selector(queryHotelAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 3){
        YPHome190223MoreActivityCell *cell = [YPHome190223MoreActivityCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arr = [self.SortField componentsSeparatedByString:@","];
        for (YPGetWeChatActivityList *list in self.activityMarr) {
            if ([arr[0] isEqualToString:list.ActivityCode]) {
                [cell.bigBtn setBackgroundImageWithURL:[NSURL URLWithString:list.SmallImg] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
            }
            if ([arr[1] isEqualToString:list.ActivityCode]) {
                [cell.btn1 setBackgroundImageWithURL:[NSURL URLWithString:list.SmallImg] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
            }
            if ([arr[2] isEqualToString:list.ActivityCode]) {
                [cell.btn2 setBackgroundImageWithURL:[NSURL URLWithString:list.SmallImg] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
            }
        }
        cell.bigBtn.tag = 0+9999;
        cell.btn1.tag = 1+9999;
        cell.btn2.tag = 2+9999;
        [cell.bigBtn addTarget:self action:@selector(activityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn1 addTarget:self action:@selector(activityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(activityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 4){
        //MARK: 热门套餐
        if (self.listMarr.count > 0) {
            
            YPHome180904TaoCanListCell *cell = [YPHome180904TaoCanListCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.listArr = self.listMarr.copy;
            cell.colCellClick = ^(NSString *sectionName, NSIndexPath *indexPath) {
                NSLog(@"-----%zd",indexPath.item);
                
                if (self.listMarr.count > 0) {
                    
                    YPGetWeddingPackageList *list = self.listMarr[indexPath.item];
                    
                    //6-13 婚礼套餐
                    YPReReHomeWedPackageDetailController *detail = [[YPReReHomeWedPackageDetailController alloc]init];
                    detail.packageId = list.Id;
                    [self.navigationController pushViewController:detail animated:YES];
                }
            };
            return cell;
            
        }else{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"当前无婚礼套餐";
            cell.textLabel.textColor = BlackColor;
            return cell;
            
        }
    }else{
        //MARK: 特惠婚宴
        if (self.teHuiMarr.count == 0) {
            YPHYTHNoDataCell *cell = [YPHYTHNoDataCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.doneBtn addTarget:self action:@selector(ruzhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            YPBanquetListObj *list = self.teHuiMarr[indexPath.row];
            
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
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 1 ? 70 : UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 80;
    }else if (section == 5){
        return 120 - 50;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 4 || section == 5) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        view.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = RGBS(26);
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 20];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(18);
        }];
        UILabel *label1 = [[UILabel alloc]init];
        label1.textColor = LightGrayColor;
        label1.font = [UIFont fontWithName:@"PingFangSC-Light" size: 11];
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom).mas_offset(6);
            make.left.mas_equalTo(18);
        }];
        UIButton *moreBtn = [[UIButton alloc]init];
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:RGB(234, 75, 69) forState:UIControlStateNormal];
        moreBtn.titleLabel.font = kFont(14);
        if (section == 4) {
            label.text = @"精选套餐";
            label1.text = @"奢华灵感、限时福利、精选指南";
            [moreBtn addTarget:self action:@selector(taocanMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
            label.text = @"特惠婚宴";
            label1.text = @"消费立减、进口豪礼免费送";
            if (!self.myCategoryView) {
                self.myCategoryView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 50)];
                self.myCategoryView.delegate = self;
                self.myCategoryView.titles = @[@" 01月 ", @" 02月 ", @" 03月 ", @" 04月 ", @" 05月 ", @" 06月 ", @" 07月 ", @" 08月 ", @" 09月 ", @" 10月 ", @" 11月 ",@" 12月 "];
                self.myCategoryView.titleColorGradientEnabled = YES;
                self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
                self.myCategoryView.titleLabelStrokeWidthEnabled = YES;
                JXCategoryIndicatorBackgroundView *bgView = [[JXCategoryIndicatorBackgroundView alloc] init];
                //相当于把JXCategoryIndicatorBackgroundView当做视图容器，你可以在上面添加任何想要的效果
                JXGradientView *gradientView = [[JXGradientView alloc]init];
                gradientView.gradientLayer.endPoint = CGPointMake(1, 0);
                gradientView.gradientLayer.colors =@[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
                //设置gradientView布局和JXCategoryIndicatorBackgroundView一样
                gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [bgView addSubview:gradientView];
                
                bgView.indicatorHeight = 32;
                bgView.indicatorCornerRadius = 4;
                bgView.clipsToBounds = YES;
                self.myCategoryView.indicators = @[bgView];
            }
            [view addSubview:self.myCategoryView];
            
            [moreBtn addTarget:self action:@selector(tehuiMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        [view addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.centerY.mas_equalTo(label);
        }];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 5) {
        if (self.teHuiMarr.count == 0) {
            
        }else{
            YPBanquetListObj *list = self.teHuiMarr[indexPath.row];
            
            YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
            detail.detailID = list.BanquetID;
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"categoryView %zd",index+1);
    self.selectMonth = [NSString stringWithFormat:@"%zd",index+1];
    [self GetPreferentialCommodityListWithMonth:self.selectMonth];
}

#pragma mark - target
-(void)ToScanVCClick{
    HRCodeScanningVC *scanVc = [HRCodeScanningVC new];
    [self.navigationController pushViewController:scanVc animated:YES];
}

-(void)searchBtnClick{
    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
    searchVC.zhiYeArr = self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    //    picker.userlocation = self.currentLocation;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

- (void)bigBtnClick{
    NSLog(@"bigBtnClick");
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
        edu.typeStr = @"1";//婚礼返还
        [self.navigationController pushViewController:edu animated:YES];
        
    }
}

- (void)taocanMoreBtnClick{
    //热门套餐
    YPHome1809004TaoCanListController *taoCan = [[YPHome1809004TaoCanListController alloc]init];
    [self.navigationController pushViewController:taoCan animated:YES];
}

- (void)tehuiMoreBtnClick{
    //特惠
    [self.navigationController.tabBarController setSelectedIndex:2];
}

- (void)fiveBtnClick:(UIButton *)sender{
    if (sender.tag == 5000) {
        //婚礼策划
        [self.navigationController.tabBarController setSelectedIndex:1];
    }else if (sender.tag == 5001){
        //订婚宴
        [self.navigationController.tabBarController setSelectedIndex:2];
    }else if (sender.tag == 5002){
        //婚礼秀
        YPReFindController *find = [[YPReFindController alloc]init];
        [self.navigationController pushViewController:find animated:YES];
    }else if (sender.tag == 5003){
        //备婚指南
        YPHome190226HunQianBiKanController *bikan = [[YPHome190226HunQianBiKanController alloc]init];
        [self.navigationController pushViewController:bikan animated:YES];
    }else if (sender.tag == 5004){
        //找商家
        YPHome190226FindSupplierController *find = [[YPHome190226FindSupplierController alloc]init];
        [self.navigationController pushViewController:find animated:YES];
    }
}

#pragma mark 右上角弹窗
- (void)scanCodeBtnClick:(UIButton *)sender{
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"扫一扫"] title:@"扫一扫" handler:^(PopoverAction *action) {
        HRCodeScanningVC *scanVC = [HRCodeScanningVC new];
        [self.navigationController pushViewController:scanVC animated:YES];
    }];
    // 付款 action
    PopoverAction *payAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"扫一扫_付款"] title:@"付款" handler:^(PopoverAction *action) {
        HRWebViewController *webVC = [HRWebViewController new];
        webVC.webUrl = @"http://www.chenghunji.com/capital";
        webVC.isShareBtn = NO;
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    NSArray *arr = @[QRAction,payAction];
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    [popoverView showToView:sender withActions:arr];
}

#pragma mark 活动target
- (void)activityBtnClick:(UIButton *)sender{
    
    /**
     
     邀请好友办婚礼    —————YQBHL
     免费办婚礼       —————FreeBHL
     分享APP赚现金    —————ShareApp
     免费领爆米花     —————FreeBMH
     婚礼担保        ————HLDB
     我要出方案 ——————ChuFA
     共享方案 ———————GongxianFA
     婚礼返还———————-HunLiFH
     酒店活动  --------- JDHD
     婚嫁节  ----------  HJCGJ
     
     BSL  ----------  伴手礼
     DS   ----------  代收
     
     MFDJ ---------- 免费对戒
     */
    
    NSArray *arr = [self.SortField componentsSeparatedByString:@","];
    NSString *code = arr[sender.tag-9999];
    
    if ([code isEqualToString:@"YQBHL"]) {//邀请好友办婚礼
        
        //        HRYQJHController *yqjh = [[HRYQJHController alloc]init];
        //        [self.navigationController pushViewController:yqjh animated:YES];
        
        //        //5-23
        //        YPReYQJHController *yqjh = [[YPReYQJHController alloc]init];
        //        [self.navigationController pushViewController:yqjh animated:YES];
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            //18-10-15 邀请结婚
//            [self GetInvitationProfit];
            YPKeYuan190514RecommendInviteController *invite = [[YPKeYuan190514RecommendInviteController alloc]init];
            [self.navigationController pushViewController:invite animated:YES];
        }
        
    }else if ([code isEqualToString:@"FreeBHL"]){//免费办婚礼
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            YPFreeWeddingController *wed = [[YPFreeWeddingController alloc]init];
            [self.navigationController pushViewController:wed animated:YES];
        }
        
    }else if ([code isEqualToString:@"ShareApp"]){//分享APP赚现金
        
        //FIXME: 18-08-16 暂时本地分享
        [self showShareSDK];
        
        //        HRShareAppViewController *share = [[HRShareAppViewController alloc]init];
        //        [self.navigationController pushViewController:share animated:YES];
        
    }else if ([code isEqualToString:@"FreeBMH"]){//免费领爆米花
        
        //4-4 修改 登录判断
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            
            HRBaoMIViewController *baoMi = [[HRBaoMIViewController alloc]init];
            [self.navigationController pushViewController:baoMi animated:YES];
            
        }
        
    }else if ([code isEqualToString:@"HLDB"]){//婚礼担保
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            
            YPBHAssureController *assure = [[YPBHAssureController alloc]init];
            [self.navigationController pushViewController:assure animated:YES];
            
        }
        
    }else if ([code isEqualToString:@"ChuFA"]){//我要出方案
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            
            [self IsNewPeopleAddCustom];
        }
        
    }else if ([code isEqualToString:@"GongxianFA"]){//共享方案
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            
            //方案商城
            HRFAStoreViewController *faanganVC = [HRFAStoreViewController new];
            [self.navigationController pushViewController:faanganVC animated:YES];
        }
    }else if ([code isEqualToString:@"HunLiFH"]){//婚礼返还
        
        //婚礼返还
        //登录判断
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            
            YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
            edu.typeStr = @"1";//婚礼返还
            [self.navigationController pushViewController:edu animated:YES];
            
        }
        
    }else if ([code isEqualToString:@"JDHD"]){//酒店活动
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            
            //19-01-24 订婚宴 跳特惠婚宴
            [self.navigationController.tabBarController setSelectedIndex:2];
        }
    }else if ([code isEqualToString:@"HJCGJ"]){//婚嫁节 7-9
        
        if (!UserId_New) {
            
            //2-11 修改 登录判断
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
            
        }else{
            YPHunJiaJieController *vc = [[YPHunJiaJieController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if ([code isEqualToString:@"BSL"]){//伴手礼 18-09-17
        
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            CXReceiveVC *vc = [[CXReceiveVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
            YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
            edu.typeStr = @"0";//伴手礼
            [self.navigationController pushViewController:edu animated:YES];
            
        }
        
    }else if ([code isEqualToString:@"DS"]){//代收 18-09-17
        
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            
            YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
            edu.typeStr = @"2";//代收
            [self.navigationController pushViewController:edu animated:YES];
            
        }
        
    }else if ([code isEqualToString:@"MFDJ"]){//免费对戒 19-03-01
        
        if (!UserId_New) {
            YPReLoginController *first = [[YPReLoginController alloc]init];
            UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
            [self presentViewController:firstNav animated:YES completion:nil];
        }else{
            [self chuFangAnBtnClick];
        }
        
    }else{
        
        [EasyShowTextView showText:@"参与该活动,请更新版本!"];
    }
    
}

#pragma mark 免费出方案 target
- (void)chuFangAnBtnClick{
    
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        [self IsNewPeopleAddCustom];//判断是否添加订制
    }
}

#pragma mark - target
- (void)ruzhuBtnClick{
    //联系我们
    YPContractController *contract = [[YPContractController alloc]init];
    [self.navigationController presentViewController:contract animated:YES completion:nil];
}

- (void)queryHotelLookBtnClick{
    YPHomeQueryTingController *ting = [[YPHomeQueryTingController alloc]init];
    ting.dateStr = self.tingDateStr;
    ting.zhuoShu = self.tingZhuoShu;
    [self.navigationController pushViewController:ting animated:YES];
}

- (void)queryHotelAllBtnClick{
    YPHomeHotelReserveController *reserve = [[YPHomeHotelReserveController alloc]init];
    [self.navigationController pushViewController:reserve animated:YES];
}

- (void)tingDateBtnClick{
    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
        self.tingDateStr = [NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]];
        [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)tingZhuoshuBtnClick{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"桌数" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    txtName.keyboardType = UIKeyboardTypeNumberPad;
    txtName.placeholder = @"请输入桌数";
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        self.tingZhuoShu = [NSString stringWithFormat:@"%@桌",tf.text];
        [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - 区域 数据库
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"regionname_New"];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市设置为%@",huanCun);
    //    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
//    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
    [self selectDataBase];
    
}

-(void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"regionname_New"];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市设置为%@",huanCun);
    //    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
//    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
    [self selectDataBase];
}

-(void)moveToDBFile
{       //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"region"ofType:@"db"];
    
    
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
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
    
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",huanCun,(long)_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        //6-5 只有首页保存AreaID 其他地区选择时不保存
        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"region_New"];
    }
    
    [self closeDataBase];
    
    //5-14 更新nav位置btn
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
    
    //网络请求数据 - banner 08-06
    [self GetBannerListWithType:@"3"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
    [self GetBannerListWithType:@"5"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
//    //6-13 婚礼套餐
    [self GetWeddingPackageList];
    [self GetPreferentialCommodityListWithMonth:self.selectMonth];
}

-(BOOL)checkCityInfo{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"] ) {
        //如果不存在城市缓存
        return NO;
    }else{
        return YES;
    }
    
}

#pragma mark - 网络请求
#pragma mark 获取所有职业列表
- (void)getZhiYeList{
    NSString *url = @"/api/HQOAApi/GetAllOccupationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    /**
     0、获取所有
     1、注册（不包含公司、用户、车手、员工）
     2、主页（不包含 用户、车手、员工）
     3、主页（不包含 用户、车手、员工,酒店）
     */
    params[@"Type"] = @"2";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.zhiYeArr removeAllObjects];
            self.zhiYeArr = [HRZHiYeModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            NSMutableArray *marr = [NSMutableArray array];
            for (HRZHiYeModel *zhiye in self.zhiYeArr) {
                [marr addObject:@{zhiye.OccupationName:zhiye.OccupationID}];
            }
            [[NSUserDefaults standardUserDefaults] setObject:marr forKey:@"ProfessionArr"];
            
//            [self createData];
            if (![self checkCityInfo]) {
                [self cityBtnClick];
            }else{
                
                //网络请求数据 - banner 08-06
                [self GetBannerListWithType:@"3"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
                [self GetBannerListWithType:@"5"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
//                //18-09-28 热门活动
                [self GetWeChatActivityList];
                [self performSelector:@selector(getADAlertRequest) withObject:self afterDelay:2.0];
                [self GetWeddingPackageList];
                [self GetPreferentialCommodityListWithMonth:self.selectMonth];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 首页banner
- (void)GetBannerListWithType:(NSString *)type{
    
    NSString *url = @"/api/HQOAApi/GetBannerList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BannerType"] = type;//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner 8备婚图片
    params[@"Code"] = areaID_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            //            NSLog(@"banner --- %@",object);
            
            [self.bannerURLMarr removeAllObjects];
            self.bannerURLMarr = [YPGetWebBannerUrl mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            if ([type integerValue] == 3) {//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
                [self.topBannerImageArray removeAllObjects];
                
                [self.topBannerModelMarr addObjectsFromArray:self.bannerURLMarr];
                
                for (YPGetWebBannerUrl *bannerURL in self.bannerURLMarr) {
                    [self.topBannerImageArray addObject:bannerURL.BannerURL];
                }
            }else if ([type integerValue] == 5){//婚礼返还
                [self.fanHuanImageArray removeAllObjects];
                
                for (YPGetWebBannerUrl *bannerURL in self.bannerURLMarr) {
                    [self.fanHuanImageArray addObject:bannerURL.BannerURL];
                }
            }

            [self.tableView reloadData];
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取活动列表(用户) -18-09-28
- (void)GetWeChatActivityList{
    
    NSString *url = @"/api/HQOAApi/GetWeChatActivityList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.activityMarr removeAllObjects];
            
            self.SortField = [object objectForKey:@"SortField"];
            self.activityMarr = [YPGetWeChatActivityList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 获取婚礼套餐列表
- (void)GetWeddingPackageList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Type"] = @"1";//0全部，1上架，2下架
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.listMarr removeAllObjects];
            
            self.listMarr = [YPGetWeddingPackageList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
            
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

#pragma mark 获取特惠商品列表
- (void)GetPreferentialCommodityListWithMonth:(NSString *)month{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetAllBanquetHallList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AreaId"] = areaID_New;
    params[@"Name"] = @"";
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    if (month.length > 0) {
        params[@"Mouth"] = month;
    }else{
        params[@"Mouth"] = @"";
    }
    params[@"SortField"] = @"1";//0正序,1倒序
    params[@"Sort"] = @"0";//0销量,1价格
    params[@"FacilitatorId"] = @"";//19-02-22 添加 供应商主页使用
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.teHuiMarr removeAllObjects];
                self.teHuiMarr = [YPBanquetListObj mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
            }else{
                NSArray *newArray = [YPGetPreferentialCommodityList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.teHuiMarr addObjectsFromArray:newArray];
                }
            }
            
            //消除刷新时一闪问题
            [UIView performWithoutAnimation:^{
                [self.tableView reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
            }];
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

#pragma mark 获取邀请收益 18-10-18 邀请结婚
- (void)GetInvitationProfit{
    
    NSString *url = @"/api/HQOAApi/GetInvitationProfit";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.profitModel.RefereeStatus = [object objectForKey:@"RefereeStatus"];
            self.profitModel.TopBanner = [object objectForKey:@"TopBanner"];
            self.profitModel.EndBanner = [object objectForKey:@"EndBanner"];
            self.profitModel.Money = [object objectForKey:@"Money"];
            
            if (self.profitModel.RefereeStatus.integerValue == 0) {//0普通用户,1VIP
                //普通
                YPInviteFriendsWedNormalController *yqjh = [[YPInviteFriendsWedNormalController alloc]init];
                yqjh.profitModel = self.profitModel;
                [self.navigationController pushViewController:yqjh animated:YES];
                
            }else if (self.profitModel.RefereeStatus.integerValue == 1){
                //VIP
                YPInviteFriendsWedVIPController *yqjh = [[YPInviteFriendsWedVIPController alloc]init];
                yqjh.profitModel = self.profitModel;
                [self.navigationController pushViewController:yqjh animated:YES];
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 判断新人是否添加了订制 -- 5-16
- (void)IsNewPeopleAddCustom{
    
    NSString *url = @"/api/HQOAApi/IsNewPeopleAddCustom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSString *customID = [object valueForKey:@"NewPeopleCustomID"];//未添加返回0
            NSString *state = [object valueForKey:@"CustomState"];
            if ([customID integerValue] == 0) {
                //未添加
                //我要出方案 添加界面
                YPKeYuan190514PublishRingController *project = [[YPKeYuan190514PublishRingController alloc]init];
                [self.navigationController pushViewController:project animated:YES];
            }else{
                
                //我要出方案
                YPNewlywedsController *weds = [[YPNewlywedsController alloc]init];
                //                weds.typeNum = @"";
                weds.upState = [state integerValue];//提交状态
                [self.navigationController pushViewController:weds animated:YES];
            }
            
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - 获取广告弹窗接口
-(void)getADAlertRequest{
    NSString *url = @"/api/HQOAApi/GetUserPopup";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!UserId_New) {
        params[@"UserId"]   = @0;
    }else{
        params[@"UserId"]   = UserId_New;
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.Popup =[[object objectForKey:@"Popup"]integerValue];
            self.ADImgurl =[object objectForKey:@"Imgurl"];
            self.ADJumpUrl =[object objectForKey:@"Detailsurl"];
            self.ShareUrl =[object objectForKey:@"ShareUrl"];
            self.ShareTitle =[object objectForKey:@"ShareTitle"];
            self.ShareImg =[object objectForKey:@"ShareImg"];
            
            if (self.Popup ==1) {
                [self addADView];
            }
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

-(void)addADView{
    
    WJAdsView *adsView = [[WJAdsView alloc]initWithView:self.view];
    
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    UIImageView *ima = [[UIImageView alloc]init];
    CGSize size = [UIImage getImageSizeWithURL:[NSURL URLWithString:self.ADImgurl]];
    CGFloat adheight =(size.height)*(adsView.mainContainView.frame.size.width)/size.width;
    ima.frame =CGRectMake(0,0, adsView.mainContainView.frame.size.width, adheight);
    [ima sd_setImageWithURL:[NSURL URLWithString:self.ADImgurl]];
    [array addObject:ima];
    
    
    [self.view addSubview:adsView];
    adsView.containerSubviews = array;
    [adsView showAnimated:YES];
    
}

#pragma mark - 缺省
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"首次加载,请点击重新加载数据!" subTitle:nil imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getZhiYeList];
    }];
    
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - shareSDK
- (void)showShareSDK{
    
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"【邀好友】婚礼桥送现金福利！点开即得",
                                                   @"text" :@"在这和你相遇，2018天天有惊喜！最高可享100元现金福利哦！还有更多福利，尽在婚礼桥！",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :@"http://www.chenghunji.com/Redbag/index"}
                                          Result:^(SSDKResponseState state, SSDKPlatformType type) {
                                              switch (state) {
                                                  case SSDKResponseStateSuccess:
                                                  {
                                                      if (type == SSDKPlatformSubTypeWechatTimeline) {
                                                          
                                                          
                                                          [EasyShowTextView showSuccessText:@"朋友圈分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeWechatSession) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"微信好友分享成功"];
                                                      }
                                                      if (type == SSDKPlatformSubTypeQQFriend) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"QQ分享成功"];
                                                      }
                                                      if (type == SSDKPlatformTypeCopy) {
                                                          
                                                          [EasyShowTextView showSuccessText:@"链接复制成功"];
                                                      }
                                                      
                                                  }
                                                      break;
                                                  case SSDKResponseStateFail:
                                                  {
                                                      
                                                      [EasyShowTextView showErrorText:@"分享失败"];
                                                  }
                                                      break;
                                                  case SSDKResponseStateCancel:
                                                  {
                                                      
                                                      [EasyShowTextView showText:@"取消分享"];
                                                  }
                                                      break;
                                                  default:
                                                      break;
                                              }
                                              
                                          }];
    
    
}

#pragma mark - getter
- (NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}

- (NSMutableArray<YPGetWeddingPackageList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray<YPBanquetListObj *> *)teHuiMarr{
    if (!_teHuiMarr) {
        _teHuiMarr = [NSMutableArray array];
    }
    return _teHuiMarr;
}

- (NSMutableArray<YPGetWebBannerUrl *> *)bannerURLMarr{
    if (!_bannerURLMarr) {
        _bannerURLMarr = [NSMutableArray array];
    }
    return _bannerURLMarr;
}

- (NSMutableArray<YPGetWebBannerUrl *> *)topBannerModelMarr{
    if (!_topBannerModelMarr) {
        _topBannerModelMarr = [NSMutableArray array];
    }
    return _topBannerModelMarr;
}

- (NSMutableArray *)topBannerImageArray{
    if (!_topBannerImageArray) {
        _topBannerImageArray = [NSMutableArray array];
        
    }
    return _topBannerImageArray;
}

- (NSMutableArray *)fanHuanImageArray{
    if (!_fanHuanImageArray) {
        _fanHuanImageArray = [NSMutableArray array];
    }
    return _fanHuanImageArray;
}

- (YPGetInvitationProfit *)profitModel{
    if (!_profitModel) {
        _profitModel = [[YPGetInvitationProfit alloc]init];
    }
    return _profitModel;
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
