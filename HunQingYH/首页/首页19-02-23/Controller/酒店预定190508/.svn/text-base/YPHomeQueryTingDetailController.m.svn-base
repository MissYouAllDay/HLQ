//
//  YPHomeQueryTingDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHomeQueryTingDetailController.h"
#pragma mark - Cell
#import "YPPassengerDistributionBannerCell.h"
#import "YPHYTHDetailTingTitleCell.h"
#import "YPHYTHDetailInfoCell.h"
#import "YPHYTHDetailAddressCell.h"
#import "YPHYTHDetailAdCell.h"
#import "YPHYTHDetailCanBiaoDateCell.h"
#import "YPHYTHDetailCanBiaoColCell.h"
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
#pragma mark - Model
#import "YPGetPreferentialCommodityInfo.h"
#import "YPGetPreferentialCommodityPriceList.h"

@interface YPHomeQueryTingDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *detailIMGMarr;

@property (nonatomic, copy) __block NSString *dateStr;

@property (nonatomic, strong) YPGetPreferentialCommodityInfo *infoModel;

@end

@implementation YPHomeQueryTingDetailController{
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

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
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
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, ScreenWidth, ScreenHeight+STATUS_BAR_HEIGHT-56-HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
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
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-56-HOME_INDICATOR_HEIGHT, ScreenWidth,56)];
    bottomView.backgroundColor = WhiteColor;
    [self.view addSubview:bottomView];
    
    UIView *colorView1 = [[UIView alloc] init];
    [colorView1 setFrame:CGRectMake(0,0, ScreenWidth, 56)];
    [bottomView addSubview:colorView1];
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = colorView1.bounds;
    gradient1.startPoint = CGPointMake(0, 0.5);
    gradient1.endPoint = CGPointMake(1, 0.5);
    gradient1.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0].CGColor];
    [colorView1.layer addSublayer:gradient1];
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    [orderBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.frame = colorView1.frame;
    [bottomView addSubview:orderBtn];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 2;
    }else{
        return self.detailIMGMarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
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
            return cell;
        }else if (indexPath.row == 1){
            YPHYTHDetailTingTitleCell *cell = [YPHYTHDetailTingTitleCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.infoModel.Name.length > 0) {
                cell.titleLabel.text = self.infoModel.Name;
            }else{
                cell.titleLabel.text = @"无名称";
            }
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
        }
    }else if (indexPath.section == 1){
        
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
    }else{
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
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ScreenWidth*0.56;
        }else if (indexPath.row == 1 || indexPath.row == 2){
            return 40;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 84;
        }else{
            return self.infoModel.Address.length > 0 ? [self getHeighWithTitle:self.infoModel.Address font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] width:ScreenWidth-55-18]+28 : [self getHeighWithTitle:@"当前无地址" font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] width:ScreenWidth-55-18]+28;
        }
    }else{
        NSString *str = self.detailIMGMarr[indexPath.row];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
    }
    return 0;
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
    if (section == 2) {
        return 52;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
    
    //    if (section == 2) {
    //        img1.image = [UIImage imageNamed:@"HYTH_可选icon"];
    //        img2.image = [UIImage imageNamed:@"HYTH_可选"];
    //    }else
    if (section == 2){
        img1.image = [UIImage imageNamed:@"HYTH_详情icon"];
        img2.image = [UIImage imageNamed:@"HYTH_详情"];
    }else{
        return nil;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        YPHYTHGiftImgListController *img = [[YPHYTHGiftImgListController alloc]init];
        img.imgArr = [self.infoModel.PresentDetailMap componentsSeparatedByString:@","];
        [self.navigationController pushViewController:img animated:YES];
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

#pragma mark - 网络请求
#pragma mark 获取特惠商品详情
- (void)GetPreferentialCommodityInfo{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetPreferentialCommodityInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = self.detailID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.Name = [object valueForKey:@"Name"];
            self.infoModel.CoverMap = [object valueForKey:@"CoverMap"];
            self.infoModel.AreaId = [object valueForKey:@"AreaId"];
            self.infoModel.Discount = [object valueForKey:@"Discount"];
            self.infoModel.ServiceChargeProportion = [object valueForKey:@"ServiceChargeProportion"];
            self.infoModel.EarnestMoney = [[object valueForKey:@"EarnestMoney"] integerValue];
            self.infoModel.MinTable = [[object valueForKey:@"MinTable"] integerValue];
            self.infoModel.MaxTable = [[object valueForKey:@"MaxTable"] integerValue];
            self.infoModel.DetaiMap = [object valueForKey:@"DetaiMap"];
            self.infoModel.FacilitatorName = [object valueForKey:@"FacilitatorName"];
            self.infoModel.PresentBanner = [object valueForKey:@"PresentBanner"];
            self.infoModel.PresentDetailMap = [object valueForKey:@"PresentDetailMap"];
            
            self.infoModel.FacilitatorId = [object valueForKey:@"FacilitatorId"];
            self.infoModel.FacilitatorImage = [object valueForKey:@"FacilitatorImage"];
            self.infoModel.Address = [object valueForKey:@"Address"];
            self.infoModel.SalesVolume = [object valueForKey:@"SalesVolume"];
            self.infoModel.CaseInfoCount = [object valueForKey:@"CaseInfoCount"];
            self.infoModel.DynamicCount = [object valueForKey:@"DynamicCount"];
            
            self.detailIMGMarr = [[self.infoModel.DetaiMap componentsSeparatedByString:@","] mutableCopy];
            
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

-(void)showNetErrorEmptyView{
    
    [EasyShowEmptyView showEmptyViewWithTitle:@"网络错误" subTitle:@"点击重新加载数据！" imageName:@"netError.png" inview:self.tableView callback:^(EasyShowEmptyView *view, UIButton *button, callbackType callbackType) {
        [self GetPreferentialCommodityInfo];
    }];
    
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
    
    
}

- (void)hotelInfoBtnClick{
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

#pragma mark - getter
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
