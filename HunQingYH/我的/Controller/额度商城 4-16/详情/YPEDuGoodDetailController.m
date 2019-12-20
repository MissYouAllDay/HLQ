//
//  YPEDuGoodDetailController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/17.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuGoodDetailController.h"
#import <SDCycleScrollView.h>
#import "YPEDuDetailTitleCell.h"
#import "YPEDuDetailDescCell.h"
#import "YPEDuShoppingCartController.h"//购物车
#import "YPGetCommodityInfo.h"//模型
#import "DemoVC1Cell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
//规格
#import "HRGuiGeModel.h"
#import "ChoseGoodsTypeAlert.h"
#import "SizeAttributeModel.h"
#import "GoodsTypeModel.h"
#import "Header.h"
#import "HRCartModel.h"
static NSString *const cellId = @"DemoVC1Cell";

@interface YPEDuGoodDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SDCycleScrollView *banner;

@property (nonatomic, strong) YPGetCommodityInfo *infoModel;
@property (nonatomic, strong) NSArray *infoImgArr;
/**规格数组*/
@property(nonatomic,strong)NSMutableArray  *guiGeArr;

/**购物车商品数量*/
@property (nonatomic, assign) NSInteger CarCount;
@end

@implementation YPEDuGoodDetailController{
    UIView *_navView;
    UIButton *shopCarBtn;
    GoodsModel *model;//商品模型
}


#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetCommodityInfo];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WhiteColor;
    
    [self setupNav];
 
    [self setupUI];
   
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = YES;
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    //设置导航栏左边通知
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
    titleLab.text = @"商品详情";
    titleLab.textColor = BlackColor;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
    
    if (self.willShowCart) {//显示购物车
        shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shopCarBtn  setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
        
        [shopCarBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:shopCarBtn];
        [shopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_navView).mas_offset(-15);
            make.centerY.mas_equalTo(backBtn.mas_centerY);
        }];
    }

}

- (void)setupUI{
    
    if (self.willShowCart) {//显示购物车
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1-50) style:UITableViewStyleGrouped];
    }else{//不显示购物车
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+1, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-1) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    
    if (self.willShowCart) {//显示购物车
        UIButton *tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tipBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [tipBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [tipBtn setBackgroundColor:[UIColor redColor]];
        [tipBtn addTarget:self action:@selector(addShopCarClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tipBtn];
        [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2 + self.infoImgArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        YPEDuDetailTitleCell *cell = [YPEDuDetailTitleCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.infoModel.CommodityName.length > 0) {
            cell.titleLabel.text = self.infoModel.CommodityName;
        }else{
            cell.titleLabel.text = @"无名称";
        }
        
        cell.priceLabel.text = [NSString stringWithFormat:@"%zd",self.infoModel.Quota];
        
        if (self.infoModel.PlaceOrigin.length > 0) {
            cell.placeLabel.text = [NSString stringWithFormat:@"产地: %@",self.infoModel.PlaceOrigin];
        }else{
            cell.placeLabel.text = @"无产地";
        }
        return cell;
    }else if (indexPath.row == 1){
        YPEDuDetailDescCell *cell = [YPEDuDetailDescCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
     
        DemoVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            cell = [[DemoVC1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        NSString *str = self.infoImgArr[indexPath.row - 2];
        
        cell.imgStr = str;
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]  placeholderImage:[UIImage imageNamed:@"图片占位图"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result && (self.isViewLoaded && self.view.window))  {
                    NSLog(@"屏幕上");
                    [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                }else{
                    NSLog(@"不在当前屏幕上");
                }
                
            }];
        }];
        
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 85;
    }else if (indexPath.row == 1){
        return 50;
    }else{
        
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        NSString *str = self.infoImgArr[indexPath.row - 2];
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width-16 estimateHeight:200];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return ScreenWidth;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        [view addSubview:self.banner];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick{
    NSLog(@"购物车");
    
    YPEDuShoppingCartController *shop = [[YPEDuShoppingCartController alloc]init];
    shop.ActivityIdType = self.ActivityIdType;
    [self.navigationController pushViewController:shop animated:YES];
}
-(void)addShopCarClick{
    //加入购物车
    
    ChoseGoodsTypeAlert *_alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) andHeight:kSize (450)];
    _alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_alert];
    
    _alert.selectSize = ^(SizeAttributeModel *sizeModel) {
        //sizeModel 选择的属性模型
      
//        [JXUIKit showSuccessWithStatus:[NSString stringWithFormat:@"选择了：%@",sizeModel.value]];

        [self addShoppingCarwithID:sizeModel.goodsNo withNum:sizeModel.count];

    };
    [_alert initData:model];
    [_alert showView];
}

#pragma mark - 网络请求
#pragma mark 获取商品详情
- (void)GetCommodityInfo{
    
    [EasyShowLodingView showLoding];
  
    NSString *url = @"/api/HQOAApi/GetCommodityInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"Id"] = self.commodityId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.infoModel.CommodityId          = [object valueForKey:@"CommodityId"];
            self.infoModel.CommodityName        = [object valueForKey:@"CommodityName"];
            self.infoModel.PlaceOrigin          = [object valueForKey:@"PlaceOrigin"];
            self.infoModel.Quota                = [[object valueForKey:@"Quota"] integerValue];
            self.infoModel.CoverMap             = [object valueForKey:@"CoverMap"];
            self.infoModel.CarouselFigure       = [object valueForKey:@"CarouselFigure"];
            self.infoModel.OffShelf             = [object valueForKey:@"OffShelf"];
            self.infoModel.BriefIntroduction    = [object valueForKey:@"BriefIntroduction"];
            
//            self.infoModel.BriefIntroduction = @"http://121.42.156.151:96/2/1/100000/2/3/2cd4313e-23f6-4fb6-8312-0c2e177cb88b.jpg,http://121.42.156.151:96/2/1/100000/1758/4/01a670a8-ebbe-4d61-a5c4-92637762ef59.jpg,http://121.42.156.151:96/2/1/100000/1758/4/4dc8d58b-b077-4092-aee1-042ef810d9b8.jpg,http://121.42.156.151:96/2/1/100000/1758/4/83498b6b-b387-4721-b0ae-e3f3e4c71a47.jpg,http://121.42.156.151:96/2/1/100000/1758/4/f007c790-17f5-484e-9ac5-d492d17e6552.jpg";
            
            self.infoImgArr = [self.infoModel.BriefIntroduction componentsSeparatedByString:@","];
            
            [self.tableView reloadData];
            [self GetXingHao];

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

//获取型号列表
- (void)GetXingHao{
    
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/GetSpecificationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"CommodityId"] = self.commodityId;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            
            NSLog(@"型号列表：%@",object);
            
            self.guiGeArr = [HRGuiGeModel mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            
            
            //=====================初始化型号数据
  
            model = [[GoodsModel alloc] init];
            model.imageId = self.infoModel.BriefIntroduction;
            model.goodsNo = self.infoModel.CommodityName;
            //商品标题
            model.title = @"";
            model.totalStock = @"";
            //价格信息
            model.price = [[GoodsPriceModel alloc] init];
            model.price.minPrice = @"0";
            model.price.maxPrice = @"0";
            model.price.minOriginalPrice = @"0";
            model.price.maxOriginalPrice = @"0";
            
            
            //属性-应该从服务器获取属性列表
            GoodsTypeModel *type = [[GoodsTypeModel alloc] init];
            type.selectIndex = -1;
            type.typeName = @"尺码";
            NSMutableArray *chimaArr = [NSMutableArray array];
            [chimaArr removeAllObjects];
            for (HRGuiGeModel  *model in self.guiGeArr) {
                [chimaArr addObject:model.Name];
            }
            type.typeArray = [NSArray arrayWithArray:chimaArr];
            
            
            
            
            //    GoodsTypeModel *type2 = [[GoodsTypeModel alloc] init];
            //    type2.selectIndex = -1;
            //    type2.typeName = @"颜色";
            //    type2.typeArray = @[@"黑色",@"白色",@"黑色",@"白色",@"黑色",@"白色",@"黑色"];
            
            //    GoodsTypeModel *type3 = [[GoodsTypeModel alloc] init];
            //    type3.selectIndex = -1;
            //    type3.typeName = @"日期";
            //    type3.typeArray = @[@"2016",@"2017",@"2018"];
            model.itemsList = @[type];
            
            //属性组合数组-有时候不同的属性组合价格库存都会有差异，选择完之后要对应修改商品的价格、库存图片等信息，可能是获得商品信息时将属性数组一并返回，也可能属性选择后再请求服务器获得属性组合对应的商品信息，根据自己的实际情况调整
            
           
            
            model.sizeAttribute = [[NSMutableArray alloc] init];
            
//            NSArray *valueArr = @[@"XL",@"XXL"];
          
            for (int i = 0; i<chimaArr.count; i++) {
                
               HRGuiGeModel *model2= _guiGeArr[i];
                SizeAttributeModel *type = [[SizeAttributeModel alloc] init];
                type.price = [NSString stringWithFormat:@"%zd",self.infoModel.Quota];
                //        type.originalPrice = @"158";
                type.Number = model2.Number;
                type.goodsNo = model2.Id;
                type.value = chimaArr[i];
                type.imageId =self.infoModel.BriefIntroduction;
                [model.sizeAttribute addObject:type];
            }
            
            
            
            
            [self GetshangpinList];
            
            
            
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
//添加商品到购物车
-(void)addShoppingCarwithID:(NSString*)XingId withNum:(NSString *)number{
    [EasyShowLodingView showLoding];
    
    NSString *url = @"/api/HQOAApi/AddcommodityToShoppingCart";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] = UserId_New;
    params[@"CommodityId"] = self.commodityId;//商品Id
    params[@"PlaceOriginId"] = XingId;//型号ID  18-08-09 无型号传0
    params[@"Count"] = number;
    //18-09-17
    if (self.ActivityIdType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_banShouLi;
    }else if (self.ActivityIdType.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_hunLiFanHuan;
    }else if (self.ActivityIdType.integerValue == 2) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_daiShou;
    }
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            [EasyShowTextView showSuccessText:@"加入购物车成功"];
            [self  GetshangpinList];
            
            
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

//获取购物车商品列表
- (void)GetshangpinList{
    

    
    NSString *url = @"/api/HQOAApi/GetShoppingCartList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"] =UserId_New;
    
    params[@"Type"] = @"2";//类型 传数字2 18-08-09 添加
    
    //18-09-17
    if (self.ActivityIdType.integerValue == 0) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_banShouLi;
    }else if (self.ActivityIdType.integerValue == 1) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_hunLiFanHuan;
    }else if (self.ActivityIdType.integerValue == 3) {//0伴手礼,1婚礼返还,2代收
        params[@"ActivityId"] = act_daiShou;
    }

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
          
         
            
            self.CarCount  =[[object objectForKey:@"TotalCount"]integerValue];
            
            [shopCarBtn  yee_MakeBadgeText:[NSString stringWithFormat:@"%zd",self.CarCount] textColor:[UIColor whiteColor] backColor:[UIColor redColor] Font:[UIFont systemFontOfSize:12]];
            
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


#pragma mark - getter
- (SDCycleScrollView *)banner{

    NSArray *arr = [self.infoModel.CarouselFigure componentsSeparatedByString:@","];
    if (!_banner) {

        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) imageURLStringsGroup:arr];//高 125  2-9 修改 宽:高=2:1 5-22 修改1:1
        _banner.currentPageDotColor = NavBarColor;
        _banner.pageDotColor = WhiteColor;
    }
    _banner.imageURLStringsGroup = arr;
    return _banner;
}

- (YPGetCommodityInfo *)infoModel{
    if (!_infoModel) {
        _infoModel = [[YPGetCommodityInfo alloc]init];
    }
    return _infoModel;
}

- (NSArray *)infoImgArr{
    if (!_infoImgArr) {
        _infoImgArr = [[NSArray alloc]init];
    }
    return _infoImgArr;
}
-(NSMutableArray *)guiGeArr{
    if (!_guiGeArr) {
        _guiGeArr =[NSMutableArray array];
    }
    return _guiGeArr;
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
