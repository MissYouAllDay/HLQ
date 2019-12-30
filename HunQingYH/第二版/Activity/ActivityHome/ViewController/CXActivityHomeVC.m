//
//  CXActivityHomeVC.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXActivityHomeVC.h"
#import <JXCategoryTitleView.h>
#import <JXCategoryIndicatorImageView.h>
#import <JXCategoryListContainerView.h>
#import "HRHomeSearchViewController.h"

#import "CXReceiveMoneyVC.h"
#import "CXGiftViewController.h"
#import "YPEDuBaseController.h"
#import "CXWeddingBackVC.h"
#import "CXAreaData.h"          // 地区
#import "CXActivityCatergoryModel.h"

//#import "YPMoreBtnControl.h"
#import "WJAdsView.h"
#import "CJAreaPicker.h"        // 地区

#define UnselectedColor RGBS(248)
#define SelectedColor RGB(250, 80, 120)

@interface CXActivityHomeVC ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,WJAdsViewDelegate,CJAreaPickerDelegate>
{
    FMDatabase *dataBase;
}

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) UIControl *control;

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;
// 选中按钮
@property (nonatomic, copy) NSString *profession;//编号
@property (nonatomic, copy) NSString *professionName;//职业
//顶部选择器
@property (nonatomic, strong) NSArray *topTitleArr;

@property (nonatomic, strong) UIButton  *searchBtn;    // 搜索按钮
@property (nonatomic, strong) FSCustomButton  *monthBtn;    // 地区按钮
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

@property (nonatomic, assign) BOOL Popup;    // 是否第一次弹窗
@property (nonatomic, strong) NSArray  *categoryArr;    // 分类数据
@end

@implementation CXActivityHomeVC {
    UIView *_navView;
//    YPMoreBtnControl *control;
    UIView *_moreBackView;
    CGFloat _allHeight;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.topTitleArr = @[@"领现金",@"婚礼返还"];
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
   
    [self loadCategoryList];

}

#pragma mark - UI
- (void)setupUI{
    NSMutableArray *marr = [NSMutableArray array];
    if (!self.myCategoryView) {
        self.myCategoryView = [[JXCategoryTitleView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth-40, 60)];
        self.myCategoryView.delegate = self;
        self.myCategoryView.titles = self.topTitleArr;
        self.myCategoryView.titleColor = [UIColor lightGrayColor];
        self.myCategoryView.titleSelectedColor = [UIColor blackColor];
        self.myCategoryView.titleColorGradientEnabled = YES;
        self.myCategoryView.titleLabelZoomEnabled = YES;
        
        JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"下划弧线"];
        self.myCategoryView.indicators = @[indicatorImageView];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+59, ScreenWidth, 1)];
    line.backgroundColor = CHJ_bgColor;
    [self.view addSubview:line];
    [self.view addSubview:self.myCategoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+60, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-60-HOME_INDICATOR_HEIGHT);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    //关联cotentScrollView，关联之后才可以互相联动！！！
    self.myCategoryView.contentScrollView = self.listContainerView.scrollView;
}

#pragma mark - UI

#pragma mark - JXCategoryListContainerViewDelegate
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.topTitleArr.count;
}
//返回遵从`JXCategoryListContentViewDelegate`协议的实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
   // @[@"领现金",*********,@"婚礼返还"];
    if (index == 0) { return [self receiveMoney]; }
    
    if (index == self.topTitleArr.count - 1) { return [self payReturnVC];  }
    
    if (index > 0 && index < self.topTitleArr.count - 1) {
        return [self giftViewControllerWithIndex:index - 1];
    }
    return [self receiveMoney];
}

- (id)receiveMoney {
    CXReceiveMoneyVC *vc = [[CXReceiveMoneyVC alloc] init];
    vc.mainNav = self.navigationController;
    return vc;
}

- (id)giftViewControllerWithIndex:(int)index {
    
    CXActivityCatergoryModel *model = self.categoryArr[index];
    CXGiftViewController *vc = [[CXGiftViewController alloc] init];
    vc.mainNav = self.navigationController;
    vc.categoryId = model.Id;
    return vc;
}

- (id)payReturnVC {
    
    CXWeddingBackVC *vc = [[CXWeddingBackVC alloc] init];
    return vc;
//    YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
//      edu.typeStr = @"1";//婚礼返还
//    return edu;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBtnClick{
//    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
//    searchVC.zhiYeArr = self.zhiYeArr;
//    [self.navigationController pushViewController:searchVC animated:YES];
}

// MARK: -导航栏
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

// MARK: - - - - - - - -  - - - - 请求数据  - - - -  - - - - - - - -  - - - - - - - -
- (void)loadCategoryList {
    
    [[NetworkTool shareManager] requestWithUrlStr:URL_ACTIVITY_CategoryList withParams:nil Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

            self.categoryArr = [CXActivityCatergoryModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            NSMutableArray *mark = [[NSMutableArray alloc] initWithArray:@[@"领现金"]];
            
            for (CXActivityCatergoryModel *model in self.categoryArr) {
                [mark addObject:model.Name];
            }
            [mark addObject:@"积分商城"];
            self.topTitleArr = mark;
        }
        [self setupUI];
        
    } Failure:^(NSError *error) {
        [self setupUI];
    }];
}
// MARK: - 弹窗
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
            
//            self.Popup =[[object objectForKey:@"Popup"]integerValue];
//            self.ADImgurl =[object objectForKey:@"Imgurl"];
//            self.ADJumpUrl =[object objectForKey:@"Detailsurl"];
//            self.ShareUrl =[object objectForKey:@"ShareUrl"];
//            self.ShareTitle =[object objectForKey:@"ShareTitle"];
//            self.ShareImg =[object objectForKey:@"ShareImg"];
            
            if (self.Popup ==1) {
                [self addADView:[object objectForKey:@"ShareImg"]];
            }
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

-(void)addADView:(NSString *)AdimgUrl {
    
    WJAdsView *adsView = [[WJAdsView alloc]initWithView:self.view];
    
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    UIImageView *ima = [[UIImageView alloc]init];
    CGSize size = [UIImage getImageSizeWithURL:[NSURL URLWithString:AdimgUrl]];
    CGFloat adheight =(size.height)*(adsView.mainContainView.frame.size.width)/size.width;
    ima.frame =CGRectMake(0,0, adsView.mainContainView.frame.size.width, adheight);
    [ima sd_setImageWithURL:[NSURL URLWithString:AdimgUrl]];
    [array addObject:ima];
    
    
    [self.view addSubview:adsView];
    adsView.containerSubviews = array;
    [adsView showAnimated:YES];
}

/**
 *  点击主内容视图
 *
 *  @param view 弹框视图
 *  @param selectIndex 当前选中索引
 */
- (void)wjAdsViewTapMainContainView:(WJAdsView *)view currentSelectIndex:(long)selectIndex {
    
    
    
}

// MARK: - 地区选择器
-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    picker.endType = CJPlaceEndCity;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

#pragma mark - CJAreaPickerDelegate
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    CXAreaData *areaData = [CXAreaData shareAreaData];
    areaData.cityId = [NSString stringWithFormat:@"%ld",(long)parentID];
    areaData.cityName = address;
    areaData.citysArr = [CXAreaData searchCityListWithParentId:parentID];
    
    self.parentID = parentID;
    self.cityInfo = address;
    [self dismissViewControllerAnimated:YES completion:nil];
    //  查询address 的 areaIdx
    [self selectDataBase];
    
    [_monthBtn setTitle:address forState:UIControlStateNormal];
}

// 获取区域id
-(void)selectDataBase{
    self.areaid = [CXAreaData selectDataBaseWithCityInfo:self.cityInfo];
}

@end
