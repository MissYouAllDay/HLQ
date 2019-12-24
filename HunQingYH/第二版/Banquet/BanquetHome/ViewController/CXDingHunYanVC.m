//
//  YPHunYanTeHuiBaseController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//
// - - - - - - - - - - - - - - - - - - 订婚宴 - - - - - - - - - - - - - - - - - - 


#import "CXDingHunYanVC.h"
#import "YPBanquetListObj.h"
#pragma mark - Cell

#import "YPHYTHBaseListCell.h"
//#import "YPHYTHThreeSelectView.h"
#import "YPHYTHNoDataCell.h"
#import "JXCategoryTitleView.h" // segment
#import "JXCategoryIndicatorLineView.h" //segment的x滑块
#import "YPHomeQueryTingController.h"  //  宴会厅搜索

#pragma mark - VC
#import "YPHYTHDetailController.h"//详情
#import "YPHYTHOrderBaseController.h"//订单
#import "YPHYTHSearchViewController.h"//搜索
#import "YPContractController.h"//联系我们
#import "YPFreeWeddingController.h"
#import "YPFreeWeddingController.h" // 免费办婚礼
#import "YPPassengerDistributionController.h"   // 客源分配
#import "CXUserReceiveVC.h"     // 领取伴手礼

#pragma mark - Model
#import "YPGetPreferentialCommodityList.h"
#import "YPGetWebBannerUrl.h"   // banner数据

#pragma mark - third
#import "FSCustomButton.h"
#import "CJAreaPicker.h"//地址选择
#import "BRDatePickerView.h"
#import "CXSearchYHTView.h" // 查找宴会厅
#import "FL_Button.h"
#import "SDCycleScrollView.h"       // 轮播图
#import "CXAreaData.h"      // 区域数据

@interface CXDingHunYanVC ()<UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,JXCategoryViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *topBannerScrollView;

@property (nonatomic, strong) UIView *sectionHeadView;
@property (nonatomic, strong) JXCategoryTitleView *segmentView;
@property (nonatomic, strong) CXSearchYHTView *searchView;

@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) NSMutableArray<YPBanquetListObj *> *listMarr;
@property (nonatomic, strong) NSArray *segmentData; // 标题数据
/** banner数据 */
@property (nonatomic, strong) NSMutableArray<YPGetWebBannerUrl *> *bannerArr;


/***********************************地址选择*****************************************/
/**经纬度坐标*/
@property (strong, nonatomic) NSString *coordinates;
/**缓存城市*/
@property (strong, nonatomic) NSString *cityInfo;
/**缓存城市parentid*/
@property (assign, nonatomic) NSInteger parentID;
/**地区ID*/
@property (strong, nonatomic) NSString *areaid;

@property (nonatomic, strong) NSString  *currentLocation;    // 定位的区/县名称
/***********************************地址选择*****************************************/
/** 筛选宴会厅。 日期 */
@property (nonatomic, copy) NSString *tingDateStr;
/** 筛选yh宴会厅。桌数 */
@property (nonatomic, copy) NSString *tingZhuoShu;
@end

@implementation CXDingHunYanVC{
    UIView *_navView;
    
    FSCustomButton *_monthBtn;
    NSString *_month;
    UIButton *_searchBtn;
    
    //数据库
    FMDatabase *dataBase;
    NSInteger _pageIndex;
    
    NSString *_SortField;//0正序,1倒序
    NSString *_Sort;//0销量,1价格
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
    
    [self defaSetting];
    
    [self setupNav];
    [self GetBannerListWithType:@"3"];
    
}

- (void)defaSetting {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    NSDate *date = [NSDate date];
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy年MM月dd日";
    self.tingDateStr = [matter stringFromDate:date];
    self.tingZhuoShu = @"1 桌";
    _pageIndex = 1;
    _month = [NSString stringWithFormat:@"%02ld",(long)date.month];
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
        make.size.mas_equalTo(CGSizeMake(ScreenWidth*0.65-18, 32));
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    if (!_monthBtn) {
        _monthBtn  = [[FSCustomButton alloc]init];
    }
    
    _monthBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
    [_monthBtn setImage:[UIImage imageNamed:@"home_loc"] forState:UIControlStateNormal];
    [_monthBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    if (! [self checkCityInfo]) {
        [_monthBtn setTitle:@"青岛市" forState:UIControlStateNormal];
        self.cityInfo = @"青岛市";
        self.parentID = 171;
    }else{
        [_monthBtn setTitle:self.cityInfo forState:UIControlStateNormal];
    }
    
    [_monthBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _monthBtn.layer.cornerRadius = 4;
    _monthBtn.clipsToBounds = YES;
    [_navView addSubview:_monthBtn];
    [_monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth*0.35-18-12);
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(_searchBtn);
        make.height.mas_equalTo(32);
    }];
    
    [self selectDataBase];
    [self searchCityList:nil withParentId:[self.areaid integerValue]];
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    }
    
    UIView *topBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenWidth-36)*0.4 + 20)];
    [topBanner addSubview:self.topBannerScrollView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = WhiteColor;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = topBanner;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listMarr.count == 0 ? 2 : self.listMarr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return [self searchCelltableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    if (self.listMarr.count == 0) {
        // 无数据
        YPHYTHNoDataCell *cell = [YPHYTHNoDataCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.doneBtn addTarget:self action:@selector(ruzhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        return [self showCelltableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
#pragma mark - - - - - - - - - - - - - - - 创建cell - - - - - - - - - - - - - - - - -
/// 筛选框
/// @param tableView tableView
/// @param indexPath indexPath
- (UITableViewCell *)searchCelltableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(160))];
        CXSearchYHTView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"CXSearchYHTView" owner:nil options:nil] lastObject];
        searchView.frame = bg.bounds;
        [searchView.dateBtn addTarget:self action:@selector(tingDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [searchView.zhuoshuBtn addTarget:self action:@selector(tingZhuoshuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [searchView.zhuoshuBtn addTarget:self action:@selector(tingZhuoshuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [searchView.lookBtn addTarget:self action:@selector(queryHotelLookBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [searchView.dateBtn setTitle:self.tingDateStr forState:UIControlStateNormal];
        [searchView.zhuoshuBtn setTitle:self.tingZhuoShu forState:UIControlStateNormal];
        self.searchView = searchView;
        [bg addSubview:self.searchView];
        [cell.contentView addSubview:bg];
    }
    return cell;
}

/// 创建宴会厅cell
/// @param tableView tableView
/// @param indexPath indexPath
- (UITableViewCell *)showCelltableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPBanquetListObj *list = self.listMarr[indexPath.row - 1];
    
    YPHYTHBaseListCell *cell = [YPHYTHBaseListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.list = list;
    return cell;
}

#pragma mark - - - - - - - - - - - - - - - UITableViewDelegate - - - - - - - - - - - - - - - - -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return Line375(160);
    }
    return  self.listMarr.count == 0 ? 450 : ScreenWidth*0.78;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return Line375(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.sectionHeadView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.listMarr.count > 0) {
         YPBanquetListObj *list = self.listMarr[indexPath.row];
           
           YPHYTHDetailController *detail = [[YPHYTHDetailController alloc]init];
           detail.detailID = list.BanquetID;
           [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - 导航栏 target
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
    [self.navigationController pushViewController:search animated:YES];
}

- (void)ruzhuBtnClick{
    //联系我们
    YPContractController *contract = [[YPContractController alloc]init];
    [self.navigationController presentViewController:contract animated:YES completion:nil];
}

#pragma mark - getter
- (NSString *)areaid{
    if (!_areaid) {
        self.areaid = [[NSUserDefaults standardUserDefaults]objectForKey:@"city_id_new"];
    }
    return _areaid;
}

- (NSString *)cityInfo{
    if (!_cityInfo) {
        self.cityInfo =  [[NSUserDefaults standardUserDefaults]objectForKey:@"city_name_new"];
    }
    return _cityInfo;
}

- (NSMutableArray<YPBanquetListObj *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray<YPGetWebBannerUrl *> *)bannerArr {
    
    if (!_bannerArr) {
        _bannerArr = [[NSMutableArray alloc] init];
    }
    return _bannerArr;
}

- (UIView *)sectionHeadView {
    
    if (!_sectionHeadView) {
        _sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(40))];
        _sectionHeadView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, self.segmentView.height, ScreenWidth - 32, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        //        lineView.indicatorLineViewColor = [UIColor redColor];
        //        lineView.indicatorLineWidth = 30;
        self.segmentView.indicators = @[lineView];
        
        [_sectionHeadView addSubview:self.segmentView];
        [_sectionHeadView addSubview:line];
    }
    return _sectionHeadView;
}

#pragma mark - - - - - - - - - - - - - - - 轮播图 - - - - - - - - - - - - - - - - -
- (SDCycleScrollView *)topBannerScrollView {
    
    if (!_topBannerScrollView) {
        _topBannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(18, 10, ScreenWidth - 36,  (ScreenWidth-36)*0.4) delegate:self placeholderImage:[UIImage imageNamed:@"home_banner_place"]];
        _topBannerScrollView.currentPageDotColor = NavBarColor;
        _topBannerScrollView.pageDotColor = WhiteColor;
        _topBannerScrollView.layer.cornerRadius = 4;
        _topBannerScrollView.clipsToBounds = YES;
    }
    return _topBannerScrollView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    /**
     HLDB  婚礼担保
     MFCFA 免费出方案
     MFBC 免费保存视频照片
     CHJJM 婚礼桥加盟
     MFBHL 免费办婚礼(APP)
     DLKYFP 客源分配代码 18-10-30
     MFBHL_SS   领取伴手礼
     */
    YPGetWebBannerUrl *listModel = self.bannerArr[index];
    NSDictionary *allData = @{@"MFBHL":@"YPFreeWeddingController",@"DLKYFP":@"YPPassengerDistributionController", @"MFBHL_SS":@"CXUserReceiveVC"  };
    
    if (listModel.HTMLURL.length > 0) {
        NSLog(@"clickItemOperationBlockHTMLURL -- %@",listModel.HTMLURL);
        [self pushToHRWebViewController:listModel];
    }else if ([[allData allKeys] containsObject:listModel.BannerCode]) {
        [self pushToOtherVC:allData[listModel.BannerCode]];
    }
}

/// 跳转到分享界面
- (void)pushToHRWebViewController:(YPGetWebBannerUrl *)listModel {
    HRWebViewController *webVC =[HRWebViewController new];
    webVC.webUrl = listModel.HTMLURL;
    webVC.isShareBtn = YES;
    webVC.shareURL = listModel.HTMLURL;
    [self.navigationController pushViewController:webVC animated:YES];
}
/// 跳转其他界面
/// @param classStr 文件名
- (void)pushToOtherVC:(NSString *)classStr {
    
    UIViewController *vc = [[[NSClassFromString(classStr) class] alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (JXCategoryTitleView *)segmentView {
    
    if (!_segmentView) {
        
        _segmentView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, Line375(40))];
        _segmentView.titles = self.segmentData;
        _segmentView.delegate = self;
        _segmentView.titleColorGradientEnabled = YES;
        _segmentView.titleSelectedColor = [UIColor redColor];
        _segmentView.titleLabelStrokeWidthEnabled = YES;
    }
    return _segmentView;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    if (index == 0) {
        self.areaid = [NSString stringWithFormat:@"%ld",self.parentID];
        [self GetPreferentialCommodityList];
    }else {
        self.cityInfo = self.segmentData[index];
        [self selectDataBase];
        [self GetPreferentialCommodityList];
    }
}

#pragma mark - - - - - - - - - - - - - - - 查询宴会厅 - - - - - - - - - - - - - - - - -
- (void)tingDateBtnClick{
    [BRDatePickerView showDatePickerWithTitle:@"请选择时间" dateType:BRDatePickerModeDate defaultSelValue:@"" minDate:[NSDate date] maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
        self.tingDateStr = [NSString stringWithFormat:@"%@年%@月%@日",arr[0],arr[1],arr[2]];
        [self.searchView.dateBtn setTitle:self.tingDateStr forState:UIControlStateNormal];
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
        [self.searchView.zhuoshuBtn setTitle:self.tingZhuoShu forState:UIControlStateNormal];
    }
}

- (void)queryHotelLookBtnClick{
    YPHomeQueryTingController *ting = [[YPHomeQueryTingController alloc]init];
    ting.dateStr = self.tingDateStr;
    ting.zhuoShu = self.tingZhuoShu;
    [self.navigationController pushViewController:ting animated:YES];
}


#pragma mark - - - - - - - - - - - - - - - 选择城市 - - - - - - - - - - - - - - - - -
-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    picker.endType = CJPlaceEndCity;
    picker.userlocation = self.currentLocation;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID = parentID;
    NSLog(@"缓存城市设置为%@",address);
    self.cityInfo = address;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //  查询address 的 areaIdx
    [self selectDataBase];
    
    [self searchCityList:nil withParentId:parentID];
    
    _pageIndex = 1;//重置
    [_monthBtn setTitle:address forState:UIControlStateNormal];
    [self GetPreferentialCommodityList];
    
}

#pragma mark --------数据库-------
// 获取区域id
-(void)selectDataBase{
    self.areaid = [CXAreaData selectDataBaseWithCityInfo:self.cityInfo];
}
/**  是否有城市缓存 */
-(BOOL)checkCityInfo{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"city_name_new"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"city_name_new"] ) {
        //如果不存在城市缓存
        return NO;
    }else{
        return YES;
    }
    
}

/** 查询某市级所管辖的县/区 */
- (void)searchCityList:(NSString *)selectCity withParentId:(NSInteger )parentID {
    
    NSArray *areaArray = [CXAreaData searchCityListWithParentId:parentID];
    [self.sectionHeadView removeFromSuperview];
    self.sectionHeadView = nil;
    self.segmentView = nil;
    self.segmentData = areaArray;
    
    [self setupUI];
    [self.tableView reloadData];
}

#pragma mark - - - - - - - - - - - - - - - 网络请求 - - - - - - - - - - - - - - - - -

#pragma mark 获取特惠商品列表
- (void)GetPreferentialCommodityList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetAllBanquetHallList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"AreaId"] = self.areaid;
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    params[@"SortField"] = _SortField;//0正序,1倒序
    params[@"Sort"] = _Sort;//0销量,1价格
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
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
#pragma mark - 首页banner
- (void)GetBannerListWithType:(NSString *)type{
    
    NSString *url = @"/api/HQOAApi/GetBannerList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"BannerType"] = type;//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner 8备婚图片
    params[@"Code"] = areaID_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSArray *bannerArr = [YPGetWebBannerUrl mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self.bannerArr removeAllObjects];
            [self.bannerArr addObjectsFromArray:bannerArr];
            
            if ([type integerValue] == 3) {//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
                
                NSMutableArray *bannerUrls = [[NSMutableArray alloc] init];
                for (YPGetWebBannerUrl *bannerURL in bannerArr) {
                    [bannerUrls addObject:bannerURL.BannerURL];
                }
                self.topBannerScrollView.imageURLStringsGroup = bannerUrls;
            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
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

@end
