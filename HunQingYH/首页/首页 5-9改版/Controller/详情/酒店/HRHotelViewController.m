//
//  HRHotelViewController.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/23.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHotelViewController.h"
#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "UINavigationBar+Awesome.h"
#import "SDCycleScrollView.h"
#import "HRHotelJSTableViewController.h"
#import "HRHotelTingTableViewController.h"
#import "HRCarTeamController.h"
//2-6 添加 动态
//#import "YPHotelDongTaiTableViewController.h"
//5-23 修改 动态
#import "YPReReHomeSupplierDongTaiController.h"
//6-4 修改 头部
#import "YPReReHomeHotelHeadView.h"
//6-4 酒店活动
#import "YPBannerHotelActivityController.h"
//18-09-03 案例
#import "YPHotelAnLiTableViewController.h"

#import "LEECoolButton.h"
#import "FL_Button.h"

//18-08-11
#import "YPGetFacilitatorInfo.h"
#import "HRAnLiModel.h"
#import "GKPhotoBrowser.h"
#import "XMActionSheet.h"

//18-08-30
#import "YPHotelHuoDongTableViewController.h"//活动

@interface HRHotelViewController ()<TYSlidePageScrollViewDataSource,TYSlidePageScrollViewDelegate,SDCycleScrollViewDelegate,GKPhotoBrowserDelegate>
{
    NSString *shoucangType;// 0 没有收藏 1已经收藏
}
@property (nonatomic, weak) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic ,strong) UIButton *selectBtn;
@property (nonatomic ,strong) UIView *userHeader;
///18-08-30 修改 酒店封面图需要多张轮播
/**滚动视图*/
@property (nonatomic, strong) SDCycleScrollView *scrollView;

//@property (nonatomic ,strong) HRHotelJSTableViewController *ctrl1;//18-09-03 去掉
@property (nonatomic ,strong) HRHotelTingTableViewController *ctrl2;
@property(nonatomic,strong)HRCarTeamController *ctrl3;
/////2-6 添加 动态
//@property(nonatomic,strong)YPHotelDongTaiTableViewController *ctrl4;
///5-23 修改 动态
@property (nonatomic, strong) YPReReHomeSupplierDongTaiController *ctrl4;
///18-08-30 活动
@property (nonatomic, strong) YPHotelHuoDongTableViewController *ctrl5;
///18-09-03 案例
@property (nonatomic, strong) YPHotelAnLiTableViewController *anliVC;

/**18-08-11 详情模型*/
@property (nonatomic, strong) YPGetFacilitatorInfo *infoModel;
/**18-11-19 图片数组*/
@property (nonatomic, strong) NSMutableArray *imgMarr;

/**18-08-11 案例数组*/
@property (nonatomic, strong) NSMutableArray<HRAnLiModel *> *anliMarr;

/**是否收藏 0未收藏 1已收藏*/
@property(nonatomic,assign)NSInteger  IsCollection;

@end

@implementation HRHotelViewController{
      UIView *navView;
    //    NSInteger _pageIndex;
    LEECoolButton *starButton;//收藏按钮
    NSInteger isShouCangRequest;//1 需要请求收藏接口 其他数字不需要
    YPReReHomeHotelHeadView *_hotelHeadV;

//***************************** 6-4 ****************************
    /**是否签约公司
     0未签约,1已签约 酒店时返回*/
//    NSString *_IsSign;
    /**是否送礼
     0未送礼,1已送礼 酒店时返回*/
//    NSString *_IsGifts;
    /**标注
        例如 首单送2580元新人大礼*/
    NSString *_Tag;
//***************************** 6-4 ****************************
    
    UIImageView *iconImageView;//酒店头像
    UILabel *nameLab;//名称
    UIButton *zhiyeBtn;//职业
}

- (NSMutableArray<HRAnLiModel *> *)anliMarr{
    if (!_anliMarr) {
        _anliMarr = [NSMutableArray array];
    }
    return _anliMarr;
}

- (YPGetFacilitatorInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetFacilitatorInfo alloc]init];
    }
    return _infoModel;
}

- (NSMutableArray *)imgMarr{
    if (!_imgMarr) {
        _imgMarr = [NSMutableArray array];
    }
    return _imgMarr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =CHJ_bgColor;
    
    isShouCangRequest =0;
    
    [self addSlidePageScrollView];

    [self createNav];
    
    [self createBottomView];
    [self addTabPageMenu];
    
    [self GetFacilitatorInfo];
}
- (void)createNav {
    if (!navView) {
        navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    }
    
    if (JiuDian(self.profession)) {
        navView.backgroundColor = [UIColor clearColor];
    }else{
        navView.backgroundColor = WhiteColor;
    }
    
    [self.view addSubview:navView];
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回B"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40,20));
        make.left.mas_equalTo(navView);
        make.centerY.mas_equalTo(navView.mas_centerY).offset(10);
    }];
    
    
}
-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth,50)];
    bottomView.backgroundColor =WhiteColor;
    
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor =CHJ_bgColor;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(2, 30));
        
    }];
    
    
    //    LEECoolButton *starButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"star"] ImageFrame:CGRectMake(10, 10, 20, 20)];
    
    //FIXME: 18-08-18 收藏暂时隐藏
//    starButton = [LEECoolButton coolButtonWithImage:[UIImage imageNamed:@"star"] ImageFrame:CGRectMake((ScreenWidth/3-31)/2-45, 3, 20, 20)WithTitle:@"收藏" TitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f]];
//
//    starButton.frame = CGRectMake(15, 10, ScreenWidth/3-31, 30);
//
//    [starButton addTarget:self action:@selector(starButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    [bottomView addSubview:starButton];
 
    
    
    FL_Button *phoneBtn = [FL_Button fl_shareButton];
    [phoneBtn setBackgroundColor:[UIColor whiteColor]];
    [phoneBtn setImage:[UIImage imageNamed:@"手机"] forState:UIControlStateNormal];
    [phoneBtn setTitle:@" 电话" forState:UIControlStateNormal];
    
    [phoneBtn setTitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f] forState:UIControlStateNormal];
    phoneBtn.status = FLAlignmentStatusNormal;
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    phoneBtn.frame = CGRectMake(ScreenWidth/3+1,10, ScreenWidth/3-31, 30);
    phoneBtn.frame = CGRectMake(0,10, ScreenWidth*0.5, 30);//18-08-18 去掉
    [bottomView addSubview:phoneBtn];
    
    //5-29 添加 预约
    UIView *colorView = [[UIView alloc] init];
//    [colorView setFrame:CGRectMake(ScreenWidth/3*2+1,0, ScreenWidth/3, 50)];
    [colorView setFrame:CGRectMake(ScreenWidth*0.5+1,0, ScreenWidth*0.5, 50)];
    [bottomView addSubview:colorView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGB(250, 80, 120).CGColor,
                       (id)RGB(249, 102, 141).CGColor,
                       (id)RGB(253, 136, 176).CGColor, nil];
    [colorView.layer addSublayer:gradient];
    
    FL_Button *appointBtn = [FL_Button fl_shareButton];
//    [appointBtn setTitle:@"预约商家" forState:UIControlStateNormal];
    [appointBtn setTitle:@"预约商家" forState:UIControlStateNormal];
    [appointBtn setTitleColor:WhiteColor forState:UIControlStateNormal];

//    [appointBtn setTitleColor:[UIColor colorWithRed:136/255.0f green:153/255.0f blue:166/255.0f alpha:1.0f] forState:UIControlStateNormal];
    appointBtn.status = FLAlignmentStatusNormal;
    appointBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [appointBtn addTarget:self action:@selector(appointBtnClick) forControlEvents:UIControlEventTouchUpInside];
    appointBtn.frame = colorView.frame;
    [bottomView addSubview:appointBtn];
    
}

#pragma mark - target
- (void)appointBtnClick{
    //5-29 预约
    [self CreateUserAppointment];
}

#pragma mark - UI
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)addSlidePageScrollView
{
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth, CGRectGetHeight(self.view.frame)-50)];
    //CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    slidePageScrollView.pageTabBarIsStopOnTop = 1;
    slidePageScrollView.pageTabBarStopOnTopHeight = NAVIGATION_BAR_HEIGHT;
    slidePageScrollView.parallaxHeaderEffect = YES;
    slidePageScrollView.dataSource = self;
    slidePageScrollView.delegate = self;
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}

- (void)addHeaderView
{
    _slidePageScrollView.headerView = self.userHeader;
}

- (void)addTabPageMenu
{
    if (JiuDian(self.profession)) {
        TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"宴会厅",@"动态",@"特惠",@"案例"]];//18-08-30 添加活动  18-08-31 改为折扣 18-09-03 去掉@"酒店信息" 添加@"案例" 18-09-05 特惠
        titlePageTabBar.frame = CGRectMake(0, CGRectGetMaxY(self.userHeader.frame), CGRectGetWidth(_slidePageScrollView.frame), 40);
        titlePageTabBar.backgroundColor = WhiteColor;
        titlePageTabBar.horIndicatorSpacing = 40;
        _slidePageScrollView.pageTabBar = titlePageTabBar;
    }else{
        TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:@[@"动态",@"特惠",@"案例"]]; //FIXME:@"车型", 18-08-18 车型隐藏 18-08-30 添加活动 18-08-31 改为折扣 18-09-03 去掉@"酒店信息" 添加@"案例" 18-09-05 特惠
        titlePageTabBar.frame = CGRectMake(0, CGRectGetMaxY(self.userHeader.frame), CGRectGetWidth(_slidePageScrollView.frame), 40);
        titlePageTabBar.backgroundColor = WhiteColor;
        titlePageTabBar.horIndicatorSpacing = 40;
        _slidePageScrollView.pageTabBar = titlePageTabBar;
    }
    
   
}

- (void)addTableView{
    
//    if (!self.ctrl1) {
//        self.ctrl1 = [[HRHotelJSTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    }
//    self.ctrl1.rowhight =[self getHeighWithTitle:self.infoModel.Abstract font:[UIFont systemFontOfSize:15] width:ScreenWidth-60];
//    self.ctrl1.BriefinTroduction =self.infoModel.Abstract;
//    self.ctrl1.Adress =self.infoModel.Address;
//    self.ctrl1.SupplierID = self.FacilitatorID;
    
    if (!self.ctrl2) {
        self.ctrl2 = [[HRHotelTingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    //FIXME: 18-08-11 酒店ID 获取酒店信息 -- 18-08-14 酒店ID全部去掉
    self.ctrl2.SupplierID = self.FacilitatorID;
    self.ctrl2.zhiyeName = self.profession;
    //        if ([self.fromFlag isEqualToString:@"2"]) {
    //            self.ctrl2.fromFlag =@"2";
    //        }else{
    //            self.ctrl2.fromFlag =@"3";
    //        }
    
    if (!self.ctrl3) {
        self.ctrl3 =[[HRCarTeamController alloc]initWithStyle:UITableViewStyleGrouped];
    }
    
    if (!self.ctrl4) {
        self.ctrl4 = [[YPReReHomeSupplierDongTaiController alloc] init];
    }
    self.ctrl4.userID = self.infoModel.UserId;
    
    //18-08-30 活动
    if (!self.ctrl5) {
        self.ctrl5 = [[YPHotelHuoDongTableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    self.ctrl5.FacilitatorId = self.infoModel.Id;
    
    //18-09-03 案例
    if (!self.anliVC) {
        self.anliVC = [[YPHotelAnLiTableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    self.anliVC.SupplierID = self.FacilitatorID;
    
//    self.ctrl1.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl2.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl3.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl4.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.ctrl5.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    self.anliVC.view.frame = CGRectMake(0,0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-50);
    //    self.ctrl2.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        _pageIndex = 1;
    //        [self getBanquetHallList];
    //    }];
    
//    [self addChildViewController:self.ctrl1];
    [self addChildViewController:self.ctrl2];
    [self addChildViewController:self.ctrl4];
    [self addChildViewController:self.ctrl5];
    [self addChildViewController:self.anliVC];
//    [self addChildViewController:self.ctrl3];
}

#pragma mark - dataSource

- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    if (index == 1) {
        YPReReHomeSupplierDongTaiController *dongtai = self.childViewControllers[index];
        return dongtai.collectionView;
    }else{
        UITableViewController *tableViewVC = self.childViewControllers[index];
        return tableViewVC.tableView;
    }
}

#pragma mark - delegate

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    //    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
    CGFloat headerContentViewHeight = -(CGRectGetHeight(slidePageScrollView.headerView.frame)+CGRectGetHeight(slidePageScrollView.pageTabBar.frame));
    // 获取当前偏移量
    CGFloat offsetY = pageScrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - headerContentViewHeight;
    
    CGFloat alpha = delta / (CGRectGetHeight(slidePageScrollView.headerView.frame) - NAVIGATION_BAR_HEIGHT);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[NavBarColor colorWithAlphaComponent:alpha]];
}

#pragma mark - getter
- (UIView *)userHeader{
    if (!_userHeader) {
        _userHeader = [[UIView alloc]init];
        _userHeader.backgroundColor = [UIColor whiteColor];
    }
    
    if (JiuDian(self.profession)) {
        
        if (self.infoModel.Tag.length == 0 && self.infoModel.Xfyl.integerValue == 0 && self.infoModel.Hldb.integerValue == 0) {
            //都不显示
            _userHeader.frame = CGRectMake(0, 0, ScreenWidth,150+70+(15+15+12+[self getHeighWithTitle:self.infoModel.Address font:kFont(12) width:(ScreenWidth-30-12-2)]+[self getHeighWithTitle:self.infoModel.Abstract font:kFont(15) width:(ScreenWidth-30)]));//6-4 修改 酒店加105 18-09-03 上移地址/简介
        }else{
            _userHeader.frame = CGRectMake(0, 0, ScreenWidth,150+105+(15+15+12+[self getHeighWithTitle:self.infoModel.Address font:kFont(12) width:(ScreenWidth-30-12-2)]+[self getHeighWithTitle:self.infoModel.Abstract font:kFont(15) width:(ScreenWidth-30)]));//6-4 修改 酒店加105 18-09-03 上移地址/简介
        }
    }else{
        _userHeader.frame = CGRectMake(0, 0, ScreenWidth,150+105);//18-08-30 所有职业都改
    }
    
//    [self setupHeaderView];
    
    return _userHeader;
}

//6-4 
- (void)setupHeaderView{

    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.infoModel.Logo]];
    UIImage* resultImage = [UIImage imageWithData: imageData];
    
    if (!self.scrollView) {

        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -NAVIGATION_BAR_HEIGHT, ScreenWidth,150+NAVIGATION_BAR_HEIGHT) delegate:self placeholderImage:resultImage];//18-08-30 没有封面显示头像
        self.scrollView.currentPageDotColor = MainColor;
        self.scrollView.pageDotColor = CHJ_bgColor;
        self.scrollView.autoScroll = NO;
        self.scrollView.pageControlBottomOffset = -30;
        self.scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        self.scrollView.layer.masksToBounds = YES;
    }
    if (self.imgMarr.count > 0) {
        self.scrollView.imageURLStringsGroup = self.imgMarr.copy;
    }else{
        self.scrollView.imageURLStringsGroup = @[self.infoModel.Logo];//18-08-30 没有封面显示头像
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%zd 张图",self.imgMarr.count==0?1:self.imgMarr.count];
    label.textColor = WhiteColor;
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    [self.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-15);
    }];
    
    [_userHeader addSubview:self.scrollView];

    if (JiuDian(self.profession)) {
        
        if (!_hotelHeadV) {
            _hotelHeadV = [YPReReHomeHotelHeadView yp_rereHomeHotelHeadView];
        }
        
        if (self.infoModel.Tag.length == 0 && self.infoModel.Xfyl.integerValue == 0 && self.infoModel.Hldb.integerValue == 0) {
            //都不显示
            _hotelHeadV.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, 70+(15+15+12+[self getHeighWithTitle:self.infoModel.Address font:kFont(12) width:(ScreenWidth-30-12-2)]+[self getHeighWithTitle:self.infoModel.Abstract font:kFont(15) width:(ScreenWidth-30)]));//18-09-03 上移地址/简介
        }else{
            _hotelHeadV.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, 105+(15+15+12+[self getHeighWithTitle:self.infoModel.Address font:kFont(12) width:(ScreenWidth-30-12-2)]+[self getHeighWithTitle:self.infoModel.Abstract font:kFont(15) width:(ScreenWidth-30)]));//18-09-03 上移地址/简介
        }
        
        if (self.infoModel.Name.length > 0) {
            _hotelHeadV.titleLabel.text = self.infoModel.Name;
        }else{
            _hotelHeadV.titleLabel.text = @"当前无名称";
        }
        _hotelHeadV.profession.text = @"酒店";
        
        //tag
        if (_Tag.length > 0) {//标注
            _hotelHeadV.tagLabel.text = [NSString stringWithFormat:@" %@ ",_Tag];
            _hotelHeadV.tagImgV.hidden = NO;
            _hotelHeadV.tehuiTag.hidden = NO;
            _hotelHeadV.tagButton.hidden = NO;
            [_hotelHeadV.tagButton addTarget:self action:@selector(tagButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
            _hotelHeadV.tagLabel.text = @"";
            _hotelHeadV.tagImgV.hidden = YES;
            _hotelHeadV.tehuiTag.hidden = YES;
            [_hotelHeadV.tagImgV removeFromSuperview];
            [_hotelHeadV.tagLabel removeFromSuperview];
            [_hotelHeadV.tagButton removeFromSuperview];
        }
        
        //18-10-26 判断显示 - 窦
        if (self.infoModel.Xfyl.integerValue == 0) {//0未参加,1已参加
            _hotelHeadV.xiaofeiyouli.hidden = YES;
        }else if (self.infoModel.Xfyl.integerValue == 1) {
            _hotelHeadV.xiaofeiyouli.hidden = NO;
        }
        if (self.infoModel.Hldb.integerValue == 0) {//0未参加,1已参加
            _hotelHeadV.hunlidanbao.hidden = YES;
        }else if (self.infoModel.Hldb.integerValue == 1) {
            _hotelHeadV.hunlidanbao.hidden = NO;
        }
        
        //18-09-03 修改 地址/简介上移
        if (self.infoModel.Address.length > 0) {
            _hotelHeadV.addressLabel.text = self.infoModel.Address;
        }else{
            _hotelHeadV.addressLabel.text = @"无地址";
        }
        if (self.infoModel.Abstract.length > 0) {
            _hotelHeadV.abstractLabel.text = self.infoModel.Abstract;
        }else{
            _hotelHeadV.addressLabel.text = @"无简介";
        }
        
        [_userHeader addSubview:_hotelHeadV];
        
    }else{
        
        //18-08-30 修改
        if (!_hotelHeadV) {
            _hotelHeadV = [YPReReHomeHotelHeadView yp_rereHomeHotelHeadView];
            _hotelHeadV.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), ScreenWidth, 105);
        }
        if (self.infoModel.Name.length > 0) {
            _hotelHeadV.titleLabel.text = self.infoModel.Name;
        }else{
            _hotelHeadV.titleLabel.text = @"当前无名称";
        }
        _hotelHeadV.profession.text = [CXDataManager checkUserProfession:self.profession];
      
        _hotelHeadV.tagLabel.text = @"";
        _hotelHeadV.tagImgV.hidden = YES;
        _hotelHeadV.tehuiTag.hidden = YES;
        [_hotelHeadV.tagImgV removeFromSuperview];
        [_hotelHeadV.tagLabel removeFromSuperview];
        [_hotelHeadV.tagButton removeFromSuperview];
        
//        _hotelHeadV.xiaofeiyouli.hidden = YES;
//        _hotelHeadV.hunlidanbao.hidden = YES;
        
        //18-10-26 判断显示 - 窦
        if (self.infoModel.Xfyl.integerValue == 0) {//0未参加,1已参加
            _hotelHeadV.xiaofeiyouli.hidden = YES;
        }else if (self.infoModel.Xfyl.integerValue == 1) {
            _hotelHeadV.xiaofeiyouli.hidden = NO;
        }
        if (self.infoModel.Hldb.integerValue == 0) {//0未参加,1已参加
            _hotelHeadV.hunlidanbao.hidden = YES;
        }else if (self.infoModel.Hldb.integerValue == 1) {
            _hotelHeadV.hunlidanbao.hidden = NO;
        }
        
        [_userHeader addSubview:_hotelHeadV];
        
//        if (!nameLab) {
//            nameLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-100, 100, ScreenWidth-200, 25)];
////            nameLab = [[UILabel alloc]init];//6-22 修改
//        }
//        nameLab.textColor = BlackColor;
//        nameLab.text = self.infoModel.Name;
//        nameLab.textAlignment =NSTextAlignmentCenter;
//        nameLab.font = [UIFont boldSystemFontOfSize:17.0];
//        [_userHeader addSubview:nameLab];
////        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.top.mas_equalTo(100);
////            make.centerX.mas_equalTo(_userHeader);
////        }];
//
//        if (!zhiyeBtn) {
//            zhiyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        }
//        [zhiyeBtn setBackgroundColor:RGB(146, 194, 57)];
//        zhiyeBtn.titleLabel.font =kFont(13);
//        if (JiuDian(self.profession)) {
//            [zhiyeBtn setTitle:@"酒店" forState:UIControlStateNormal];
//        }else if (HunChe(self.profession)) {
//            [zhiyeBtn setTitle:@"婚车" forState:UIControlStateNormal];
//        }else if (ZhuChi(self.profession)) {
//            [zhiyeBtn setTitle:@"主持人" forState:UIControlStateNormal];
//        }else if (SheXiang(self.profession)) {
//            [zhiyeBtn setTitle:@"摄像师" forState:UIControlStateNormal];
//        }else if (SheYing(self.profession)) {
//            [zhiyeBtn setTitle:@"摄影师" forState:UIControlStateNormal];
//        }else if (HuaZhuang(self.profession)) {
//            [zhiyeBtn setTitle:@"化妆师" forState:UIControlStateNormal];
//        }else if (YanYi(self.profession)) {
//            [zhiyeBtn setTitle:@"演艺" forState:UIControlStateNormal];
//        }else if (HunSha(self.profession)) {
//            [zhiyeBtn setTitle:@"婚纱" forState:UIControlStateNormal];
//        }else if (DuDao(self.profession)) {
//            [zhiyeBtn setTitle:@"督导师" forState:UIControlStateNormal];
//        }else if (HuaYi(self.profession)) {
//            [zhiyeBtn setTitle:@"花艺师" forState:UIControlStateNormal];
//        }else if (DongGuang(self.profession)) {
//            [zhiyeBtn setTitle:@"灯光师" forState:UIControlStateNormal];
//        }else if (YongHu(self.profession)) {
//            [zhiyeBtn setTitle:@"用户" forState:UIControlStateNormal];
//        }else if (CheShou(self.profession)) {
//            [zhiyeBtn setTitle:@"车手" forState:UIControlStateNormal];
//        }else if (HunQing(self.profession)) {
//            [zhiyeBtn setTitle:@"婚庆" forState:UIControlStateNormal];
//        }
//        zhiyeBtn.clipsToBounds =YES;
//        zhiyeBtn.layer.cornerRadius =2;
//        [zhiyeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_userHeader addSubview:zhiyeBtn];
//        [zhiyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(_userHeader);
//            make.top.mas_equalTo(nameLab.mas_bottom);
//            make.size.mas_equalTo(CGSizeMake(50, 20));
//        }];
    }
    
}

#pragma mark -------SDCycleScrollViewdelegate --------
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSMutableArray *photos = [NSMutableArray new];
    NSArray *coverArr = [[NSArray alloc]init];
    if (self.imgMarr.count > 0) {
        coverArr = self.imgMarr.copy;
        
    }else{
        coverArr = @[self.infoModel.Logo];
    }
    
    [coverArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.delegate =self;
    [browser showFromVC:self];
    
}

#pragma mark - GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index {
    
    
    [XMActionSheet xm_actionSheetWithActionTitles:@[@"保存图片"] actionHander:^(NSUInteger index) {
        
        if (index ==0) {
            
            NSArray *coverArr = self.imgMarr.copy;
            [self toSaveImage:coverArr[index]];
        }
    }];
 
}

- (void)toSaveImage:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString: urlString];
    //    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //从网络下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img= [UIImage imageWithData:data];
    
    // 保存图片到相册中
    UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    
}
//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        [EasyShowTextView showErrorText:@"图片保存失败"];
    }
    else  // No errors
    {
        [EasyShowTextView showSuccessText:@"图片保存成功"];
        
    }
}

#pragma mark - target
- (void)starButtonAction:(LEECoolButton *)sender{
  

    if (sender.selected) {
        
        //未选中状态
        
        [sender deselect];
        
        
    } else {
        
        //选中状态
        
        [sender select];
    }
    NSLog(@"%zd",isShouCangRequest);
    if (isShouCangRequest ==1) {
         isShouCangRequest =0;
    }else{
        
        //FIXME: 18-08-11 收藏暂无 -- 18-08-14 收藏重做
        self.IsCollection =!_IsCollection;
        isShouCangRequest =0;

        if (self.IsCollection ==1){
             [self CreateUserCollection];

        }else{
            [self DeleteUserCollection];
        }
    }

}
-(void)phoneBtnClick{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.infoModel.Phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)tagButtonClick{
    YPBannerHotelActivityController *hotelAct = [[YPBannerHotelActivityController alloc]init];
    [self.navigationController pushViewController:hotelAct animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
#pragma mark 供应商信息
- (void)GetFacilitatorInfo{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetFacilitatorInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = self.FacilitatorID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            self.infoModel.Id = [object objectForKey:@"Id"];
            self.infoModel.UserId = [object objectForKey:@"UserId"];
            self.infoModel.Name = [object objectForKey:@"Name"];
            self.infoModel.Logo = [object objectForKey:@"Logo"];
            self.infoModel.Phone = [object objectForKey:@"Phone"];
            self.infoModel.Address = [object objectForKey:@"Address"];
            self.infoModel.Abstract = [object objectForKey:@"Abstract"];
            
            self.infoModel.Identity = [object objectForKey:@"Identity"];
            self.infoModel.region = [object objectForKey:@"region"];
            self.infoModel.regionname = [object objectForKey:@"regionname"];
            self.infoModel.Tag = [object valueForKey:@"Tag"];
            
            _Tag = [object valueForKey:@"Tag"];
            
            //18-08-30
//            self.infoModel.CoverMap = [object valueForKey:@"CoverMap"];
            
            //18-11-19 图片
            self.infoModel.Data = [YPGetFacilitatorInfoImgData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            for (YPGetFacilitatorInfoImgData *data in self.infoModel.Data) {
                [self.imgMarr addObject:data.ImgUrl];
            }
            
            //18-09-03
            if (self.infoModel.Address.length == 0) {
                self.infoModel.Address = @"无地址";
            }
            if (self.infoModel.Abstract.length == 0) {
                self.infoModel.Abstract = @"无简介";
            }
            
            //18-10-26
            self.infoModel.Hldb = [object valueForKey:@"Hldb"];
            self.infoModel.Xfyl = [object valueForKey:@"Xfyl"];
            
            [self addHeaderView];
            [self setupHeaderView];
            [self addTableView];
            [_slidePageScrollView reloadData];
            
//            NSLog(@"%zd",self.IsCollection);
//            //处理收藏按钮 --- 18-08-11 收藏暂无
//            if (self.IsCollection ==1) {
//                //已经收藏 只需要改变收藏按钮样式，无需请求接口
//                isShouCangRequest =1;
//                shoucangType =@"1";
//                [self starButtonAction:starButton];
//            }else{
//                shoucangType =@"0";
//            }
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

#pragma mark 添加收藏
- (void)CreateUserCollection{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/CreateUserCollection";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]   = UserId_New;
    params[@"CollectionId"]   = self.FacilitatorID;
    params[@"CollectionType"]   = @"0";//0供应商、1方案、2宴会厅、3婚礼套餐
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"%@",object);
            
            shoucangType =@"1";
            [EasyShowTextView showText:@"收藏成功"];
            
            if ([shoucangType isEqualToString:@"0"]) {
                
            }else{
                shoucangType =@"0";
                [EasyShowTextView showText:@"取消收藏成功"];
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

#pragma mark 取消收藏
- (void)DeleteUserCollection{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/DeleteUserCollection";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]   = UserId_New;
    params[@"CollectionId"]   = self.FacilitatorID;
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"%@",object);
            
            shoucangType =@"0";
            [EasyShowTextView showText:@"取消收藏成功"];
            
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

#pragma mark 新增用户预约
-(void)CreateUserAppointment{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreateUserAppointment";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"Phone"] = @"";
    params[@"SupplierId"] = self.FacilitatorID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showSuccessText:@"您的预约已送达，客服会尽快与您联系"];
            
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

//动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

@end
