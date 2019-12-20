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
#import <BRPickerView.h>
#import "NSDate+BRAdd.h"
#import "HRHomeCell.h"
#import "HRHomeSearchViewController.h"
#import "HRHotelViewController.h"
//详情
#import "HRZhuChiXQViewController.h"
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

#import "WJAdsView.h"//广告弹出
#import "DXAlertView.h"

#pragma mark - 模型
#import "YPGetWebPlanList.h"//方案模型
#import "HRPresentXQViewController.h"//礼物详情
#import "YPGetActivityPrizesList.h"//礼物模型
#import "YPGetWebBannerUrl.h"//首页banner
#import "YPGetWebDiscountList.h"//优惠信息模型
#import "YPGetWeddingInformationList.h"//婚礼资讯列表(头标题)
#import "YPGetInformationArticleList.h"//婚礼资讯文章列表
#import "YPGetWebSupplierList.h"//供应商模型
//3-2 福利活动模型
#import "YPGetWeChatActivityList.h"
#import "YPGetDemoPlanList.h"//共享方案模型

#pragma mark - Controller
#import "YPBHInviteController.h"//邀请有礼
#import "YPReHomeSupplierListController.h"//全部供应商
#import "YPReHomePlanListController.h"//全部方案  1-8 替换
//#import "YPFADetailController.h"//方案详情
#import "YPReHomePlanDetailController.h"//1-10 方案详情
#import "YPReHomeWebViewController.h"//网页
#import "YPReHomeShaiXuanController.h"//筛选
#import "YPReHomeYouHuiListController.h"//优惠信息列表
#import "YPReHomeGiftListController.h"//2-5 修改 奖品列表点击更多 跳奖品列表
#import "YPSupplierOtherInfoController.h"//2-6 重做 其他供应商信息
//#import "HRYQJHController.h"
#import "YPFreeWeddingController.h"
//#import "YPReHomeNewsDetailController.h"//婚礼资讯文章详情
#import "HRNewsDetailViewController.h"//图文混排资讯详情
#import "YPReHomeNewsListController.h"//婚礼资讯文章全部
//3-1 福利活动更多
#import "YPReHomeFuLiListController.h"
//3-2 免费办婚礼
#import "YPFreeWeddingController.h"
//3-2 邀请结婚
//#import "HRYQJHController.h"
//3-2 邀请下载
#import "HRShareAppViewController.h"
//3-29 爆米花
#import "HRBaoMIViewController.h"
//4-16 婚礼返还
#import "YPEDuBaseController.h"
//5-15 共享方案
#import "HRFAStoreViewController.h"
//5-16
#import "YPBHProjectController.h"//我要出方案
#import "YPNewlywedsController.h"//新婚档案
//5-23 邀请结婚
#import "YPReYQJHController.h"

//3D Banner

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "EllipsePageControl.h"
////10-31 添加 -- shareSDK
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
#import "ShareSDKMethod.h"
#define UnselectedColor bgColor
#define SelectedColor NavBarColor
//[UIColor colorWithRed:1.00 green:0.85 blue:0.21 alpha:1.00]

@interface YPReReHomeController ()<YANScrollMenuProtocol,UITableViewDelegate,UITableViewDataSource,CJAreaPickerDelegate,LLNoDataViewTouchDelegate,YPReHomeFangAnCellDelegate,YPReHomeReSupplierCellDelegate,WJAdsViewDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,EllipsePageControlDelegate>
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
    NSInteger RedEnvelopes;//是否领取红包  0未领取; 1已领取
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

/**
 方案模型
 */
@property (nonatomic, strong) NSMutableArray<YPGetWebPlanList *> *planList;

/**方案Cell*/
@property (nonatomic, strong) YPReHomeFangAnCell *planCell;

@property (nonatomic, strong) NSMutableArray<YPGetActivityPrizesList *> *listMarr;

/**首页banner模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWebBannerUrl *> *bannerURLMarr;
/**免费办婚礼banner*/
@property (nonatomic, copy) NSString *mianfei;
/**花多少返多少banner*/
@property (nonatomic, copy) NSString *fanxian;
/**免费领取爆米花banner*/
@property (nonatomic, copy) NSString *baomihua;
/**热门方案banner*/
@property (nonatomic, copy) NSString *fangan;

/**优惠信息模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWebDiscountList *> *discountMarr;

/**婚礼资讯头Cell*/
//@property (nonatomic, strong) YPReHomeNewsHeaderCell *headerCell;
/**婚礼资讯头模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWeddingInformationList *> *headerMarr;

/**婚礼资讯文章模型*/
@property (nonatomic, strong) NSMutableArray<YPGetInformationArticleList *> *articleMarr;

/**
 婚礼资讯头cell中按钮点击状态记录
 */
//@property (nonatomic, assign) BOOL btn1State;
//@property (nonatomic, assign) BOOL btn2State;
//@property (nonatomic, assign) BOOL btn3State;

/**供应商模型*/
@property (nonatomic, strong) NSMutableArray<YPGetWebSupplierList *> *supplierMarr;

/**福利活动数组*/
@property (nonatomic, strong) NSMutableArray<YPGetWeChatActivityList *> *fuliMarr;


//广告启动页相关
/**跳转类型*/
@property(nonatomic,assign)NSInteger  Type;
/**跳转地址*/
@property(nonatomic,copy)NSString  *JumpUrl;
/**图片地址*/
@property(nonatomic,copy)NSString  *HeadImg;

/**5-15 共享方案模型*/
@property (nonatomic, strong) NSMutableArray<YPGetDemoPlanList *> *demoPlanList;

/**
 *  顶部图片数组
 */
@property (nonatomic, strong) NSMutableArray *topBannerImageArray;
@end

@implementation YPReReHomeController{
    UIButton *_refreshBtn;
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
#pragma mark - getter
//- (SDCycleScrollView *)banner{
//    if (!_banner) {
//        NSMutableArray *marr = [NSMutableArray array];
//        for (YPGetWebBannerUrl *bannerURL in self.bannerURLMarr) {
//            [marr addObject:bannerURL.BannerURL];
//        }
//        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2.0) imageURLStringsGroup:marr.copy];//高 125  2-9 修改 宽:高=2:1 5-15 修改 3:1 5-16 修改2:1
//        __weak typeof(self) weakSelf = self;
//        //        _banner.pageControlBottomOffset = 20;
//        _banner.currentPageDotColor = NavBarColor;
//        _banner.pageDotColor = WhiteColor;
//        _banner.clickItemOperationBlock = ^(NSInteger currentIndex){
//            NSLog(@"clickItemOperationBlock -- %zd",currentIndex);
//
//            if (currentIndex == 1) {
//                YPFreeWeddingController *freeVC = [YPFreeWeddingController new];
//                [weakSelf.navigationController pushViewController:freeVC animated:YES];
//            }else if (currentIndex == 6){
//                HRYQJHController *YQJC = [HRYQJHController new];
//                [weakSelf.navigationController pushViewController:YQJC animated:YES];
//            }else{
//                YPGetWebBannerUrl *bannerURL = weakSelf.bannerURLMarr[currentIndex];
//                NSLog(@"clickItemOperationBlockHTMLURL -- %@",bannerURL.HTMLURL);
//
//                if (bannerURL.HTMLURL.length > 0) {
//                    //                    //清除UIWebView的缓存
//                    //                    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//                    YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:bannerURL.HTMLURL]];//@"http://www.baidu.com"
//                    webVC.navigationController.navigationBar.translucent = NO;
//                    webVC.progressViewColor =MainColor;
//                    weakSelf.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
//                    weakSelf.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
//                    [weakSelf.navigationController pushViewController:webVC animated:YES];
//                }
//
//
//            }
//        };
//    }
//    return _banner;
//}

#pragma mark - viewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (myID) {
        [self checkHongbaoLingquRequest];
        
        //5-14 进入首页更新位置
        [self selectDataBase];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;

    [self showNetErrorEmptyView];

    [self getZhiYeList];
    [self moveToDBFile];//迁移数据库
    
    row = 2;
    item = 5;

    [self createNav];

//    [self performSelector:@selector(GetADLaunchImage) withObject:self afterDelay:2.0];
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
    NSString *city =[[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
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
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

    UIButton *searchBackViewBtn = [[UIButton alloc]init];
    searchBackViewBtn.backgroundColor = RGB(245, 245, 245);
    [searchBackViewBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBackViewBtn];
    searchBackViewBtn.layer.cornerRadius = 5;
    searchBackViewBtn.clipsToBounds = YES;
    [searchBackViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth*0.6, 30));
        make.left.mas_equalTo(navAddressBtn.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(navAddressBtn);
    }];
    
    //导航栏右边搜索按钮
    UIButton *searchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBackViewBtn addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(searchBackViewBtn);
    }];
    
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
        thistableView.tableHeaderView = [self addHeaderView];
        [self.view addSubview:thistableView];
    }
    
    //新人红包
    NSLog(@"是否领取红包%zd",RedEnvelopes);
    if (myID) {
        if (RedEnvelopes ==0) {
            //未领取新人红包
            [self addADView];
        }
    }else{
        
        if (RedEnvelopes ==0) {
            //未领取新人红包
            [self addADView];
        }
    }

}

-(void)addADView{

    if (!adsView) {
        adsView = [[WJAdsView alloc] initWithView:self.view];
    }
    adsView.tag = 10;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i ++) {
        
        UIImageView *ima = [[UIImageView alloc]init];
        ima.frame =adsView.mainContainView.frame;
        ima.image = [UIImage imageNamed:@"hongbao_1"];
        [array addObject:ima];
    }
    
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
    
    if (!myID) {
        YPLoginController *loginVC = [YPLoginController new];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }else{
        if (view.tag ==10) {
            
            [ShareSDKMethod ShareTextActionWithTitle:@"【邀好友】成婚纪送现金福利！点开即得" ShareContent:@"在这和你相遇，2018天天有惊喜！最高可享100元现金福利哦！还有更多福利，尽在成婚纪！" ShareUlr:@"http://www.chenghunji.com/Redbag/index"  shareImage:[UIImage imageNamed:@"微信分享红包"]  IsCollect:NO IsReport:NO IsCollected:NO Report:nil Collect:nil Result:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                //分享之后的回调 在这里可以收集分享数据
                if (platformType ==22) {
                    NSLog(@"微信好友");
                    
                    if (state ==SSDKResponseStateSuccess) {
                        NSLog(@"微信好友成功");
                        [EasyShowTextView showSuccessText:@"分享成功"];
                        [self lingquHongbaoRequest];
                        
                    }else{
                        NSLog(@"微信好友失败");
                        [EasyShowTextView showErrorText:@"分享失败"];
                    }
                }else if (platformType ==23){
                    NSLog(@"朋友圈");
                    if (state ==SSDKResponseStateSuccess) {
                        [EasyShowTextView showSuccessText:@"分享成功"];
                        [self lingquHongbaoRequest];
                    }else{
                        [EasyShowTextView showErrorText:@"分享失败"];
                    }
                }

            } withDes1:@"分享到好友或朋友圈" withDes2:@"返回成婚纪即可拆红包"];

        }
        
    }

    //    [self showShareSDK];
}

-(void)addOpenHongbaoView{
    
    [self hide];
    WJAdsView *adsView = [[WJAdsView alloc] initWithView:self.view];
    adsView.tag = 20;
    adsView.delegate = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i ++) {
        
        UIImageView *ima = [[UIImageView alloc]init];
        ima.frame =adsView.mainContainView.frame;
        ima.image = [UIImage imageNamed:@"hongbao_open"];
        [array addObject:ima];
    }
    
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
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ItemHeight*row + kPageControlHeight+12+CGRectGetMaxY(bannerView.frame)+50+10+ScreenWidth*0.69)];//原SDScrollView 高 125  2-9 banner宽高比2:1 5-15 banner宽高比3:1  50:为你推荐高度 10:距顶部高度 5-18  原182 修改为宽度的0.69
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
    lineView.backgroundColor =bgColor;
    [headerView addSubview:lineView];
    
    UIView *headerSXView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), ScreenWidth, ScreenWidth*0.69)];//182+10 5-18 修改宽度的0.69
    headerSXView.backgroundColor =[UIColor whiteColor];
    
    [headerView addSubview:headerSXView];
    
    UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headerSXView.frame), ScreenWidth, 2)];
    lineView2.backgroundColor =bgColor;
    [headerView addSubview:lineView2];
    
    //免费办婚礼
    UIButton *header0Btn = [[UIButton alloc]init];
//    [header0Btn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:UIControlStateNormal];
//    [header0Btn setImageWithURL:[NSURL URLWithString:self.mianfei] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    [header0Btn setBackgroundImageWithURL:[NSURL URLWithString:self.mianfei] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    [header0Btn addTarget:self action:@selector(header0BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerSXView addSubview:header0Btn];
    [header0Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerSXView);
        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
        make.width.mas_equalTo((ScreenWidth-25)*0.5);
        make.bottom.mas_equalTo(headerSXView).offset(-10);
        make.top.mas_equalTo(headerSXView).mas_offset(10);
    }];
    
    //花多少返多少
    UIButton *header1Btn = [[UIButton alloc]init];
//    [header1Btn setBackgroundImage:[UIImage imageNamed:@"婚礼返还入口"] forState:UIControlStateNormal];
//    [header1Btn setImageWithURL:[NSURL URLWithString:self.fanxian] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    [header1Btn setBackgroundImageWithURL:[NSURL URLWithString:self.fanxian] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    [header1Btn addTarget:self action:@selector(header1BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerSXView addSubview:header1Btn];
    [header1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(header0Btn.mas_right).mas_offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(header0Btn.mas_height).multipliedBy(0.48);
        make.top.mas_equalTo(headerSXView).mas_offset(10);
    }];
    
    //免费领爆米花
    UIButton *header2Btn = [[UIButton alloc]init];
//    [header2Btn setImageWithURL:[NSURL URLWithString:list.Img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
//    [header2Btn setImageWithURL:[NSURL URLWithString:self.baomihua] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    [header2Btn setBackgroundImageWithURL:[NSURL URLWithString:self.baomihua] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"图片占位"]];
    [header2Btn addTarget:self action:@selector(header2BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerSXView addSubview:header2Btn];
    [header2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(header1Btn);
        make.bottom.mas_equalTo(header0Btn);
    }];
    
    UIView *lineView3 =[[UIView alloc]init];
    lineView3.backgroundColor = bgColor;
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
    
    
    
    if (subIndex == 1) {
        
        YPFreeWeddingController *freeVC = [YPFreeWeddingController new];
        [self.navigationController pushViewController:freeVC animated:YES];
        
    }else if (subIndex == 6){
        
//        HRYQJHController *YQJC = [HRYQJHController new];
//        [self.navigationController pushViewController:YQJC animated:YES];
        
        //5-23
        YPReYQJHController *YQJC = [YPReYQJHController new];
        [self.navigationController pushViewController:YQJC animated:YES];
        
    }else{
        
        YPGetWebBannerUrl *bannerURL = self.bannerURLMarr[subIndex];
        NSLog(@"clickItemOperationBlockHTMLURL -- %@",bannerURL.HTMLURL);
        
        
           if (bannerURL.HTMLURL.length > 0) {
                            //                    //清除UIWebView的缓存
                            //                    [[NSURLCache sharedURLCache] removeAllCachedResponses];
               
               YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:bannerURL.HTMLURL]];//@"http://www.baidu.com"
               
               webVC.navigationController.navigationBar.translucent = NO;
               
               webVC.progressViewColor =MainColor;
               
               self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
               
               self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
               
               [self.navigationController pushViewController:webVC animated:YES];
               
           }
        
    }
    
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
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    
    NSString *selectSql =[NSString stringWithFormat:@"SELECT REGION_ID FROM Region WHERE REGION_NAME ='%@'AND PARENT_ID =%ld",huanCun,_parentID];
    FMResultSet *set =[dataBase executeQuery:selectSql];
    while ([set next]) {
        int ID = [set intForColumn:@"REGION_ID"];
        NSLog(@"==*****%d",ID);
        NSString *idStr = [NSString stringWithFormat:@"%d",ID];
        [[NSUserDefaults standardUserDefaults]setObject:idStr forKey:@"AreaID"];
    }
    
    [self closeDataBase];
    
    //5-14 更新nav位置btn
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
    
    //网络请求数据
    
    //    [self GetWebSupplierList];
    [self GetWebBannerUrl];
    //    [self getPresetListRequest];
//    [self GetWeChatActivityList];//3-2 福利活动
//    [self GetWebPlanList];
    [self GetNewPeoplePlanList];//5-15 共享方案
//    [self GetWebDiscountList];
//    [self GetWeddingInformationList];
    [self GetInformationArticleListWithWeddingInformationId:@"0"];//5-10 全部传0
//    [self GetWebSupplierList];
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
    
    NSString *tips = [NSString stringWithFormat:@"IndexPath: [ %ld - %ld ]\nTitle:   %@",indexPath.section,indexPath.row,self.dataSource[idx].text];
    
    YPReHomeSupplierListController *supplier = [[YPReHomeSupplierListController alloc]init];
    for (HRZHiYeModel *zhiyeModel in self.zhiYeArr) {
        if ([self.dataSource[idx].text isEqualToString:zhiyeModel.OccupationName]) {
            supplier.professionCode = zhiyeModel.OccupationCode;
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){//方案
        return 2;
    }else{//备婚笔记(婚礼资讯)
        if (self.articleMarr.count > 0) {
            return self.articleMarr.count >= 5 ? 5 : self.articleMarr.count;
        }else{
            return 0;
        }
//        if (self.articleMarr.count >= 3) {
//            return 4;
//        }else{
//            return 1 + self.articleMarr.count;
//        }
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //MARK: 方案
    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            
            YPReReHomeFangAnBannerCell *cell = [YPReReHomeFangAnBannerCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.imgArr = @[@"占位"];
            cell.urlArr = @[self.fangan];
            cell.scrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
                //4-4 修改 登录判断
                if (!myID) {
                    YPLoginController *first = [[YPLoginController alloc]init];
                    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
                    [self presentViewController:firstNav animated:YES completion:nil];
                }else{
                    [self IsNewPeopleAddCustom];
                }
            };
            return cell;
            
        }else{
            self.planCell = [YPReHomeFangAnCell cellWithTableView:tableView];
            self.planCell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.planCell.cellDelegate = self;
//            self.planCell.planList = self.planList;
            self.planCell.demoPlanList = self.demoPlanList;//5-15 共享方案
            if (self.demoPlanList.count > 0) {
                self.planCell.colView.hidden = NO;
            }else{
                self.planCell.colView.hidden = YES;
                
                UILabel *label = [[UILabel alloc]init];
                label.text = @"当前无方案";
                [self.planCell.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(self.planCell.contentView);
                }];
            }
            return self.planCell;
        }
        
    //MARK: 备婚笔记
    }else if (indexPath.section == 1){

        YPGetInformationArticleList *article = self.articleMarr[indexPath.row];
        
        YPReHomeNewsCell *cell = [YPReHomeNewsCell cellWithTableView:tableView];
        cell.titleLabel.text = article.Title;
        cell.tagLabel.text = [NSString stringWithFormat:@"  %@ ",article.WeddingInformationTitle];
        [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:article.ShowImg] placeholderImage:[UIImage imageNamed:@"占位图"]];
        return cell;
        
    }
    
    return nil;
}

#pragma mark - tableViewDelegate -----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 84;
        }else{
            return 225;
        }
    }else if (indexPath.section == 1) {
        return 110;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        YPGetInformationArticleList *article = self.articleMarr[indexPath.row];

        HRNewsDetailViewController *detail  = [[HRNewsDetailViewController alloc]init];
        detail.newsId =article.InformationArticleID;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YPReReHomeHeader *header = [YPReReHomeHeader yp_rereHomeHeader];
    if (section == 0) {
//        header.titleLabel.text = @"热门方案";
        header.titleLabel.text = @"共享方案";
        
    }else if (section == 1) {
        header.titleLabel.text = @"备婚笔记";
    }
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
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"locationOfSubcity"];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    NSLog(@"缓存城市设置为%@",huanCun);
    //    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
    [self selectDataBase];
    
}
-(void)areaPicker:(CJAreaPicker *)picker didClickCancleWithAddress:(NSString *)address parentID:(NSInteger)parentID{
    
    self.parentID =parentID;
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:@"locationOfSubcity"];
    NSString *huanCun = [[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"];
    NSLog(@"缓存城市设置为%@",huanCun);
    //    self.cityInfo =huanCun;
    [self dismissViewControllerAnimated:YES completion:nil];
    [navAddressBtn setTitle:huanCun  forState:UIControlStateNormal];
    [topheaderAddressBtn setTitle:huanCun forState:UIControlStateNormal];
    [self selectDataBase];
}
#pragma mark ---------target-----------
-(void)timeBtnClick{
    
    YPReHomeShaiXuanController *shaiXuan = [[YPReHomeShaiXuanController alloc]init];
    [self.navigationController pushViewController:shaiXuan animated:YES];
    
    //婚期
    //    [BRDatePickerView showDatePickerWithTitle:@"请选择婚期" dateType:UIDatePickerModeDate defaultSelValue:[NSDate currentDateString] minDateStr:[NSDate currentDateString] maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
    //
    //        self.selectTime =selectValue;
    //        [navTimeBtn setTitle:[NSString stringWithFormat:@" %@",self.selectTime] forState:UIControlStateNormal];
    //        messageLab.text =[NSString stringWithFormat:@"%@,他们有空。点击上方按钮，重新规划婚期↑",[self.selectTime substringFromIndex:5]];
    //        [self GetWebSupplierList];
    //    }];
}

-(void)sfBtnClick{
    //身份选择器回调方法
    
    
    NSMutableArray *zytitleArr = [NSMutableArray arrayWithObject:@"全部"];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        [zytitleArr addObject:model.OccupationName];
    }
    
    //3-9 修改
    [BRStringPickerView showStringPickerWithTitle:@"请选择身份" dataSource:zytitleArr defaultSelValue:topheaderSFBtn.titleLabel.text resultBlock:^(id selectValue) {
        
        [topheaderSFBtn setTitle:selectValue forState:UIControlStateNormal];
        if ([selectValue isEqualToString:@"全部"]) {
            self.selectZhiYeCode =@"";
        }else{
            for (HRZHiYeModel *model in self.zhiYeArr) {
                
                if ([model.OccupationName isEqualToString:selectValue]) {
                    self.selectZhiYeCode =model.OccupationCode;
                }
                
            }
        }
        
        //        [self GetWebSupplierList];
        [self GetWebBannerUrl];
        //        [self getPresetListRequest];
//        [self GetWeChatActivityList];//3-2 福利活动
//        [self GetWebPlanList];
        [self GetNewPeoplePlanList];//5-15 共享方案
//        [self GetWebDiscountList];
//        [self GetWeddingInformationList];
        [self GetInformationArticleListWithWeddingInformationId:@"0"];//5-10 全部传0
//        [self GetWebSupplierList];
        
    }];
    
    //    [BRStringPickerView showStringPickerWithTitle: dataSource: defaultSelValue: topheaderSFBtn.titleLabel.text isAutoSelect:YES resultBlock:^(id selectValue) {
    //
    //        [topheaderSFBtn setTitle:selectValue forState:UIControlStateNormal];
    //        if ([selectValue isEqualToString:@"全部"]) {
    //            self.selectZhiYeCode =@"";
    //        }else{
    //            for (HRZHiYeModel *model in self.zhiYeArr) {
    //
    //                if ([model.OccupationName isEqualToString:selectValue]) {
    //                    self.selectZhiYeCode =model.OccupationCode;
    //                }
    //
    //            }
    //        }
    //
    ////        [self GetWebSupplierList];
    //        [self GetWebBannerUrl];
    ////        [self getPresetListRequest];
    //        [self GetWeChatActivityList];//3-2 福利活动
    //        [self GetWebPlanList];
    //        [self GetWebDiscountList];
    //        [self GetWeddingInformationList];
    //        [self GetWebSupplierList];
    //
    //    }];
    
}
-(void)searchBtnClick{
    HRHomeSearchViewController *searchVC = [HRHomeSearchViewController new];
    searchVC.zhiYeArr =self.zhiYeArr;
    [self.navigationController pushViewController:searchVC animated:YES];
}


-(void)cityBtnClick{
    CJAreaPicker *picker = [[CJAreaPicker alloc]initWithStyle:UITableViewStylePlain];
    picker.delegate = self;
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
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"locationOfSubcity"] ) {
        //如果不存在城市缓存
        return NO;
    }else{
        return YES;
    }
    
}

#pragma mark - YPReHomeFangAnCellDelegate
- (void)ClickColRow:(NSInteger)CellRow{
    NSLog(@"YPReHomeFangAnCellDelegate -- %zd",CellRow);
    
//    //方案展示
//    YPGetWebPlanList *plan = self.planList[CellRow];
//    YPReHomePlanDetailController *detail = [[YPReHomePlanDetailController alloc]init];
//    detail.planID = plan.PlanId;
//    [self.navigationController pushViewController:detail animated:YES];
    
    //5-15 共享方案
    YPGetDemoPlanList *plan = self.demoPlanList[CellRow];
    YPReHomePlanDetailController *detail = [[YPReHomePlanDetailController alloc]init];
    detail.planID = plan.PlanID;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - YPReHomeReSupplierCellDelegate
- (void)supplierClickColRow:(NSInteger)CellRow{
    NSLog(@"YPReHomeReSupplierCellDelegate -- %zd",CellRow);
    
    //2-10 修改 登录判断
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        YPGetWebSupplierList *model = self.supplierMarr[CellRow];
        
        NSLog(@"%@",model.ProfessionID);
        for (HRZHiYeModel *zyModel in self.zhiYeArr) {
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
            otherInfo.Name =model.Name;
            otherInfo.Headportrait =model.ImgUrl;
            otherInfo.SupplierID =[model.SupplierID integerValue];
            if (ZhuChi(model.ProfessionID)) {
                otherInfo.zhiyeName = @"主持人";
            }else if (SheXiang(model.ProfessionID)) {
                otherInfo.zhiyeName = @"摄像师";
            }else if (SheYing(model.ProfessionID)) {
                otherInfo.zhiyeName = @"摄影师";
            }else if (HuaZhuang(model.ProfessionID)) {
                otherInfo.zhiyeName = @"化妆师";
            }else if (YanYi(model.ProfessionID)) {
                otherInfo.zhiyeName = @"演艺";
            }else if (HunSha(model.ProfessionID)) {
                otherInfo.zhiyeName = @"婚纱";
            }else if (DuDao(model.ProfessionID)) {
                otherInfo.zhiyeName = @"督导师";
            }else if (HuaYi(model.ProfessionID)) {
                otherInfo.zhiyeName = @"花艺师";
            }else if (DongGuang(model.ProfessionID)) {
                otherInfo.zhiyeName = @"灯光师";
            }else if (YongHu(model.ProfessionID)) {
                otherInfo.zhiyeName = @"用户";
            }else if (CheShou(model.ProfessionID)) {
                otherInfo.zhiyeName = @"车手";
            }else if (HunQing(model.ProfessionID)) {
                otherInfo.zhiyeName = @"婚庆";
            }
            otherInfo.UserID = model.UserID;//2-6 添加 动态使用
            [self.navigationController pushViewController:otherInfo animated:YES];
            
            //        HRZhuChiXQViewController *zcXQ = [HRZhuChiXQViewController new];
            //        zcXQ.SupplierID =[model.SupplierID integerValue];
            //        zcXQ.Name =model.Name;
            //        zcXQ.Headportrait =model.ImgUrl;
            //        zcXQ.zhiyeName =selectZhiYeName;
            //        zcXQ.UserID = model.UserID;//2-6 添加 动态使用
            //        [self.navigationController pushViewController:zcXQ animated:YES];
        }
    }
}

#pragma mark - HMSegmentedControl
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segment{
    //    NSArray *arr = @[@"婚庆", @"酒店", @"婚车", @"主持人", @"化妆师", @"摄影师", @"摄像师", @"婚纱", @"演艺", @"督导师", @"花艺师", @"灯光师"];
    NSLog(@"HMSegmentedControl -- %zd",segment.selectedSegmentIndex);
    NSLog(@"HMSegmentedControl -- %@",self.zhiYeArr[segment.selectedSegmentIndex]);
    
    HRZHiYeModel *model = self.zhiYeArr[segment.selectedSegmentIndex];
    self.supplierStr = model.OccupationName;//选中职业
    
    //    [thistableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
    
    if (self.zhiYeArr.count > 0) {
        
        HRZHiYeModel *firstModel = self.zhiYeArr[0];
        NSString *str = firstModel.OccupationName;//第一个职业
        
        if (self.supplierStr.length == 0 || [self.supplierStr isEqualToString:str]) {
            self.supplierCell.titleStr = str;
            
            //        [self.supplierCell.colView reloadData];
            
            self.selectZhiYeCode = firstModel.OccupationCode;
            
        }else{
            self.supplierCell.titleStr = self.supplierStr;
            
            //        [self.supplierCell.colView reloadData];
            
            HRZHiYeModel *model = self.zhiYeArr[segment.selectedSegmentIndex];
            self.selectZhiYeCode = model.OccupationCode;
            
        }
        
    }
    
    [self GetWebSupplierList];
}

#pragma mark - 免费办婚礼 target
- (void)header0BtnClick{
    NSLog(@"header0BtnClick");
    //免费办婚礼
    //2-10 修改 登录判断
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
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
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
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
    if (!myID) {
        YPLoginController *first = [[YPLoginController alloc]init];
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
        //方案展示
//        YPReHomePlanListController *show = [[YPReHomePlanListController alloc]init];
//        [self.navigationController pushViewController:show animated:YES];
        
        //5-15 共享方案
        HRFAStoreViewController *faanganVC = [HRFAStoreViewController new];
        [self.navigationController pushViewController:faanganVC animated:YES];
        
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

#pragma mark 奖品列表
- (void)bigBtnClick{
    NSLog(@"bigBtnClick");
    YPGetActivityPrizesList *gift0 = self.listMarr[0];
    HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
    xqvc.activityPrizesID = gift0.ActivityPrizesID;
    [self.navigationController pushViewController:xqvc animated:YES];
}

- (void)small1BtnClick{
    NSLog(@"small1BtnClick");
    YPGetActivityPrizesList *gift1 = self.listMarr[1];
    HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
    xqvc.activityPrizesID = gift1.ActivityPrizesID;
    [self.navigationController pushViewController:xqvc animated:YES];
}

- (void)small2BtnClick{
    NSLog(@"small2BtnClick");
    YPGetActivityPrizesList *gift2 = self.listMarr[2];
    HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
    xqvc.activityPrizesID = gift2.ActivityPrizesID;
    [self.navigationController pushViewController:xqvc animated:YES];
}

- (void)small3BtnClick{
    NSLog(@"small3BtnClick");
    YPGetActivityPrizesList *gift3 = self.listMarr[3];
    HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
    xqvc.activityPrizesID = gift3.ActivityPrizesID;
    [self.navigationController pushViewController:xqvc animated:YES];
}

- (void)small4BtnClick{
    NSLog(@"small4BtnClick");
    YPGetActivityPrizesList *gift4 = self.listMarr[4];
    HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
    xqvc.activityPrizesID = gift4.ActivityPrizesID;
    [self.navigationController pushViewController:xqvc animated:YES];
}

#pragma mark 优惠信息
- (void)btn1Click{
    NSLog(@"btn1Click");
    
    YPGetWebDiscountList *list = self.discountMarr[0];
    if (list.DiscountURL.length > 0) {
        YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:list.DiscountURL]];//@"http://www.baidu.com"
        webVC.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前功能正在开发,敬请期待" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)btn2Click{
    NSLog(@"btn2Click");
    
    YPGetWebDiscountList *list = self.discountMarr[1];
    if (list.DiscountURL.length > 0) {
        YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:list.DiscountURL]];//@"http://www.baidu.com"
        webVC.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前功能正在开发,敬请期待" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)btn3Click{
    NSLog(@"btn3Click");
    
    YPGetWebDiscountList *list = self.discountMarr[2];
    if (list.DiscountURL.length > 0) {
        YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:list.DiscountURL]];//@"http://www.baidu.com"
        webVC.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前功能正在开发,敬请期待" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)btn4Click{
    NSLog(@"btn4Click");
    
    YPGetWebDiscountList *list = self.discountMarr[3];
    if (list.DiscountURL.length > 0) {
        YPReHomeWebViewController *webVC = [[YPReHomeWebViewController alloc]initWithUrl:[NSURL URLWithString:list.DiscountURL]];//@"http://www.baidu.com"
        webVC.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前功能正在开发,敬请期待" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark 供应商选择
- (void)moreBtnClick{
    NSLog(@"moreBtnClick");
    
    [UIView animateWithDuration:0.5 animations:^{
        self.control = [[UIControl alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT)];
        self.control.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        [self.control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupRadioBtnViewWithControl:self.control];
        
        [self.view addSubview:self.control];
    }];
    
}

- (void)controlClick:(UIControl *)sender{
    NSLog(@"controlClick");
    
    [sender removeFromSuperview];
}

- (void)setupRadioBtnViewWithControl:(UIControl *)control {
    
    CGFloat marginX = 15;
    CGFloat top = 50;
    CGFloat btnH = 50;
    CGFloat width = (ScreenWidth-10*2-2*marginX)/3.0;
    NSInteger maxCol = 3;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (HRZHiYeModel *model in self.zhiYeArr) {
        [arr addObject:model.OccupationName];
    }
    
    NSInteger maxRow = arr.count / maxCol; //行
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WhiteColor;
    [control addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(control);
        make.height.mas_equalTo(top + maxRow * (btnH + marginX) + marginX + btnH);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"选择分类";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(control);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = bgColor;
    [control addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(control);
        make.right.mas_equalTo(label.mas_left).mas_offset(-15);
        make.centerY.mas_equalTo(label);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = bgColor;
    [control addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(control);
        make.left.mas_equalTo(label.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(label);
        make.height.mas_equalTo(1);
    }];
    
    //    NSArray *arr = @[@"婚庆", @"酒店", @"婚车", @"主持人", @"化妆师", @"摄影师", @"摄像师", @"婚纱", @"演艺", @"督导师", @"花艺师", @"灯光师"];
    
    // 循环创建按钮
    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton *proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        proBtn.backgroundColor = UnselectedColor;
        proBtn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        //        proBtn.layer.borderColor = RGB(51, 51, 51).CGColor;
        //        proBtn.layer.borderWidth = 2;
        proBtn.clipsToBounds = YES;
        proBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [proBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateSelected];
        [proBtn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == self.segmentedControl.selectedSegmentIndex) {
            proBtn.selected = YES;
            proBtn.enabled = NO;
            proBtn.backgroundColor = SelectedColor;
        }else{
            proBtn.selected = NO;
            proBtn.enabled = YES;
            proBtn.backgroundColor = UnselectedColor;
        }
        
        NSInteger col = i % maxCol; //列
        proBtn.x = 10 + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        proBtn.y = top + row * (btnH + marginX);
        proBtn.width = width;
        proBtn.height = btnH;
        [proBtn setTitle:arr[i] forState:UIControlStateNormal];
        [control addSubview:proBtn];
        proBtn.tag = i;
        [self.btnArray addObject:proBtn];
    }
}

- (void)chooseMark:(UIButton *)sender {
    NSLog(@"点击了%@", sender.titleLabel.text);
    
    self.selectedBtn = sender;
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
        } else {
            btn.selected = NO;
        }
        btn.backgroundColor = UnselectedColor;
    }
    
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        btn.backgroundColor = SelectedColor;
        self.segmentedControl.selectedSegmentIndex = sender.tag;
        
        self.supplierStr = sender.titleLabel.text;
        
        HRZHiYeModel *model = self.zhiYeArr[0];
        
        if (self.supplierStr.length == 0 || [self.supplierStr isEqualToString:model.OccupationName]) {
            self.supplierCell.titleStr = @"婚庆";
            
            
            self.selectZhiYeCode = model.OccupationCode;
            
            //            [self.supplierCell.colView reloadData];
            
        }else{
            self.supplierCell.titleStr = self.supplierStr;
            
            HRZHiYeModel *model = self.zhiYeArr[sender.tag];
            self.selectZhiYeCode = model.OccupationCode;
            
            //            [self.supplierCell.colView reloadData];
        }
        
        [self GetWebSupplierList];
        
        //        [thistableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
        
        //        [self.control removeFromSuperview];
    } else {
        btn.backgroundColor = UnselectedColor;
    }
}

#pragma mark 重新加载
- (void)refreshBtnClick{
    [self getZhiYeList];
}

#pragma mark 福利活动红包
- (void)redWalletBtnClick{
    NSLog(@"福利活动红包");
    
    
    if (!myID) {
        //未领取新人红包
        [self addADView];
        YPLoginController *first = [[YPLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        if (RedEnvelopes ==0) {
            //未领取新人红包
            [self addADView];
        }else{
            [EasyShowTextView showText:@"您已领取新人红包，不能重复领取"];
        }
    }
    
    
    
    
}

#pragma mark - LLNoDataViewTouchDelegate
- (void)didTouchLLNoDataView{
    
    [self GetWebSupplierList];
    
    thistableView.tableFooterView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ----------网络请求----------------
#pragma mark 获取所有职业列表
- (void)getZhiYeList{
    //    [EasyShowLodingView showLoding];
    NSString *url = @"/api/User/GetAllOccupationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Type"] = @"2";//0、获取所有 1、注册（不包含公司、用户、婚车）2、主页（不包含 用户、车手）
    
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
                [marr addObject:@{zhiye.OccupationName:zhiye.OccupationCode}];
            }
            [[NSUserDefaults standardUserDefaults] setObject:marr forKey:@"ProfessionArr"];
            
            NSLog(@"职业列表数组个数%zd",self.zhiYeArr.count);
            [self createData];
//            [self prepareUI];
            if (![self checkCityInfo]) {
                [self cityBtnClick];
            }else{
                
//                //5-14 进入首页更新位置
//                [self selectDataBase];
                
                [self GetWebBannerUrl];
                //                [self getPresetListRequest];
//                [self GetWeChatActivityList];//3-2 福利活动
//                [self GetWebPlanList];
                [self GetNewPeoplePlanList];//5-15 共享方案
//                [self GetWebDiscountList];
//                [self GetWeddingInformationList];
                [self GetInformationArticleListWithWeddingInformationId:@"0"];//5-10 全部传0
//                [self GetWebSupplierList];
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
//- (void)getGYSList{
//    MBProgressHUD *hud = [MBProgressHUD wj_showActivityLoading:@"" toView:self.view];
//    NSString *url = @"/api/User/GetSupplierInfoList";
//
//    if ([self.selectZhiYeCode isEqualToString:@""]) {
//        if (self.zhiYeArr.count > 0) {
//            HRZHiYeModel *model = self.zhiYeArr[0];
//            self.selectZhiYeCode = model.OccupationCode;
//        }
//    }
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    params[@"UserID"]   = myID;
//    params[@"OccupationCode"] =self.selectZhiYeCode;;
//    params[@"WeddingDate"]  = self.selectTime;
//    params[@"Region"]       = areaID;
//    params[@"NameAndPhone"] = @"";
//    params[@"PageIndex"]    = @"1";
//    params[@"PageCount"]    = @"10000";
//    NSLog(@"%@",params);
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//        // 菊花不会自动消失，需要自己移除
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            [self.GYSArr removeAllObjects];
//            self.GYSArr  =[HRGYSModel mj_objectArrayWithKeyValuesArray:object[@"Data"]];
//
//            //            //
//            NSLog(@"列表：%@",object);
//
//            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
//
//            self.supplierCell.gysMarr = self.GYSArr;
//
//            [self.supplierCell.colView reloadData];
//
//            [self.control removeFromSuperview];
//
////            [thistableView reloadData];
////            if (self.GYSArr.count > 0) {
////
////                thistableView.tableFooterView = nil;
////            }else{
////
////                [MBProgressHUD wj_showPlainText:@"当前没有数据!" hideAfterDelay:1.0 view:self.view];
////
////                LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:CGRectMake(0, 250, ScreenWidth, ScreenHeight-250-64) LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
////                dataView.delegate = self;
////                thistableView.tableFooterView = dataView;
////
////                //实例一次，再次修改提示文本信息
////                dataView.tipLabel.text = @"当前没有加载到数据";
////
////            }
//
//        }else{
//
//            [MBProgressHUD wj_showPlainText:[[object valueForKey:@"Message"] valueForKey:@"Inform"]  hideAfterDelay:3.0 view:self.view];
//
//
//
//        }
//
//    } Failure:^(NSError *error) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hud removeFromSuperview];
//        });
//        [MBProgressHUD wj_showError:@"网络错误，请稍后重试" hideAfterDelay:3.0 toView:self.view];
//
//    }];
//}

#pragma mark 获取人婚礼策划方案 - 5-15 废弃
- (void)GetWebPlanList{
    
    NSString *url = @"/api/User/GetWebPlanList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.planList = [YPGetWebPlanList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            
//            self.planCell.planList = self.planList;
            
            [self.planCell.colView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark - 查看活动奖品列表 -- 3-1 废弃
- (void)getPresetListRequest{
    
    NSString *url = @"/api/Corp/GetActivityPrizesList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"奖品列表%@",object);
            self.listMarr = [YPGetActivityPrizesList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
    
}

#pragma mark 首页banner
- (void)GetWebBannerUrl{
    
    NSString *url = @"/api/User/GetWebBannerUrl";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [self.bannerURLMarr removeAllObjects];
            self.bannerURLMarr = [YPGetWebBannerUrl mj_objectArrayWithKeyValuesArray:[object objectForKey:@"PhoneBanner"]];
     
            self.mianfei = [object valueForKey:@"mianfei"];
            self.fanxian = [object valueForKey:@"fanxian"];
            self.baomihua = [object valueForKey:@"baomihua"];
            self.fangan = [object valueForKey:@"fangan"];
            
            
            [self.topBannerImageArray  removeAllObjects];
            
                    for (YPGetWebBannerUrl *bannerURL in self.bannerURLMarr) {
                        [self.topBannerImageArray addObject:bannerURL.BannerURL];
                    }
            
            [self GetWeChatActivityList];//3-2 福利活动

        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取优惠信息列表
- (void)GetWebDiscountList{
    
    NSString *url = @"/api/User/GetWebDiscountList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"1000";
    params[@"IsHeat"]   = @"0";//0不是热门 1是热门
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.discountMarr = [YPGetWebDiscountList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取婚礼资讯列表 - 5-10 废弃 直接查全部文章列表
- (void)GetWeddingInformationList{

    NSString *url = @"/api/User/GetWeddingInformationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] = @"1000";
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.headerMarr = [YPGetWeddingInformationList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [thistableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
            
//            [self.headerCell.btn1 setSelected:YES];//首次选中第一个
//
//            if (self.headerMarr.count > 0) {
//                YPGetWeddingInformationList *list = self.headerMarr[0];
//                [self GetInformationArticleListWithWeddingInformationId:list.WeddingInformationID];//首次调用
//            }
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取资讯文章列表
- (void)GetInformationArticleListWithWeddingInformationId:(NSString *)articleID{

    NSString *url = @"/api/User/GetInformationArticleList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] =  @"5";//限制5条
    params[@"WeddingInformationId"] = articleID;//5-10 全部传0
    params[@"Title"] = @"";//模糊搜索
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.articleMarr = [YPGetInformationArticleList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];

            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

#pragma mark 获取web供应商列表
- (void)GetWebSupplierList{
    
    NSString *url = @"/api/User/GetWebSupplierList";
    
    if ([self.selectZhiYeCode isEqualToString:@""]) {
        if (self.zhiYeArr.count > 0) {
            HRZHiYeModel *model = self.zhiYeArr[0];
            self.selectZhiYeCode = model.OccupationCode;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"OccupationCode"] =self.selectZhiYeCode;;
    params[@"IsHeat"]  = @"0";//0不是热门 1是热门
    params[@"RegionId"]  = areaID;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"10000";
    
    params[@"WeddingDate"] = @"";
    params[@"OrderType"] = @"0";//0首页排序 1热门排序(无用) 2动态时间排序
    params[@"NameOrPhone"] = @"";//模糊查询用
    
    NSLog(@"%@",params);
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.supplierMarr removeAllObjects];
            self.supplierMarr  =[YPGetWebSupplierList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            //            //
            NSLog(@"列表：%@",object);
            
            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            
            self.supplierCell.gysMarr = self.supplierMarr;
            
            [self.supplierCell.colView reloadData];
            
            [self.control removeFromSuperview];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 获取活动列表
- (void)GetWeChatActivityList{
    
    NSString *url = @"/api/User/GetWeChatActivityList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.fuliMarr = [YPGetWeChatActivityList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
            [self prepareUI];
            
//            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
//            [thistableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark --------红包接口 -------------
-(void)checkHongbaoLingquRequest{
    //是否领取新人红包
    NSString *url = @"/api/User/GetNewRedEnvelopesBool";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"]   = myID;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            RedEnvelopes =[[object objectForKey:@"RedEnvelopes"]integerValue];
            
            if (RedEnvelopes ==1) {
                [self hide];
            }
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}
-(void)lingquHongbaoRequest{
    //领取新人红包
    NSString *url = @"/api/User/GetNewRedEnvelopes";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserId"]   = myID;
    
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self performSelector:@selector(addOpenHongbaoView) withObject:self afterDelay:1];
            
            [self checkHongbaoLingquRequest];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}


////广告启动页接口
//- (void)GetADLaunchImage{
//
//    NSString *url = @"/api/User/SoftwarePageStarts";
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//     params[@"Type"]   = @"2";   //1安卓App地址，2IosApp地址
//    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
//
//        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//
//            self.Type =[[object objectForKey:@"Type"]integerValue];
//            self.JumpUrl =[object objectForKey:@"JumpUrl"];
//            self.HeadImg =[object objectForKey:@"HeadImg"];
//            //广告保存到本地
//            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%zd",self.Type] forKey:@"ADType"];
//            [[NSUserDefaults standardUserDefaults]setObject:self.JumpUrl forKey:@"ADJumpUrl"];
//            [[NSUserDefaults standardUserDefaults]setObject:self.HeadImg forKey:@"ADHeadImg"];
//
//
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
//


#pragma mark 查看方案列表 - 5-15 共享方案
- (void)GetNewPeoplePlanList{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/User/GetNewPeoplePlanList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PlanTitle"]        = @"";//标题
    params[@"PlanKeyWord"]      = @"";//关键字
    params[@"Color"]            = @"";//全部传空

    params[@"PageIndex"]        = @"1";
    params[@"PageCount"]        = @"8";
    
    //10-26 添加-筛选 5-24 改正序
    params[@"OrderStart"]       = @"1";//0倒序、1正序
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.demoPlanList = [YPGetDemoPlanList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            
//            [thistableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            
            self.planCell.demoPlanList = self.demoPlanList;
            
            [self.planCell.colView reloadData];
            
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

#pragma mark 判断新人是否添加了订制 -- 5-16
- (void)IsNewPeopleAddCustom{

    NSString *url = @"/api/User/IsNewPeopleAddCustom";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"] = myID;
    
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
                YPBHProjectController *project = [[YPBHProjectController alloc]init];
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

#pragma mark - getter
- (NSMutableArray<YPGetWebPlanList *> *)planList{
    if (!_planList) {
        _planList = [NSMutableArray array];
    }
    return _planList;
}

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

- (NSMutableArray<YPGetActivityPrizesList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray<YPGetWebDiscountList *> *)discountMarr{
    if (!_discountMarr) {
        _discountMarr = [NSMutableArray array];
    }
    return _discountMarr;
}

- (NSMutableArray<YPGetWeddingInformationList *> *)headerMarr{
    if (!_headerMarr) {
        _headerMarr = [NSMutableArray array];
    }
    return _headerMarr;
}

- (NSMutableArray<YPGetInformationArticleList *> *)articleMarr{
    if (!_articleMarr) {
        _articleMarr = [NSMutableArray array];
    }
    return _articleMarr;
}

- (NSMutableArray<YPGetWebSupplierList *> *)supplierMarr{
    if (!_supplierMarr) {
        _supplierMarr = [NSMutableArray array];
    }
    return _supplierMarr;
}

- (NSMutableArray<YPGetWeChatActivityList *> *)fuliMarr{
    if (!_fuliMarr) {
        _fuliMarr = [NSMutableArray array];
    }
    return _fuliMarr;
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
    
    //10-30 -- shareSDK
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"分享图标"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSString *str = @"http://www.chenghunji.com/Redbag/index";
        //        @"https://itunes.apple.com/cn/app/%E6%88%90%E5%A9%9A%E7%BA%AA-%E5%A9%9A%E7%A4%BC%E5%8A%A9%E6%89%8B/id1289565288?mt=8";
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"在这和你相遇，2018天天有惊喜！最高可享100元现金福利哦！还有更多福利，尽在成婚纪！"
                                         images:imageArray
                                            url:[NSURL URLWithString:str]
                                          title:@"【邀好友】成婚纪送现金福利！点开即得"
                                           type:SSDKContentTypeAuto];

        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[
                                         
                                         @(SSDKPlatformSubTypeWechatSession),
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         @(SSDKPlatformSubTypeQQFriend),
                                         
                                         
                                         
                                         ]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               [EasyShowTextView showSuccessText:@"分享成功"];
                               
                               break;
                           }
                           case SSDKResponseStateCancel:
                               
                           {
                               [EasyShowTextView showText:@"取消分享"];
                               
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               [EasyShowTextView showErrorText:@"分享失败"];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
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
