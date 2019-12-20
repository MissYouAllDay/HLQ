//
//  YPHunJiaJieController.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHunJiaJieController.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import <HMSegmentedControl.h>
#import "YPHunJJHeadCell.h"
#import "YPHunJJSupplierListCell.h"
#import "YPHunJJSuoPiaoCell.h"
#import "YPHunJJSponsorImgCell.h"
#import "YPGetActivityAreaList.h"
#import "YPGetActivitySponsor.h"
#import "YPGetExhibitorInformationList.h"
#import "WXApi.h" //微信支付
#import "DataMD5.h" //修改商户秘钥
//参展商查看详情
#import "YPWedPackageDetailWuLiaoController.h"
//我的门票
#import "YPHunJJMyTicketController.h"

@interface YPHunJiaJieController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HMSegmentedControl *segment;

///地区数组
@property (nonatomic, strong) NSMutableArray<YPGetActivityAreaList *> *listMarr;
///图片数组
@property (nonatomic, strong) NSMutableArray *imgMarr;
///7-9 修改 末尾图片数组
@property (nonatomic, strong) NSMutableArray *endImgMarr;
///主办方
@property (nonatomic, strong) YPGetActivitySponsor *sponsorModel;
///参展商
@property (nonatomic, strong) NSMutableArray<YPGetExhibitorInformationList *> *exhibitorMarr;

//微信支付
@property(nonatomic,copy)NSString *TransNumber;//支付中转号
@property(nonatomic,copy)NSString *PayAmount;//支付金额
@end

@implementation YPHunJiaJieController{
    UIView *_navView;
    __block BOOL _isFirstIN;//YES:第一次 NO:不是
    __block NSString *_activityID;//活动ID
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetActivityAreaList];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFirstIN = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CHJ_bgColor;
    
    [self setupUI];
//    [self setupNav];
}

- (void)setupNav{
    
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
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"设置";
//    titleLab.textColor = BlackColor;
//    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
}

- (void)setupUI{
    self.view.backgroundColor = CHJ_bgColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB(255, 217, 220);
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    //设置导航栏左边通知
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.imgMarr.count;
    }else if (section == 1) {
        return self.exhibitorMarr.count + 1;
    }else if (section == 2) {
        return 1;
    }else{
        return self.endImgMarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            UIButton *menpiao = [UIButton buttonWithType:UIButtonTypeCustom];
            [menpiao setImage:[UIImage imageNamed:@"我的门票"] forState:UIControlStateNormal];
            [menpiao addTarget:self action:@selector(menpiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:menpiao];
            [menpiao mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(20);
                make.right.mas_equalTo(-15);
            }];
        }
        
        NSDictionary *dict = self.imgMarr[indexPath.row];
        
        NSString *str = dict[@"img"];

        cell.imgStr =str;

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
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.contentView addSubview:self.segment];
            
            __weak typeof(self) weakSelf = self;
            
            self.segment.indexChangeBlock = ^(NSInteger index) {
                NSLog(@"hmsegment --- %zd",index);
                
                if (_isFirstIN) {
                    if (weakSelf.listMarr.count > 0) {
                        YPGetActivityAreaList *list = weakSelf.listMarr[0];//列表1-ID
                        _activityID = list.Id;
                        [weakSelf GetExhibitorInformationListWithID:list.Id];
                    }
                    _isFirstIN = NO;
                }else{
                    YPGetActivityAreaList *list = weakSelf.listMarr[index];
                    _activityID = list.Id;
                    [weakSelf GetExhibitorInformationListWithID:list.Id];
                }
            };
            [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(cell.contentView);
            }];
            
            return cell;
            
        }else{
            
            YPGetExhibitorInformationList *exModel = self.exhibitorMarr[indexPath.row - 1];
            
            YPHunJJSupplierListCell *cell = [YPHunJJSupplierListCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.iconImgV sd_setImageWithURL:[NSURL URLWithString:exModel.ExhibitorLogo] placeholderImage:[UIImage imageNamed:@"图片占位"]];
            if (exModel.ExhibitorName.length > 0) {
                cell.titleLabel.text = exModel.ExhibitorName;
            }else{
                cell.titleLabel.text = @"无名称";
            }
            if (exModel.WeddingClass.length > 0) {
                cell.tagLabel.text = [NSString stringWithFormat:@"  %@  ",exModel.WeddingClass];
            }else{
                cell.tagLabel.text = @"  无类别  ";
            }
            
            __weak typeof(self) weakSelf = self;
            
            cell.detailBtnBlock = ^{
                
                YPWedPackageDetailWuLiaoController *detail  = [[YPWedPackageDetailWuLiaoController alloc]init];
                detail.contentStr = exModel.ExhibitorInfo;
                [weakSelf presentViewController:detail animated:YES completion:nil];
                
            };
            
            return cell;
            
        }
    }else if (indexPath.section == 2) {
        
        YPHunJJSuoPiaoCell *cell = [YPHunJJSuoPiaoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.desc1.text = [NSString stringWithFormat:@"前往各地主办方购买%@元门票",self.sponsorModel.SponsorPrice];
        cell.desc2.text = [NSString stringWithFormat:@"通过婚礼桥, 订购%@元优惠门票, 并在现场领取由婚礼桥送出的价值2580元国际品牌豪礼。",self.sponsorModel.TicketPrice];
        cell.ticketPrice.text = [NSString stringWithFormat:@"%@",self.sponsorModel.TicketPrice ];
        
        [cell.lookSponsorBtn addTarget:self action:@selector(lookSponsorBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.ticketBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        YPHunJJSponsorImgCell *cell = [YPHunJJSponsorImgCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *dict = self.endImgMarr[indexPath.row];
        
        NSString *str = dict[@"img"];
        
        cell.imgStr =str;
        
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

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSDictionary *dict = self.imgMarr[indexPath.row];
        NSString *str = dict[@"img"];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 45;
        }else{
            return 250;
        }
    }else if (indexPath.section == 2){
        return 310;
    }else{

        NSDictionary *dict = self.endImgMarr[indexPath.row];
        NSString *str = dict[@"img"];
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:str] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - target
- (void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)menpiaoBtnClick{
    NSLog(@"我的门票");
    if (!UserId_New) {
        
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        YPHunJJMyTicketController *ticket = [[YPHunJJMyTicketController alloc]init];
        [self.navigationController pushViewController:ticket animated:YES];
    }
   
}

-(void)buyClick{
 
    if (!UserId_New) {
        
        YPReLoginController *first = [[YPReLoginController alloc]init];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        [self presentViewController:firstNav animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"使用微信支付购买门票？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag =1000;
        [alertView show];
    }


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 1 && alertView.tag == 1000) {
        
        [self paymentFirstRequest];
       
    }
    
}

- (void)lookSponsorBtnClick{
    
    YPWedPackageDetailWuLiaoController *detail  = [[YPWedPackageDetailWuLiaoController alloc]init];
    detail.contentStr = self.sponsorModel.SponsorInfo;
    [self presentViewController:detail animated:YES completion:nil];
    
}

#pragma mark - getter
- (HMSegmentedControl *)segment{
    if (!_segment) {
        _segment = [[HMSegmentedControl alloc]initWithSectionTitles:@[]];
        _segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segment.titleTextAttributes = @{NSForegroundColorAttributeName:BlackColor,NSFontAttributeName:[UIFont systemFontOfSize:17]};
        _segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:NavBarColor,NSFontAttributeName:[UIFont systemFontOfSize:17]};
    }
    return _segment;
}

- (NSMutableArray<YPGetActivityAreaList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (NSMutableArray *)imgMarr{
    if (!_imgMarr) {
        _imgMarr = [NSMutableArray array];
    }
    return _imgMarr;
}

- (NSMutableArray *)endImgMarr{
    if (!_endImgMarr) {
        _endImgMarr = [NSMutableArray array];
    }
    return _endImgMarr;
}

- (YPGetActivitySponsor *)sponsorModel{
    if (!_sponsorModel) {
        _sponsorModel = [[YPGetActivitySponsor alloc]init];
    }
    return _sponsorModel;
}

- (NSMutableArray<YPGetExhibitorInformationList *> *)exhibitorMarr{
    if (!_exhibitorMarr) {
        _exhibitorMarr = [NSMutableArray array];
    }
    return _exhibitorMarr;
}

#pragma mark - 网络请求
#pragma mark 获取活动地区
- (void)GetActivityAreaList{
    
    NSString *url = @"/api/HQOAApi/GetActivityAreaList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"state"] = @"1";//状态(0所有,1未举办)
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.listMarr = [YPGetActivityAreaList mj_objectArrayWithKeyValuesArray:object[@"Data"]];
            self.imgMarr = [object objectForKey:@"ImgData"];
            
            // 7-9 修改
            self.endImgMarr = [object objectForKey:@"EndImgData"];
            
//            self.endImgMarr = @[@{@"img":@"http://121.42.156.151:96/2/1/100000/2/0/5f3b5fbe-5858-4d66-8f2e-f2117220e404.png"},@{@"img":@"http://121.42.156.151:96/2/1/100000/2/0/5f3b5fbe-5858-4d66-8f2e-f2117220e404.png"}].mutableCopy;
            
            NSMutableArray *marr = [NSMutableArray array];
            for (YPGetActivityAreaList *list in self.listMarr) {
                [marr addObject:list.Name];
            }
            self.segment.sectionTitles = marr.copy;
            
            if (_isFirstIN) {
                if (self.listMarr.count > 0) {
                    YPGetActivityAreaList *list = self.listMarr[0];//列表1-ID
                    _activityID = list.Id;
                    [self GetExhibitorInformationListWithID:list.Id];
                    _isFirstIN = NO;
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

#pragma mark 根据地区寻找主办方
- (void)GetActivitySponsorWithID:(NSString *)ID{
    
    NSString *url = @"/api/HQOAApi/GetActivitySponsor";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = ID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.sponsorModel.SponsorLogo = [object valueForKey:@"SponsorLogo"];
            self.sponsorModel.SponsorName = [object valueForKey:@"SponsorName"];
            self.sponsorModel.SponsorInfo = [object valueForKey:@"SponsorInfo"];
            self.sponsorModel.TicketPrice = [object valueForKey:@"TicketPrice"];
            self.sponsorModel.SponsorPrice = [object valueForKey:@"SponsorPrice"];
            
            [self.tableView reloadData];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}

#pragma mark 根据活动Id查找参展商列表
- (void)GetExhibitorInformationListWithID:(NSString *)ID{
    
    NSString *url = @"/api/HQOAApi/GetExhibitorInformationList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Id"] = ID;
    params[@"PageIndex"] = @"1";
    params[@"PageCount"] = @"30";

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.exhibitorMarr = [YPGetExhibitorInformationList mj_objectArrayWithKeyValuesArray:object[@"Data"]];

            [self GetActivitySponsorWithID:ID];
            
        }else{
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
        }
        
    } Failure:^(NSError *error) {
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
    }];
}
#pragma mark 支付
- (void)paymentFirstRequest{
    
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/Payment";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"UserId"]  = UserId_New;
    params[@"PayType"]  = @"0";//0微信  1支付宝
    params[@"ObjectType"]  =@"1" ;//婚假采购节
    params[@"ObjectId"]  =_activityID ;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            NSLog(@"微信中转参数：%@",object);
            self.TransNumber =[object objectForKey:@"TransNumber"];
            self.PayAmount =[object objectForKey:@"PayAmount"];
            [self weiPayregisterRequest];
            
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
- (void)weiPayregisterRequest{

    NSString *url = @"/api/HQOAApi/WeChatAppPay";
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"TransNumber"] =self.TransNumber;

    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {

        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {

 
            NSLog(@"微信支付返回参数：%@",object);


            //判断是否安装微信
            if([WXApi isWXAppInstalled]) {
                // 监听一个通知
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
            }
            //配置调起微信支付所需要的参数
            PayReq *req  = [[PayReq alloc] init];
            req.partnerId = [object objectForKey:@"partnerid"];
            req.prepayId = [object objectForKey:@"prepayid"];
            req.package = @"Sign=WXPay";
            req.nonceStr = [object objectForKey:@"noncestr"];
            req.timeStamp = [[object objectForKey:@"timestamp"]intValue];
            DataMD5 *md5 = [[DataMD5 alloc] init];
            req.sign=[md5 createMD5SingForPay:[object objectForKey:@"appid"] partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
            //调起微信支付
            if ([WXApi sendReq:req]) {
                NSLog(@"调起微信支付成功");

            }else{
                NSLog(@"调起微信支付失败");

            }


        }else{


        }


    } Failure:^(NSError *error) {

        NSLog(@"failure -- %@",error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络请求失败" message:@"请重试" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
    
    
    
    if ([notification.object isEqualToString:@"success"]) {
        

        [EasyShowTextView showSuccessText:@"支付成功"];
        [self performSelector:@selector(menpiaoBtnClick) withObject:self afterDelay:1.0];
    
    } else {
        

        [EasyShowTextView showErrorText:@"支付失败"];
     
        
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
