//
//  YPHYTHDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailController.h"
#pragma mark - Cell
#import "YPPassengerDistributionBannerCell.h"
#import "YPHYTHDetailTingTitleCell.h"
#import "YPHYTHDetailInfoCell.h"
#import "YPHYTHDetailAddressCell.h"
#import "YPHYTHDetailAdCell.h"
#import "YPHYTHDetailCanBiaoDateCell.h"
#import "YPHYTHDetailCanBiaoColCell.h"
#import "CXPassageSysCell.h"    // 免费特权。服务费
#import "CXYHTNumberCell.h"     // j宴会厅尺寸

#pragma mark - Third
#import "FL_Button.h"
#import "YPHunJJSponsorImgCell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "BRDatePickerView.h"
#pragma mark - VC
#import "YPHYTHDetailAllCanBiaoController.h"//全部餐标
#import "YPHYTHDetailCanBiaoDetailController.h"//餐标详情
#import "YPHYTHDetailSubmitOrderController.h"//提交
#import "YPSupplierHomePage181119Controller.h"//商家主页(酒店)
#import "YPHYTHGiftImgListController.h"//礼品详情
#import "YPContractController.h"//联系我们
#import "YPHYTHQueryDateViewController.h"//查询档期
#import "YPHomeReserveTingController.h"//预定厅
#import "YPReLoginController.h"         // 登录
#import "CXReceiveVC.h"         // 伴手礼
#import "YPEDuBaseController.h"         // 婚礼返还。 花多少返多少

#pragma mark - Model
#import "YPGetPreferentialCommodityInfo.h"
#import "YPGetPreferentialCommodityPriceList.h"
#import "HRTingModel.h"

@interface YPHYTHDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_bannerTitle ;
    NSString *_freeTitle ;
    NSString *_baseInfoTitle;
    NSString *_canbiaoTitle ;
    NSString *_serviceTitle ;
    NSString *_sizeTitle ;
    NSString *_homeDetailTitle ;
    NSString *_shopdetailTitle;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *detailIMGMarr;

@property (nonatomic, copy) __block NSString *dateStr;

@property (nonatomic, strong) YPGetPreferentialCommodityInfo *infoModel;
@property(nonatomic,strong)HRTingModel *banquetModel;
@property (nonatomic, strong) NSMutableArray<YPGetPreferentialCommodityPriceList *> *canbiaoMarr;
@property (nonatomic, strong) NSArray *titleArr;    // 标题的名称
@property (nonatomic, strong) UIView *detailSectionView;

@end

@implementation YPHYTHDetailController{
    UIView *_navView;
    UIButton *_backBtn;
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetPreferentialCommodityInfo];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(HRTingModel *)banquetModel{
    if (!_banquetModel) {
        _banquetModel =[HRTingModel new];
    }
    return _banquetModel;
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    _bannerTitle           = @"轮播图";
    _freeTitle                = @"免费特权";
    _baseInfoTitle        = @"基本信息";
    _canbiaoTitle         = @"餐标";
    _serviceTitle          = @"服务费";
    _sizeTitle                = @"宴会厅尺寸";
    _homeDetailTitle   = @"店铺详情";
    _shopdetailTitle    = @"酒店介绍";
    
    NSDate *date = [NSDate date];
    self.dateStr = [NSString stringWithFormat:@"%zd-%zd",date.year,date.month];
    
    [self setupUI];
    [self setupNav];
}

- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = ClearColor;
    [self.view addSubview:_navView];
    
    _backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    //    backBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //    backBtn.layer.cornerRadius = 16;
    //    backBtn.clipsToBounds = YES;
    [_navView addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(_navView.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
}

- (void)setupUI{
    self.view.backgroundColor = WhiteColor;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT-44-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
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
    
    [self createBottomView];
}

- (void)createBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-44-HOME_INDICATOR_HEIGHT, ScreenWidth,44)];
    bottomView.backgroundColor = WhiteColor;
    [self.view addSubview:bottomView];
    
    FL_Button *contactBtn = [FL_Button fl_shareButton];
    [contactBtn setTitle:@"咨询" forState:UIControlStateNormal];
    [contactBtn setImage:[UIImage imageNamed:@"HYTH_zixun"] forState:UIControlStateNormal];
    contactBtn.status = FLAlignmentStatusTop;
    contactBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [contactBtn setTitleColor:RGBS(153) forState:UIControlStateNormal];
    [contactBtn addTarget:self action:@selector(contactBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:contactBtn];
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
    }];
    
    CGFloat btnW = (ScreenWidth-90)*0.5;
    
    UIView *colorView = [[UIView alloc] init];
    [colorView setFrame:CGRectMake(90,0, ScreenWidth - 90, 44)];
    [bottomView addSubview:colorView];
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = colorView.bounds;
//    gradient.startPoint = CGPointMake(0, 0.5);
//    gradient.endPoint = CGPointMake(1, 0.5);
//    gradient.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:174/255.0 blue:155/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:254/255.0 green:115/255.0 blue:157/255.0 alpha:1.0].CGColor];
//    [colorView.layer addSublayer:gradient];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = colorView.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView.layer addSublayer:gradient];
    
    FL_Button *phoneBtn = [FL_Button fl_shareButton];
    [phoneBtn setTitleColor:WhiteColor forState:0];
    [phoneBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    phoneBtn.status = FLAlignmentStatusNormal;
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];   // 提示预约成功alert
    [phoneBtn addTarget:self action:@selector(allCanBiaoClick) forControlEvents:UIControlEventTouchUpInside];   // 全部餐标
    phoneBtn.frame = colorView.frame;
    [bottomView addSubview:phoneBtn];
    
    return;
    UIView *colorView1 = [[UIView alloc] init];
    [colorView1 setFrame:CGRectMake(ScreenWidth-btnW,0, btnW, 44)];
    [bottomView addSubview:colorView1];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = colorView1.bounds;
    gradient1.startPoint = CGPointMake(0, 0.5);
    gradient1.endPoint = CGPointMake(1, 0.5);
    gradient1.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView1.layer addSublayer:gradient1];
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderBtn setTitle:@"线上下单" forState:UIControlStateNormal];
    [orderBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.frame = colorView1.frame;
    [bottomView addSubview:orderBtn];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *param = self.titleArr[section];
    
    if ([param[@"name"] isEqualToString:_canbiaoTitle])    { return self.canbiaoMarr.count > 0 ? 2 : 1; }
    if ([param[@"name"] isEqualToString:_homeDetailTitle]) { return self.detailIMGMarr.count; }
    return [param[@"number"] intValue];
    /*
    if (section == 0) {
        return 4;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        if (self.canbiaoMarr.count > 0) {
            return 2;
        }
        return 1;
    }else{
        return self.detailIMGMarr.count;
    }
     */
}
#pragma mark - - - - - - - - - - - - - - - CELL - - - - - - - - - - - - - - - - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //轮播图、免费特权、基本信息、餐标、服务费、宴会厅尺寸、店铺详情、酒店介绍
    // 以下内容为先原技术人员，懒得改了，你慢慢瞅瞅吧
    NSDictionary *param = self.titleArr[indexPath.section];
    if ([param[@"name"] isEqualToString:_bannerTitle]) {
        if (indexPath.row == 0) {
            YPPassengerDistributionBannerCell *cell = [YPPassengerDistributionBannerCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.infoModel.CoverMap.length > 0) {
                cell.urlArr = @[self.infoModel.CoverMap];
            }else{
                cell.imgArr = @[@"图片占位"];
            }
            cell.scrollView.showPageControl = NO;
            [cell.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenWidth*0.56));
                make.edges.mas_equalTo(cell.contentView);
            }];
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = RGB(255, 82, 86);
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(18);
                make.bottom.mas_equalTo(-12);
                make.size.mas_equalTo(CGSizeMake(69, 69));
            }];
            view.layer.cornerRadius = 4;
            view.clipsToBounds = YES;
            
            UILabel *label = [[UILabel alloc]init];
            label.text = [NSString stringWithFormat:@"%@%%",self.infoModel.Discount];
            label.textColor = WhiteColor;
            label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 24];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.left.right.mas_equalTo(view);
            }];
            UILabel *label2 = [[UILabel alloc]init];
            label2.backgroundColor = WhiteColor;
            label2.text = @"下单立返";
            label2.textColor = RGB(255, 82, 86);
            label2.font = kFont(10);
            label2.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.mas_equalTo(view);
                make.height.mas_equalTo(22);
            }];
            
            if (ISEMPTY(self.infoModel.Discount) || [self.infoModel.Discount intValue] == 0) {
                [view removeFromSuperview];
            }
            return cell;
        }else if (indexPath.row == 1){
            YPHYTHDetailTingTitleCell *cell = [YPHYTHDetailTingTitleCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.infoModel.Name.length > 0) {
                cell.titleLabel.text = self.infoModel.Name;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            //  修改销量
            cell.countLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.SalesVolume];
            return cell;
        }else if (indexPath.row == 2){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label = [[UILabel alloc]init];
            label.text = [NSString stringWithFormat:@"%zd-%zd桌",self.infoModel.MinTable,self.infoModel.MaxTable];
            label.textColor = RGB(101, 200, 195);
            label.font = kFont(18);
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(18);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            return cell;
        }else if (indexPath.row == 3){
            
            YPHYTHDetailAdCell *cell = [YPHYTHDetailAdCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.PresentBanner] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            return cell;
            
        }
    }else if ([param[@"name"] isEqualToString:_baseInfoTitle]){
        
        if (indexPath.row == 0) {
            YPHYTHDetailInfoCell *cell = [YPHYTHDetailInfoCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:self.infoModel.FacilitatorImage] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            if (self.infoModel.FacilitatorName.length > 0) {
                cell.titleLabel.text = self.infoModel.FacilitatorName;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            cell.dongtai.text = [NSString stringWithFormat:@"%zd",[self.infoModel.DynamicCount integerValue]];
            cell.anli.text = [NSString stringWithFormat:@"%zd",[self.infoModel.CaseInfoCount integerValue]];
            //        cell.jianCount.text = [NSString stringWithFormat:@"%@%%",self.infoModel.Discount];
            [cell.hotelInfoBtn addTarget:self action:@selector(hotelInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.lookBtn addTarget:self action:@selector(hotelInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            YPHYTHDetailAddressCell *cell = [YPHYTHDetailAddressCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.infoModel.Address.length > 0) {
                cell.address.text = self.infoModel.Address;
            }else{
                cell.address.text = @"当前无地址";
            }
            return cell;
        }
    }else if ([param[@"name"] isEqualToString:_canbiaoTitle]){
        if (indexPath.row == 0) {
            YPHYTHDetailCanBiaoDateCell *cell = [YPHYTHDetailCanBiaoDateCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *arr = [self.dateStr componentsSeparatedByString:@"-"];
            [cell.dateBtn setTitle:[NSString stringWithFormat:@"选择婚宴月份  %@月",arr[1]] forState:UIControlStateNormal];
            [cell.dateBtn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.allCanBiao addTarget:self action:@selector(allCanBiaoClick) forControlEvents:UIControlEventTouchUpInside];
            
            //            cell.dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //            cell.dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
            //            cell.dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
            
            return cell;
        }else{
            YPHYTHDetailCanBiaoColCell *cell = [YPHYTHDetailCanBiaoColCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.listArr = self.canbiaoMarr.copy;
            cell.colCellClick = ^(NSString * _Nonnull sectionName, NSIndexPath * _Nonnull indexPath) {
                YPHYTHDetailCanBiaoDetailController *detail = [[YPHYTHDetailCanBiaoDetailController alloc]init];
                detail.canbiaoModel = self.canbiaoMarr[indexPath.item];
                detail.dateStr = self.dateStr;
                detail.CommodityId = self.detailID;
                detail.Discount = self.infoModel.Discount;
                detail.ServiceChargeProportion = self.infoModel.ServiceChargeProportion;
                [self.navigationController pushViewController:detail animated:YES];
            };
            return cell;
        }
    }else if ([param[@"name"] isEqualToString:_homeDetailTitle]){
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *str = self.detailIMGMarr[indexPath.row];
        
        cell.imgStr = str;
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    
                    [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                }else{
                    
                }
                
            }];
        }];
        
        return cell;
    }else if ([param[@"name"] isEqualToString:_freeTitle]) {
        return [self sysCell:tableView cellForRowAtIndexPath:indexPath];
    
    }else if ([param[@"name"] isEqualToString:_serviceTitle]) {
        return [self sysCell:tableView cellForRowAtIndexPath:indexPath];
    
    }else if ([param[@"name"] isEqualToString:_sizeTitle]) {
        return [self sysSizeCell:tableView cellForRowAtIndexPath:indexPath];
    
    }else if ([param[@"name"] isEqualToString:_shopdetailTitle]) {
        
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaCell"];
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = self.infoModel.Abstract;
    
    return cell;
}

/** 免费特权 */
- (UITableViewCell *)sysCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *param = self.titleArr[indexPath.section];
    CXPassageSysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXPassageSysCell"];
   
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXPassageSysCell" owner:nil options:nil] lastObject];
    }
    
    if ([param[@"name"] isEqualToString:_freeTitle]) {
        
        switch (indexPath.row) {
            case 0: {[cell setSysCellDefaValueIsJoin:YES withName:@"订婚宴送伴手礼"];   break;}
            case 1: {[cell setSysCellDefaValueIsJoin:YES withName:@"花多少返多少"];    break;}
            case 2: {[cell setSysCellDoubleValueIsJoin:YES];  break;}
            default: break;
        }
    }else if ([param[@"name"] isEqualToString:_serviceTitle]) {
        [cell setSysCellServiceMoney:self.infoModel.ServiceCharge withDiscountCharge:self.infoModel.ServiceCharge];
    }
    
    return cell;
}

/** 宴会厅尺寸 */
- (UITableViewCell *)sysSizeCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *param = self.titleArr[indexPath.section];
    CXYHTNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXYHTNumberCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXYHTNumberCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.infoModel;
    return cell;
}

#pragma mark - - - - - - - - - - - - - - - DataSource - - - - - - - - - - - - - - - - -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSDictionary *param = self.titleArr[indexPath.section];
    if ([param[@"name"] isEqualToString:_baseInfoTitle] && indexPath.row == 1) {
        // 酒店基本信息中地址栏
        return self.infoModel.Address.length > 0 ? [self getHeighWithTitle:self.infoModel.Address font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] width:ScreenWidth-55-18]+28 : [self getHeighWithTitle:@"当前无地址" font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] width:ScreenWidth-55-18]+28;
    }
    if ([param[@"name"] isEqualToString:_homeDetailTitle]) {
        NSString *str = self.detailIMGMarr[indexPath.row];
        /** 参数1:图片URL 参数2:imageView 宽度 参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度) */
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
    }
    
    if ([param[@"name"] isEqualToString:_shopdetailTitle]) {
        return UITableViewAutomaticDimension;
    }
    return [param[@"height"][indexPath.row] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBS(245);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSDictionary *param = self.titleArr[section];
    return [param[@"sectionH"] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *param = self.titleArr[section];
    if ([param[@"name"] isEqualToString:_homeDetailTitle]) {
        return self.detailSectionView;
    }else {
        
        UILabel *sectionHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [param[@"sectionH"] floatValue])];
        sectionHead.font = kBigFont;
        sectionHead.text = [NSString stringWithFormat:@"    %@",param[@"name"]];
        sectionHead.clipsToBounds = YES;
        return sectionHead;
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *param = self.titleArr[indexPath.section];
   
    if (indexPath.section == 0 && indexPath.row == 3) {
        YPHYTHGiftImgListController *img = [[YPHYTHGiftImgListController alloc]init];
        img.imgArr = [self.infoModel.PresentDetailMap componentsSeparatedByString:@","];
        [self.navigationController pushViewController:img animated:YES];
    }
    
    if ([param[@"name"] isEqualToString:_freeTitle]) {
        switch (indexPath.row) {
            case 0: [self supericeVC]; break;
            case 1: [self payReturnVC]; break;
            default: break;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > (200 - NAVIGATION_BAR_HEIGHT*2)) {
        CGFloat alpha = (offsetY-(200 - NAVIGATION_BAR_HEIGHT*2)) / NAVIGATION_BAR_HEIGHT;
        _navView.backgroundColor = WhiteColor;
        [_backBtn setImage:[UIImage imageNamed:@"back_bold"] forState:UIControlStateNormal];
        _navView.alpha = alpha;
    }else{
        _navView.backgroundColor = ClearColor;
        [_backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
        _navView.alpha = 1.0;
    }
}

#pragma mark - 动态计算label高度
- (CGFloat )getHeighWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
    
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)phoneBtnClick{
    NSLog(@"phoneBtnClick");
    
    [self CreatePreferentialCommodityReserve];
}

- (void)submitBtnClick{
    NSLog(@"submitBtnClick");
    
    //19-02-18 立即预定 进入 全部餐标
    [self allCanBiaoClick];
    
    //    YPHYTHDetailSubmitOrderController *submit = [[YPHYTHDetailSubmitOrderController alloc]init];
    //    submit.detailID = self.detailID;
    //    NSArray *arr = [self.dateStr componentsSeparatedByString:@"-"];
    //    submit.canbiaoTime = arr[1];
    //    submit.Discount = self.infoModel.Discount;
    //    submit.ServiceChargeProportion = self.infoModel.ServiceChargeProportion;
    //    [self.navigationController pushViewController:submit animated:YES];
}

- (void)dateBtnClick{
    NSLog(@"dateBtnClick");
    
    [BRDatePickerView showDatePickerWithTitle:@"选择婚宴日期" dateType:BRDatePickerModeYM defaultSelValue:self.dateStr resultBlock:^(NSString *selectValue) {
        self.dateStr = selectValue;
        [self GetPreferentialCommodityPriceList];
    }];
}

- (void)allCanBiaoClick{
    YPHYTHDetailAllCanBiaoController *all = [[YPHYTHDetailAllCanBiaoController alloc]init];
    all.titleStr = [NSString stringWithFormat:@"%@·%@",self.infoModel.FacilitatorName,self.infoModel.Name];
    all.dateStr = self.dateStr;
    all.CommodityId = self.detailID;
    all.Discount = self.infoModel.Discount;
    all.ServiceChargeProportion = self.infoModel.ServiceChargeProportion;
    
    __weak typeof(self) WeakSelf = self;
    all.dateBlock = ^(NSString * _Nonnull dateStr) {
        WeakSelf.dateStr = dateStr;
        [WeakSelf GetPreferentialCommodityPriceList];
    };
    [self.navigationController pushViewController:all animated:YES];
}

- (void)hotelInfoBtnClick{
    return;
    NSLog(@"hotelInfoBtnClick");
    YPSupplierHomePage181119Controller *hotelVC = [YPSupplierHomePage181119Controller new];
    hotelVC.FacilitatorID = self.infoModel.FacilitatorId;
    hotelVC.profession = JiuDian_New;
    [self.navigationController pushViewController:hotelVC animated:YES];
}

- (void)contactBtnClick{
    NSLog(@"contactBtnClick");
    //联系我们 -- 19-02-21 徐
    YPContractController *contract = [[YPContractController alloc]init];
    [self.navigationController presentViewController:contract animated:YES completion:nil];
}

- (void)orderBtnClick{
    YPGetHotelBanquetlList *listModel = [[YPGetHotelBanquetlList alloc]init];
    listModel.Id = self.detailID;
    YPHomeReserveTingController *reserve = [[YPHomeReserveTingController alloc]init];
    reserve.listModel = listModel;
    reserve.type = 2;
    reserve.hotelTing = _infoModel.Name;
    [self.navigationController pushViewController:reserve animated:YES];
}

#pragma mark - - - - - - - - - - - - - - - 界面跳转 - - - - - - - - - - - - - - - - -
/** 伴手礼 */
- (void)supericeVC{
    if (!UserId_New) {
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        
        CXReceiveVC *edu = [[CXReceiveVC alloc]init];
        [self.navigationController pushViewController:edu animated:YES];
        
    }
}
/** 花多少 返多少。 */
- (void)payReturnVC{
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


#pragma mark - - - - - - - - - - - - - - - 网络请求 - - - - - - - - - - - - - - - - -
/**  获取特惠商品详情 */
- (void)GetPreferentialCommodityInfo{
    [self GetBanquetInfo];
}

#pragma mark 获取特惠商品价格列表
- (void)GetPreferentialCommodityPriceList{
    [EasyShowLodingView showLoding];
    
    //。该接口废弃 2019-10-10 王铭   NSString *url = @"/api/HQOAApi/GetPreferentialCommodityPriceList";
    NSString *url = @"/api/HQOAApi/GetBanquetMealTable";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CommodityId"] = self.detailID;
//    NSArray *arr = [self.dateStr componentsSeparatedByString:@"-"];
//    params[@"Month"] = arr[1];
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            [self.canbiaoMarr removeAllObjects];
            self.canbiaoMarr = [YPGetPreferentialCommodityPriceList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            [self.tableView reloadData];
            
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

#pragma mark 特惠商品预定
- (void)CreatePreferentialCommodityReserve{
    
    //    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/CreatePreferentialCommodityReserve";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"CommodityId"] = self.detailID;
    params[@"UserId"] = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您已成功预约，商家专席客服稍后会与您取得联系。 \n商家专席客服电话：15192055999" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        [self showNetErrorEmptyView];
        
    }];
    
}
#pragma mark 供应商信息
- (void)GetFacilitatorInfo:(NSString *)FacilitatorId{
    // 非常的无奈。此接口原本是不用写的，但是后台比较坑，你就将就着看吧。顺便说一下上面的接口也不是我写的。 这么菜的接口我醉了。
    NSString *url = @"/api/HQOAApi/GetFacilitatorInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] =FacilitatorId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            self.infoModel.Abstract = object[@"Abstract"];
            [self.tableView reloadData];
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
    
}

/** 获取服务费 */
- (void)loadServiceMoneyData:(NSString *)FacilitatorId{
    NSString *url = @"/api/HQOAApi/GetBanquetDiscountList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"FacilitatorId"] = FacilitatorId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            
            for (NSDictionary *dic in object[@"data"]) {
                
                if ([self.detailID isEqualToString:dic[@"Id"]]) {
                    
                    self.infoModel.DiscountCharge = dic[@"DiscountCharge"];
                    self.infoModel.ServiceCharge = dic[@"ServiceCharge"];
                    [self.tableView reloadData];
                    return ;
                }
            }
        }else{
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
    
}

-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialCommodityInfo];
    }];
    
}

#pragma mark - - - - - - - - - - - - - - - 懒蛋 - - - - - - - - - - - - - - - - -
- (NSMutableArray *)detailIMGMarr{
    if (!_detailIMGMarr) {
        _detailIMGMarr = [NSMutableArray array];
    }
    return _detailIMGMarr;
}

- (YPGetPreferentialCommodityInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetPreferentialCommodityInfo alloc]init];
    }
    return _infoModel;
}

- (NSMutableArray<YPGetPreferentialCommodityPriceList *> *)canbiaoMarr{
    if (!_canbiaoMarr) {
        _canbiaoMarr = [NSMutableArray array];
    }
    return _canbiaoMarr;
}

/** sectionConfige */
- (NSArray *)titleArr {
    //轮播图、免费特权、基本信息、餐标、服务费、店铺详情、酒店介绍
    // 修改注意事项 后期将名称z设置为全局变量或者属性
    // 修改此内容的注意   店铺详情  的setionH
    if (!_titleArr) {
        _titleArr = @[@{@"name":_bannerTitle,        @"number":@"3",  @"sectionH":@"0.01", @"height":@[@(ScreenWidth*0.56),@(40),@(40),@(ScreenWidth*0.13)]},
                             @{@"name":_freeTitle,              @"number":@"3",  @"sectionH":@"44",    @"height":@[@(33),@(33),@(33)]},
                             @{@"name":_baseInfoTitle,       @"number":@"2",  @"sectionH":@"0.01",  @"height":@[@(84),@(84)]},
                             @{@"name":_canbiaoTitle,        @"number":@"2",  @"sectionH":@"0.01",   @"height":@[@(34),@(100)]},
                             @{@"name":_serviceTitle,         @"number":@"1",  @"sectionH":@"44",      @"height":@[@(44)]},
                            @{@"name":_sizeTitle,                @"number":@"1",  @"sectionH":@"44",      @"height":@[@(90)]},
                             @{@"name":_homeDetailTitle,  @"number":@"1",  @"sectionH":@"52",      @"height":@[@(200)]},
                             @{@"name":_shopdetailTitle,    @"number":@"1",  @"sectionH":@"44",      @"height":@[@(200)]}];
    }
    return _titleArr;
}
/** 详情介绍 sectionHeader */
- (UIView *)detailSectionView {
    
    if (!_detailSectionView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        
        UIImageView *img1 = [[UIImageView alloc]init];
        [view addSubview:img1];
        [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.centerY.mas_equalTo(view);
        }];
        
        UIImageView *img2 = [[UIImageView alloc]init];
        [view addSubview:img2];
        [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(img1.mas_right).mas_offset(6);
            make.centerY.mas_equalTo(img1);
        }];
        img1.image = [UIImage imageNamed:@"HYTH_详情icon"];
        img2.image = [UIImage imageNamed:@"HYTH_详情"];
        _detailSectionView = view;
    }
    return _detailSectionView;
}

#pragma mark - - - - - - - - - - - - - - - 更换后的接口 - - - - - - - - - - - - - - - - -

#pragma mark 获取宴会厅详情
- (void)GetBanquetInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetHotelBanquetlInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.detailID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            //  DiscountCharge
            self.banquetModel = [HRTingModel mj_objectWithKeyValues:object];
            self.infoModel.AreaId = [object valueForKey:@"AreaId"];
            [self.infoModel getOtherModelValue:self.banquetModel];
         
            NSArray *list =  [object valueForKey:@"Data"];
            NSMutableArray *urllist = [NSMutableArray array];
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *url =  [[list objectAtIndex:idx] objectForKey:@"ImgUrl"];
                [urllist addObject:url];
                
            }];
            self.detailIMGMarr =[urllist mutableCopy];
            
            [self GetPreferentialCommodityPriceList];
            [self loadServiceMoneyData:self.infoModel.FacilitatorId];
            [self GetFacilitatorInfo:self.infoModel.FacilitatorId];
            
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

@end
