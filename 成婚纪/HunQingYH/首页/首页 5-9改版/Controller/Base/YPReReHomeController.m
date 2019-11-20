//
//  YPReReHomeController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReReHomeController.h"
#import "CJAreaPicker.h"//城市选择
#import "DataSource.h"
#import "YANScrollMenu.h"
#import "FL_Button.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"
#import "HRHomeCell.h"
#import "HRHomeSearchViewController.h"
#import "HRHotelViewController.h"
#import "HRZHiYeModel.h"
#import "HRGYSModel.h"
#define ItemHeight 90
#define IMG(name)           [UIImage imageNamed:name]

#import <SDCycleScrollView.h>
#import <HMSegmentedControl.h>

#pragma mark - view
#import "YPReReHomeHeader.h"
#import "YPReHomeGiftListCell.h"
#import "YPReHomeFangAnCell.h"
#import "YPReHomeYouHuiCell.h"
#import "YPReHomeNewsHeaderCell.h"
#import "YPReHomeNewsCell.h"
#import "YPReReHomeFangAnBannerCell.h"
//#import "YPReHomeSupplierCell.h"
#import "YPReHomeReSupplierCell.h"//1.4 修改
#import "YPReReHomeWedPackageCell.h"//6-13 婚礼套餐

#import "WJAdsView.h"//广告弹出
#import "DXAlertView.h"

#pragma mark - 模型
#import "YPGetWebBannerUrl.h"//首页banner
#import "YPGetWeddingInformationList.h"//婚礼资讯列表(头标题)
#import "YPGetInformationArticleList.h"//婚礼资讯文章列表
#import "YPGetDemoPlanList.h"//共享方案模型
#import "YPGetWeddingPackageList.h"//6-13 婚礼套餐

#pragma mark - Controller
#import "YPBHInviteController.h"//邀请有礼
#import "YPReHomeSupplierListController.h"//全部供应商
#import "YPReHomePlanListController.h"//全部方案  1-8 替换
//#import "YPFADetailController.h"//方案详情
#import "YPReHomePlanDetailController.h"//1-10 方案详情
#import "YPReHomeShaiXuanController.h"//筛选
#import "YPReHomeGiftListController.h"//2-5 修改 奖品列表点击更多 跳奖品列表
#import "YPSupplierOtherInfoController.h"//2-6 重做 其他供应商信息
#import "YPFreeWeddingController.h"
//#import "YPReHomeNewsDetailController.h"//婚礼资讯文章详情
#import "HRNewsDetailViewController.h"//图文混排资讯详情
#import "YPReHomeNewsListController.h"//婚礼资讯文章全部
//3-2 免费办婚礼
#import "YPFreeWeddingController.h"
//3-2 邀请下载
#import "HRShareAppViewController.h"
//3-29 爆米花
#import "HRBaoMIViewController.h"
//4-16 婚礼返还
#import "YPEDuBaseController.h"
//5-15 共享方案
//#import "HRFAStoreViewController.h"
//5-16
//#import "YPBHProjectController.h"//我要出方案
#import "YPKeYuan190514PublishRingController.h"//19-05-19 免费领对戒
#import "YPNewlywedsController.h"//新婚档案
//5-23 邀请结婚
#import "YPReYQJHController.h"
//6-1 酒店活动
#import "YPBannerHotelActivityController.h"
//6-13 婚礼套餐
#import "YPReReHomeWedPackageDetailController.h"
//6-26 弹窗
#import "PopoverView.h"
//7-6 悬浮按钮
#import "WMDragView.h"
#import "YPHunJiaJieController.h"//婚嫁节
#import "YPBHAssureController.h"//婚礼担保
#import "HRFAStoreViewController.h"//方案商城

//3D Banner
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "EllipsePageControl.h"

#import "UIImage+ImgSize.h"   //获取网络图片尺寸
#import "HRCodeScanningVC.h"//扫一扫
#define UnselectedColor CHJ_bgColor
#define SelectedColor NavBarColor

@interface YPReReHomeController ()<YANScrollMenuProtocol,UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,YPReHomeFangAnCellDelegate,YPReHomeReSupplierCellDelegate,WJAdsViewDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,EllipsePageControlDelegate,UIScrollViewDelegate>
{
    UIView *navView;
    UITableView *thistableView;
    NSInteger row;
    NSInteger item;
    FL_Button *topheaderSFBtn;
    FL_Button *topheaderAddressBtn;
    FL_Button *navTimeBtn;
    FMDatabase *dataBase;
    FL_Button *navAddressBtn;
    UILabel *messageLab;
    NSString *selectZhiYeName;
   
    WJAdsView *adsView;
    

}
/**职业数组*/
@property(nonatomic,strong)NSMutableArray  *zhiYeArr;
/**供应商数组*/
//@property(nonatomic,strong)NSMutableArray  *GYSArr;
@property(nonatomic,assign)NSInteger parentID;
@property(nonatomic,strong)NSString *selectZhiYeCode;
@property(nonatomic,strong)NSString *selectTime;
//@property (nonatomic, strong) YANScrollMenu *menu;
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray<DataSource *> *dataSource;

//@property (nonatomic, strong) SDCycleScrollView *banner;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

/**供应商类别*/
@property (nonatomic, copy) NSString *supplierStr;
/**供应商选择遮罩*/
@property (nonatomic, strong) UIControl *control;

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;

// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;

/**供应商cell*/
@property (nonatomic, strong) YPReHomeReSupplierCell *supplierCell;

/**方案Cell*/
@property (nonatomic, strong) YPReHomeFangAnCell *planCell;

/**首页banner模型 -- 08-06 banner修改*/
@property (nonatomic, strong) NSMutableArray<YPGetWebBannerUrl *> *bannerURLMarr;
/**顶部banner模型 -- 08-06 banner修改*/
@property (nonatomic, strong) NSMutableArray<YPGetWebBannerUrl *> *topBannerModelMarr;
/** 顶部图片数组 */
@property (nonatomic, strong) NSMutableArray *topBannerImageArray;
/** 婚礼返还图片数组 */
@property (nonatomic, strong) NSMutableArray *fanHuanImageArray;
/** 热门方案图片数组 */
@property (nonatomic, strong) NSMutableArray *fangAnImageArray;

/**婚礼资讯文章模型*/
@property (nonatomic, strong) NSMutableArray<YPGetInformationArticleList *> *articleMarr;

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
/**5-15 共享方案模型*/
@property (nonatomic, strong) NSMutableArray<YPGetDemoPlanList *> *demoPlanList;

/**
 6-13 套餐模型
 */
@property (nonatomic, strong) NSMutableArray<YPGetWeddingPackageList *> *listMarr;

//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) NSString *currentLocation;

//悬浮按钮
@property (nonatomic, strong) WMDragView *dragView;

@end

@implementation YPReReHomeController{
    UIButton *_refreshBtn;
    NSInteger _pageIndex;
}

-(NSMutableArray *)zhiYeArr{
    if (!_zhiYeArr) {
        _zhiYeArr =[NSMutableArray array];
    }
    return _zhiYeArr;
}
- (NSMutableArray<DataSource *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)topBannerImageArray{
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

- (NSMutableArray *)fangAnImageArray{
    if (!_fangAnImageArray) {
        _fangAnImageArray = [NSMutableArray array];
    }
    return _fangAnImageArray;
}

- (NSMutableArray<YPGetWebBannerUrl *> *)topBannerModelMarr{
    if (!_topBannerModelMarr) {
        _topBannerModelMarr = [NSMutableArray array];
    }
    return _topBannerModelMarr;
}

#pragma mark - viewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;

    [self showNetErrorEmptyView];

    [self getZhiYeList];

    _pageIndex = 1;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FirstKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FirstKEY];

        NSLog(@"home -- 第一次进入");
        
        [self moveToDBFile];//迁移数据库
        
    }else{
        NSLog(@"home -- 不是第一次");
    }
    
    row = 2;
    item = 5;

    [self createNav];

//    //定位
//    [self setupLocation];

    //3DTOUCH通知
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToScanVCClick) name:@"TOScanVC" object:nil];
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
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            //formattedAddress  格式化地址
            self.currentLocation = regeocode.district;//区
            
        }
    }];
    
}

#pragma mark - UI
- (void)createNav {
    navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //导航栏地址选择按钮
    navAddressBtn = [FL_Button fl_shareButton];
    [navAddressBtn setBackgroundColor:[UIColor whiteColor]];
    [navAddressBtn setImage:[UIImage imageNamed:@"下拉_gray"] forState:UIControlStateNormal];
    NSString *city =[[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    if (! [self checkCityInfo]) {
        [navAddressBtn setTitle:@"黄岛区" forState:UIControlStateNormal];
    }else{
        [navAddressBtn setTitle:city forState:UIControlStateNormal];
    }
    
    [navAddressBtn setTitleColor:[UIColor colorWithRed:127/255 green:127/255 blue:127/255 alpha:1] forState:UIControlStateNormal];//2-9 修改
    [navAddressBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    navAddressBtn.status = FLAlignmentStatusLeft;
    navAddressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [navView addSubview:navAddressBtn];
    [navAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(navView.mas_left).offset(10);
        make.bottom.mas_equalTo(navView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];

    
    //扫一扫 -- 6-25 修改
    UIButton *scanCodeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanCodeBtn setImage:[UIImage imageNamed:@"add_gray"] forState:UIControlStateNormal];
    [scanCodeBtn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:scanCodeBtn];
    [scanCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(navAddressBtn);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor =RGB(245, 245, 245);
    searchView.clipsToBounds =YES;
    searchView.layer.cornerRadius =4;
    [navView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(navAddressBtn);
        make.left.mas_equalTo(navAddressBtn.mas_right).offset(5);
        make.right.mas_equalTo(scanCodeBtn.mas_left).offset(-10);
        make.height.mas_equalTo(30);
    }];
    ////    //导航栏右边搜索按钮
        UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"search icon"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.mas_equalTo(5);
            make.centerY.mas_equalTo(searchView);
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
    //
//    UIButton *searchBackViewBtn = [[UIButton alloc]init];
//    searchBackViewBtn.backgroundColor = RGB(245, 245, 245);
//    [searchBackViewBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:searchBackViewBtn];
//    searchBackViewBtn.layer.cornerRadius = 5;
//    searchBackViewBtn.clipsToBounds = YES;
//    [searchBackViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//
//        make.left.mas_equalTo(navAddressBtn.mas_right).mas_offset(5);
//        make.right.mas_offset(scanCodeBtn.mas_left).offset(-10);
//        make.height.mas_equalTo(30);
//        make.centerY.mas_equalTo(navAddressBtn);
//    }];
////
////    //导航栏右边搜索按钮
//    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchBtn setImage:[UIImage imageNamed:@"search icon"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [searchBackViewBtn addSubview:searchBtn];
//    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.size.mas_equalTo(CGSizeMake(25, 25));
//        make.left.mas_equalTo(5);
//        make.centerY.mas_equalTo(searchBackViewBtn);
//    }];
//
    

  
}

#pragma mark - 右上角弹窗
- (void)testBtnClick:(UIButton *)sender{
    
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"saoyisao"] title:@"扫一扫" handler:^(PopoverAction *action) {
        HRCodeScanningVC *scanVC = [HRCodeScanningVC new];
        [self.navigationController pushViewController:scanVC animated:YES];
    }];
    // 付款 action
    PopoverAction *payAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"payCode"] title:@"付款" handler:^(PopoverAction *action) {
        HRWebViewController *webVC = [HRWebViewController new];
        webVC.webUrl = @"http://www.chenghunji.com/capital";
        webVC.isShareBtn = NO;
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    
    NSArray *arr = @[QRAction,payAction];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = NO; // 显示阴影背景
    [popoverView showToView:sender withActions:arr];

}

#pragma mark - Prepare UI
- (void)prepareUI{
    
    [self hidenEmptyView];

    if (!thistableView) {
        thistableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-49) style:UITableViewStyleGrouped];
        thistableView.delegate =self;
        thistableView.dataSource =self;
        thistableView.estimatedRowHeight = 0;
        thistableView.estimatedSectionFooterHeight = 0;
        thistableView.estimatedSectionHeaderHeight = 0;
        thistableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [self.view addSubview:thistableView];
        
        thistableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;
            [self GetWeddingPackageList];
        }];
        thistableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex ++;
            [self GetWeddingPackageList];
        }];
    }

    //7-6 婚嫁节悬浮入口 18-08-30去掉
//    [self createToolBtn];

}

#pragma mark 婚嫁节入口
- (void)createToolBtn{
    
    if (!self.dragView) {
        self.dragView = [[WMDragView alloc] initWithFrame:CGRectMake(ScreenWidth-75, ScreenHeight/2.0+150, 75, 80)];
    }
    self.dragView.isKeepBounds = YES;//黏边
    [self.dragView.imageView setImage:[UIImage imageNamed:@"婚嫁"]];
    self.dragView.freeRect = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
    self.dragView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.dragView];
    
    __weak typeof(self) weakSelf = self;
    
    self.dragView.clickDragViewBlock = ^(WMDragView *dragView){
        NSLog(@"clickDragViewBlock");
        
        YPHunJiaJieController *vc = [[YPHunJiaJieController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //开始滑动
    if (scrollView == thistableView) {
        if (self.dragView.x == 0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.dragView.x = -75;
            }];
        }else if (self.dragView.x == ScreenWidth-75){
            [UIView animateWithDuration:0.5 animations:^{
                self.dragView.x = ScreenWidth;
            }];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //结束滑动
    if (scrollView == thistableView) {
        if (self.dragView.x == -75) {
            [UIView animateWithDuration:0.3 animations:^{
                self.dragView.x = 0;
            }];
        }else if (self.dragView.x == ScreenWidth){
            [UIView animateWithDuration:0.3 animations:^{
                self.dragView.x = ScreenWidth-75;
            }];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //结束滑动
    if (scrollView == thistableView) {
        if (self.dragView.x == -75) {
            [UIView animateWithDuration:0.5 animations:^{
                self.dragView.x = 0;
            }];
        }else if (self.dragView.x == ScreenWidth){
            [UIView animateWithDuration:0.5 animations:^{
                self.dragView.x = ScreenWidth-75;
            }];
        }
    }
}

-(void)addADView{
    
   WJAdsView *adsView = [[WJAdsView alloc]initWithView:self.view];
        
    
    //CGRectMake(10,NAVIGATION_BAR_HEIGHT+100, ScreenWidth-20, adheight)
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 1; i ++) {
//
//        UIImageView *ima = [[UIImageView alloc]init];
//        ima.frame =adsView.mainContainView.frame;
//        [ima sd_setImageWithURL:[NSURL URLWithString:self.ADImgurl]];
//        [array addObject:ima];
//    }
    
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

#pragma mark -------红包代理 ----------
- (void)hide{
    WJAdsView *adsView = (WJAdsView *)[self.view viewWithTag:10];
    [adsView hideAnimated:YES];
 
}
- (void)wjAdsViewDidAppear:(WJAdsView *)view{
    NSLog(@"视图出现");
}
- (void)wjAdsViewDidDisAppear:(WJAdsView *)view{
    NSLog(@"视图消失----%zd",view.tag);
}

- (void)wjAdsViewTapMainContainView:(WJAdsView *)view currentSelectIndex:(long)selectIndex{
    NSLog(@"点击主内容视图:--%ld",selectIndex);
 
    
    if (!UserId_New) {
        [self hide];
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        if ([self.ADJumpUrl isEqualToString:@""]) {
          [self hide];
        }else{
            [self hide];
            //有地址，打开网页
            HRWebViewController *webVC =[HRWebViewController new];
            webVC.webUrl =self.ADJumpUrl;
            webVC.isShareBtn =YES;
            webVC.shareURL =self.ShareUrl;
            webVC.shareTitle =self.ShareTitle;
            webVC.shareDesText =self.ShareDescribe;
           
            webVC.shareIcon =self.ShareImg;
            [self.navigationController pushViewController:webVC animated:YES];
        }
       
    }
    

}

-(void)addNOUserIDADView{


    WJAdsView *adsView = [[WJAdsView alloc] initWithView:self.view];
    adsView.tag = 20;
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

#pragma mark - addHeaderView
-(UIView*)addHeaderView{
    
    // 顶部banner
    
    NewPagedFlowView *bannerView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenWidth-30)*2/5)];
    bannerView.delegate = self;
    bannerView.dataSource = self;
    bannerView.minimumPageAlpha = 0.1;
    bannerView.isCarousel = YES;
    bannerView.orientation = NewPagedFlowViewOrientationHorizontal;
    bannerView.isOpenAutoScroll = YES;
    bannerView.autoTime =3.0;
    [bannerView reloadData];
    
    //初始化pageControl
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height - 32, ScreenWidth, 8)];
//    bannerView.pageControl = pageControl;
//    [bannerView addSubview:pageControl];
//    [bannerView reloadData];
    
   EllipsePageControl *_myPageControl1 = [[EllipsePageControl alloc] init];
    _myPageControl1.frame=CGRectMake(0,  bannerView.frame.size.height - 20,[UIScreen mainScreen].bounds.size.width, 20);
    _myPageControl1.numberOfPages = self.topBannerImageArray.count;
    _myPageControl1.delegate=self;
    _myPageControl1.currentColor =MainColor;
    _myPageControl1.otherColor =WhiteColor;
//    _myPageControl1.tag=7777;
    bannerView.pageControl =_myPageControl1;
    [bannerView addSubview:_myPageControl1];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ItemHeight*row + kPageControlHeight+12+CGRectGetMaxY(bannerView.frame)+50+10+ScreenWidth/3.0)];//原SDScrollView 高 125  2-9 banner宽高比2:1 5-15 banner宽高比3:1  50:为你推荐高度 10:距顶部高度 5-18  原182 修改为宽度的0.69  6-26 修改 3:1
    headerView.backgroundColor =WhiteColor;

    [headerView addSubview:bannerView];

    YANScrollMenu *headrscrowMenu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.frame) +20, self.view.frame.size.width, ItemHeight*row + kPageControlHeight)];//原SDScrollView 高 125   2-9 banner宽高比2:1
    
    headrscrowMenu.currentPageIndicatorTintColor = NavBarColor;
    headrscrowMenu.delegate = self;
    
    //顶部圆角处理 -- 2-9 修改 圆角取消
    
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headrscrowMenu.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20,20)];
    //
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //
    //    maskLayer.frame = headrscrowMenu.bounds;
    //
    //    maskLayer.path = maskPath.CGPath;
    //    headrscrowMenu.layer.masksToBounds =YES;
    //    headrscrowMenu.layer.mask = maskLayer;
    
    [YANMenuItem appearance].textFont = [UIFont systemFontOfSize:15];
    [YANMenuItem appearance].textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
    [headerView addSubview:headrscrowMenu];
    
    //
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headrscrowMenu.frame), ScreenWidth, 10)];
    lineView.backgroundColor =CHJ_bgColor;
    [headerView addSubview:lineView];
    
    UIView *headerSXView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), ScreenWidth, ScreenWidth/3.0)];//182+10 5-18 修改宽度的0.69 6-26 修改 3:1
    headerSXView.backgroundColor =[UIColor whiteColor];
    
    [headerView addSubview:headerSXView];
    
    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headerSXView.frame), ScreenWidth, 2)];
    lineView2.backgroundColor =CHJ_bgColor;
    [headerView addSubview:lineView2];
    
//    //免费办婚礼
//    UIButton *header0Btn = [[UIButton alloc]init];
////    [header0Btn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:UIControlStateNormal];
////    [header0Btn setImageWithURL:[NSURL URLWithString:self.mianfei] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
//    [header0Btn setBackgroundImageWithURL:[NSURL URLWithString:self.mianfei] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
//    [header0Btn addTarget:self action:@selector(header0BtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerSXView addSubview:header0Btn];
//    [header0Btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(headerSXView);
//        make.left.mas_equalTo(10);
////        make.right.mas_equalTo(-10);
//        make.width.mas_equalTo((ScreenWidth-25)*0.5);
//        make.bottom.mas_equalTo(headerSXView).offset(-10);
//        make.top.mas_equalTo(headerSXView).mas_offset(10);
//    }];
    
    //花多少返多少
    UIButton *header1Btn = [[UIButton alloc]init];
//    [header1Btn setBackgroundImage:[UIImage imageNamed:@"婚礼返还入口"] forState:UIControlStateNormal];
//    [header1Btn setImageWithURL:[NSURL URLWithString:self.fanxian] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    
    NSString *url;
    if (self.fanHuanImageArray.count > 0) {
        url = self.fanHuanImageArray[0];
    }
    [header1Btn setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    
    [header1Btn addTarget:self action:@selector(header1BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerSXView addSubview:header1Btn];
    [header1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(headerSXView);
        make.height.mas_equalTo(ScreenWidth/3.0);
    }];
    
//    //免费领爆米花
//    UIButton *header2Btn = [[UIButton alloc]init];
////    [header2Btn setImageWithURL:[NSURL URLWithString:list.Img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
////    [header2Btn setImageWithURL:[NSURL URLWithString:self.baomihua] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
//    [header2Btn setBackgroundImageWithURL:[NSURL URLWithString:self.baomihua] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
//    [header2Btn addTarget:self action:@selector(header2BtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [headerSXView addSubview:header2Btn];
//    [header2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.height.mas_equalTo(header1Btn);
//        make.bottom.mas_equalTo(header0Btn);
//    }];
    
    UIView *lineView3 =[[UIView alloc]init];
    lineView3.backgroundColor = CHJ_bgColor;
    [headerView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerSXView.mas_bottom);
        make.height.mas_equalTo(50);
        make.bottom.left.right.mas_equalTo(headerView) ;
    }];
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Group 2"]];
    [lineView3 addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(lineView3);
//        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    return headerView;
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(ScreenWidth-30 , (ScreenWidth-30)*2/5);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    /**
     
     HLDB  婚礼担保
     MFCFA 免费出方案
     MFBC 免费保存视频照片
     CHJJM 婚礼桥加盟
     MFBHL 免费办婚礼(APP)
     */
    YPGetWebBannerUrl *listModel = self.topBannerModelMarr[subIndex];
    
    if (listModel.HTMLURL.length > 0) {

        NSLog(@"clickItemOperationBlockHTMLURL -- %@",listModel.HTMLURL);
        
        //                    //清除UIWebView的缓存
        //                    [[NSURLCache sharedURLCache] removeAllCachedResponses];
        HRWebViewController *webVC =[HRWebViewController new];
        webVC.webUrl = listModel.HTMLURL;
        webVC.isShareBtn = YES;
        webVC.shareURL = listModel.HTMLURL;
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else if ([listModel.BannerCode isEqualToString:@"MFBHL"]){//MFBHL 免费办婚礼(APP)
        
        YPFreeWeddingController *wed = [[YPFreeWeddingController alloc]init];
        [self.navigationController pushViewController:wed animated:YES];
    }
    
    
//    if (subIndex == 1) {
//
//        YPFreeWeddingController *freeVC = [YPFreeWeddingController new];
//        [self.navigationController pushViewController:freeVC animated:YES];
//
//    }else if (subIndex == 6){
//
////        HRYQJHController *YQJC = [HRYQJHController new];
////        [self.navigationController pushViewController:YQJC animated:YES];
//
//        //5-23
//        YPReYQJHController *YQJC = [YPReYQJHController new];
//        [self.navigationController pushViewController:YQJC animated:YES];
//
//    }else{
//
//        YPGetWebBannerUrl *bannerURL = self.topBannerModelMarr[subIndex];
//        NSLog(@"clickItemOperationBlockHTMLURL -- %@",bannerURL.HTMLURL);
//
//
//           if (bannerURL.HTMLURL.length > 0) {
//                            //                    //清除UIWebView的缓存
//                            //                    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//               HRWebViewController *webVC =[HRWebViewController new];
//               webVC.webUrl =bannerURL.HTMLURL;
//               webVC.isShareBtn =YES;
//               webVC.shareURL =bannerURL.HTMLURL;
//               [self.navigationController pushViewController:webVC animated:YES];
//
//           }
//
//    }
    
//    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    
    
    return self.topBannerImageArray.count;
    
}
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    
    
      [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.topBannerImageArray[index]] ];
//    bannerView.mainImageView.image = self.topBannerImageArray[index];
    
    return bannerView;
}



#pragma mark --------数据库-------
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
    [self GetBannerListWithType:@"7"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
    
    [self performSelector:@selector(getADAlertRequest) withObject:self afterDelay:2.0];
    
//    [self GetInformationArticleListWithWeddingInformationId:@"0"];//5-10 全部传0
    //6-13 婚礼套餐
    [self GetWeddingPackageList];
}

#pragma mark -  Data
- (void)createData{
    
    
    for (HRZHiYeModel *model in self.zhiYeArr) {
        DataSource *object = [[DataSource alloc] init];
        object.text = model.OccupationName;
        object.image = model.Icon;
        object.placeholderImage = IMG(@"占位图");
        
        [self.dataSource addObject:object];
        
    }
    //    for (NSUInteger idx = 0; idx< self.zhiYeArr.count; idx ++) {
    //
    //        DataSource *object = [[DataSource alloc] init];
    //        object.text = titles[idx];
    //        object.image = images[idx];
    //        object.placeholderImage = IMG(@"placeholder");
    //
    //        [self.dataSource addObject:object];
    //
    //    }
    
    
}
#pragma mark - YANScrollMenuProtocol
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return row;
}
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return item;
}
- (NSUInteger)numberOfMenusInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return self.dataSource.count;
}
- (id<YANMenuObject>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    return self.dataSource[idx];
}

- (void)scrollMenu:(YANScrollMenu *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    NSString *tips = [NSString stringWithFormat:@"IndexPath: [ %ld - %ld ]\nTitle:   %@",(long)indexPath.section,indexPath.row,self.dataSource[idx].text];
    
    YPReHomeSupplierListController *supplier = [[YPReHomeSupplierListController alloc]init];
    for (HRZHiYeModel *zhiyeModel in self.zhiYeArr) {
        if ([self.dataSource[idx].text isEqualToString:zhiyeModel.OccupationName]) {
            supplier.professionCode = zhiyeModel.OccupationID;
            supplier.titleStr = zhiyeModel.OccupationName;
        }
    }
    supplier.professionArr = self.zhiYeArr;
    [self.navigationController pushViewController:supplier animated:YES];
    
    //
    //    [topheaderSFBtn setTitle:self.dataSource[idx].text forState:UIControlStateNormal];
    //    [thistableView setContentOffset:CGPointMake(0.0, 200.0) animated:YES];
    //    for (HRZHiYeModel *model in self.zhiYeArr) {
    //
    //        if ([model.OccupationName isEqualToString:self.dataSource[idx].text]) {
    //            self.selectZhiYeCode =model.OccupationCode;
    //        }
    //
    //    }
    //    [self getGYSList];
    
    
    //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:tips preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //            [alert dismissViewControllerAnimated:YES completion:nil];
    //        }];
    //        [alert addAction:action];
    //        [self.navigationController presentViewController:alert animated:YES completion:nil];
}
- (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return YANEdgeInsetsMake(kScale(10), 0, kScale(5), 0, kScale(5));
}
#pragma mark - tableViewDataScource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
    return 1;//6-13 去掉备婚笔记
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0){//方案
//        return 2;
    
    return self.listMarr.count == 0 ? 2 : self.listMarr.count + 1;
    
//    }else{//备婚笔记(婚礼资讯) --- 6-13 去掉备婚笔记
//        if (self.articleMarr.count > 0) {
//            return self.articleMarr.count >= 5 ? 5 : self.articleMarr.count;
//        }else{
//            return 0;
//        }
////        if (self.articleMarr.count >= 3) {
////            return 4;
////        }else{
////            return 1 + self.articleMarr.count;
////        }
//    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //MARK: 方案
//    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            
            YPReReHomeFangAnBannerCell *cell = [YPReReHomeFangAnBannerCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //08-06 修改
            cell.urlArr = self.fangAnImageArray.copy;
            
            cell.scrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
                //4-4 修改 登录判断
                if (!UserId_New) {
                    YPReLoginController *first = [[YPReLoginController alloc]init];
                    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                    [self presentViewController:firstNav animated:YES completion:nil];
                }else{
                    [self IsNewPeopleAddCustom];
                }
            };
            return cell;
            
        }else{
            
            if (self.listMarr.count > 0) {
                YPGetWeddingPackageList *package = self.listMarr[indexPath.row-1];
                
                YPReReHomeWedPackageCell *cell = [YPReReHomeWedPackageCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:package.CoverMap] placeholderImage:[UIImage imageNamed:@"图片占位"]];
                if (package.Name.length > 0) {
                    cell.titleLabel.text = package.Name;
                }else{
                    cell.titleLabel.text = @"无标题";
                }
                //5-9 修改 显示关键字
                if (package.Label.length > 0) {
                    cell.descLabel.text = [package.Label stringByReplacingOccurrencesOfString:@"," withString:@" "];
                }else{
                    cell.descLabel.text = @"无关键字";
                }
                //6-11 价格-现价
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%zd",[package.PresentPrice integerValue]];
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
            
//            self.planCell = [YPReHomeFangAnCell cellWithTableView:tableView];
//            self.planCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            self.planCell.cellDelegate = self;
////            self.planCell.planList = self.planList;//6-11 热门方案
//            self.planCell.demoPlanList = self.demoPlanList;//5-15 共享方案
//            if (self.demoPlanList.count > 0) {
//                self.planCell.colView.hidden = NO;
//            }else{
//                self.planCell.colView.hidden = YES;
//
//                UILabel *label = [[UILabel alloc]init];
//                label.text = @"当前无方案";
//                [self.planCell.contentView addSubview:label];
//                [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.center.mas_equalTo(self.planCell.contentView);
//                }];
//            }
//            return self.planCell;
        }
        
//    //MARK: 备婚笔记  6-13 去掉备婚笔记
//    }else if (indexPath.section == 1){
//
//        YPGetInformationArticleList *article = self.articleMarr[indexPath.row];
//
//        YPReHomeNewsCell *cell = [YPReHomeNewsCell cellWithTableView:tableView];
//        cell.titleLabel.text = article.Title;
//        cell.tagLabel.text = [NSString stringWithFormat:@"  %@ ",article.WeddingInformationTitle];
//        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:article.ShowImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
//        return cell;
//
//    }
//
//    return nil;
}

#pragma mark - tableViewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 84;
        }else{
//            return 225;
            if (self.listMarr.count > 0) {
                return (ScreenWidth-18*2)*0.6+80;//整体高度-图片高度=80
            }else{
                return 50;
            }
        }
//    }else if (indexPath.section == 1) {
//        return 110;
//    }
//    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    if (indexPath.section == 1) {
//        YPGetInformationArticleList *article = self.articleMarr[indexPath.row];
//
//        HRNewsDetailViewController *detail  = [[HRNewsDetailViewController alloc]init];
//        detail.newsId =article.InformationArticleID;
//        [self.navigationController pushViewController:detail animated:YES];
//    }
    
    if (self.listMarr.count > 0) {
        
        YPGetWeddingPackageList *list = self.listMarr[indexPath.row-1];
        
        //6-13 婚礼套餐
        YPReReHomeWedPackageDetailController *detail = [[YPReReHomeWedPackageDetailController alloc]init];
        detail.packageId = list.Id;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YPReReHomeHeader *header = [YPReReHomeHeader yp_rereHomeHeader];
    if (section == 0) {
//        header.titleLabel.text = @"热门方案";//6-11 修改
//        header.titleLabel.text = @"共享方案";
        header.titleLabel.text = @"热门套餐";//6-15 修改
        [header.moreBtn setTitleColor:GrayColor forState:UIControlStateNormal];
        
    }
//    else if (section == 1) { //6-13 隐藏
//        header.titleLabel.text = @"备婚笔记";
//    }
    header.moreBtn.tag = section + 2000;
    [header.moreBtn addTarget:self action:@selector(headerMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark - CJAreaPickerDelegate----
- (void)areaPicker:(CJAreaPicker *)picker didSelectAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"regionname_New"];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"];
    NSLog(@"缓存城市设置为%@",huanCun);
    //    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
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
    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
    [self selectDataBase];
}
#pragma mark ---------target-----------
-(void)ToScanVCClick{
    HRCodeScanningVC *scanVc = [HRCodeScanningVC new];
    [self.navigationController pushViewController:scanVc animated:YES];
}
-(void)searchBtnClick{
    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
    searchVC.zhiYeArr =self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
//    picker.userlocation = self.currentLocation;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
}

-(void)topheaderAddressBtnClick{
    
    //header子区域地址
    //    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
    //        [topheaderAddressBtn setTitle:selectAddressArr[2] forState:UIControlStateNormal];
    ////        weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
    //    }];
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:picker];
    [self presentViewController:navc animated:YES completion:nil];
    
}
-(BOOL)checkCityInfo{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"regionname_New"] ) {
        //如果不存在城市缓存
        return NO;
    }else{
        return YES;
    }
    
}

#pragma mark - YPReHomeFangAnCellDelegate
- (void)ClickColRow:(NSInteger)CellRow{
    NSLog(@"YPReHomeFangAnCellDelegate -- %zd",CellRow);
    
    //5-15 共享方案
    YPGetDemoPlanList *plan = self.demoPlanList[CellRow];
    YPReHomePlanDetailController *detail = [[YPReHomePlanDetailController alloc]init];
    detail.planID = plan.PlanID;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 免费办婚礼 target
- (void)header0BtnClick{
    NSLog(@"header0BtnClick");
    //免费办婚礼
    //2-10 修改 登录判断
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        //    YPBHInviteController *invite = [[YPBHInviteController alloc]init];
        YPFreeWeddingController *invite = [YPFreeWeddingController new];
        [self.navigationController pushViewController:invite animated:YES];
    }
}

#pragma mark - 花多少返多少 target
- (void)header1BtnClick{
    NSLog(@"花多少返多少");
    
    //4-16 婚礼返还
    //登录判断
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        YPEDuBaseController *edu = [[YPEDuBaseController alloc]init];
        [self.navigationController pushViewController:edu animated:YES];
        
    }
}

#pragma mark - 免费领爆米花 target
- (void)header2BtnClick{
    NSLog(@"免费领爆米花");
    
    //4-4 修改 登录判断
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        HRBaoMIViewController *baoMi = [[HRBaoMIViewController alloc]init];
        [self.navigationController pushViewController:baoMi animated:YES];
        
    }
}

#pragma mark - header target
- (void)headerMoreBtnClick:(UIButton *)sender{
    
    if (sender.tag == 2000) {
        //6-11 方案展示
        YPReHomePlanListController *show = [[YPReHomePlanListController alloc]init];
        [self.navigationController pushViewController:show animated:YES];
        
//        //5-15 共享方案
//        HRFAStoreViewController *faanganVC = [HRFAStoreViewController new];
//        [self.navigationController pushViewController:faanganVC animated:YES];
        
    }else if (sender.tag == 2001){
        
        YPReHomeNewsListController *news = [[YPReHomeNewsListController alloc]init];
//        YPGetWeddingInformationList *list;
//        if (self.btn1State || (!self.btn1State&&!self.btn2State&&!self.btn3State)) {
//            list = self.headerMarr[0];
//        }else if (self.btn2State){
//            list = self.headerMarr[1];
//        }else if (self.btn3State){
//            list = self.headerMarr[2];
//        }
        news.titleStr = @"备婚笔记";
        news.articleID = @"0";//5-10 全部传0
        [self.navigationController pushViewController:news animated:YES];
    }
    
}

- (void)controlClick:(UIControl *)sender{
    NSLog(@"controlClick");
    
    [sender removeFromSuperview];
}

#pragma mark 重新加载
- (void)refreshBtnClick{
    [self getZhiYeList];
}

#pragma mark 福利活动红包
- (void)redWalletBtnClick{
    NSLog(@"福利活动红包");
    
    
    if (!UserId_New) {
        //未领取新人红包
       
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ----------网络请求----------------
#pragma mark 获取所有职业列表
- (void)getZhiYeList{
    //    [EasyShowLodingView showLoding];
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
            
//            NSLog(@"职业列表数组个数%zd",self.zhiYeArr.count);
            [self createData];
            if (![self checkCityInfo]) {
                [self cityBtnClick];
            }else{
                
//                //5-14 进入首-页更新位置
//                [self selectDataBase];
                
                //网络请求数据 - banner 08-06
                [self GetBannerListWithType:@"3"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
                [self GetBannerListWithType:@"5"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner
                [self GetBannerListWithType:@"7"];//0 BannnerUrl、1hldanbao、2 yqyouli 、3 PhoneBanner、4免费办婚礼、5花多少返多少banner、6免费领取爆米花banner、7热门方案banner

                [self performSelector:@selector(getADAlertRequest) withObject:self afterDelay:2.0];
                
                //6-13 婚礼套餐
                [self GetWeddingPackageList];
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
            
            NSLog(@"banner --- %@",object);
            
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
            }else if ([type integerValue] == 7){//热门方案
                [self.fangAnImageArray removeAllObjects];
                
                for (YPGetWebBannerUrl *bannerURL in self.bannerURLMarr) {
                    [self.fangAnImageArray addObject:bannerURL.BannerURL];
                }
            }

            [self prepareUI];
            
            thistableView.tableHeaderView = [self addHeaderView];
            
//            [self GetNewPeoplePlanList];//5-15 共享方案

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

//#pragma mark 获取资讯文章列表 - 6-13 废弃
//- (void)GetInformationArticleListWithWeddingInformationId:(NSString *)articleID{
//
//    NSString *url = @"/api/HQOAApi/GetInformationArticleList";
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"PageIndex"] = @"1";
//    params[@"PageCount"] =  @"5";//限制5条
//    params[@"WeddingInformationId"] = articleID;//5-10 全部传0
//    params[@"Title"] = @"";//模糊搜索
//    
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            
//            self.articleMarr = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
//
//            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//            
//        }else{
//            
//            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
//        }
//        
//    } Failure:^(NSError *error) {
//        
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
//        
//    }];
//    
//}


#pragma mark -------------------获取广告弹窗接口----------------
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
    
//                NSLog(@"广告%@",object);
                
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





//#pragma mark 查看方案列表 - 5-15 共享方案 -- 去掉
//- (void)GetNewPeoplePlanList{
//    
//    [EasyShowLodingView showLoding];
//    
//    NSString *url = @"/api/HQOAApi/GetNewPeoplePlanList";
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    params[@"PlanTitle"]        = @"";//标题
//    params[@"PlanKeyWord"]      = @"";//关键字
//    params[@"Color"]            = @"";//全部传空
//
//    params[@"PageIndex"]        = @"1";
//    params[@"PageCount"]        = @"8";
//    
//    //10-26 添加-筛选 5-24 改正序
//    params[@"OrderStart"]       = @"0";//0倒序、1正序
//    
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//        
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            
//            self.demoPlanList = [YPGetDemoPlanList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
//            
////            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//            
//            self.planCell.demoPlanList = self.demoPlanList;
//            
//            [self.planCell.colView reloadData];
//            
//        }else{
//            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
//        }
//        
//    } Failure:^(NSError *error) {
//        
//        
//        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [EasyShowLodingView hidenLoding];
//        });
//        
//    }];
//    
//}

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

#pragma mark 获取婚礼套餐列表 6-13
- (void)GetWeddingPackageList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetWeddingPackageList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Type"] = @"1";//0全部，1上架，2下架
    params[@"PageIndex"] = [NSString stringWithFormat:@"%zd",_pageIndex];
    params[@"PageCount"] = @"10";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            if (_pageIndex == 1) {
                
                [self.listMarr removeAllObjects];
                
                self.listMarr = [YPGetWeddingPackageList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                [thistableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
                [self endRefresh];
                
            }else{
                NSArray *newArray = [YPGetWeddingPackageList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
                
                if (newArray.count == 0) {
                    thistableView.mj_footer.state = MJRefreshStateNoMoreData;
                }else{
                    [self.listMarr addObjectsFromArray:newArray];
                    
                    [self endRefresh];
                    [thistableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
                }
                
            }
            
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
    [thistableView.mj_header endRefreshing];
    [thistableView.mj_footer endRefreshing];
}

#pragma mark - getter
- (NSMutableArray<YPGetWeddingPackageList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

#pragma mark - getter
- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        NSMutableArray *array = [NSMutableArray array];
        _btnArray = array;
        
    }
    return _btnArray;
}

- (NSMutableArray<YPGetWebBannerUrl *> *)bannerURLMarr{
    if (!_bannerURLMarr) {
        _bannerURLMarr = [NSMutableArray array];
    }
    return _bannerURLMarr;
}

- (NSMutableArray<YPGetInformationArticleList *> *)articleMarr{
    if (!_articleMarr) {
        _articleMarr = [NSMutableArray array];
    }
    return _articleMarr;
}

- (NSMutableArray<YPGetDemoPlanList *> *)demoPlanList{
    if (!_demoPlanList) {
        _demoPlanList = [NSMutableArray array];
    }
    return _demoPlanList;
}

#pragma mark - 缺省
-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"首次加载,请点击重新加载数据!" subTitle:nil imageName:@"netError.png" inview:self.view callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self getZhiYeList];
    }];
    
}
-(void)hidenEmptyView{
    [ EasyShowEmptyView hiddenEmptyView:self.view];
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
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
