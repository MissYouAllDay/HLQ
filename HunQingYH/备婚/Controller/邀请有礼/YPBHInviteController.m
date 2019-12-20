//
//  YPBHInviteController.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPBHInviteController.h"
#import "MCFlowLayout.h"
#import "HRYQPrisentCell.h"
#import "HRYaoHomeTopView.h"//邀请码部分view
#import "HRYaoHomeSecTopView.h"//领取部分view
#import "HRPhoneYQListViewController.h"//手机号邀请
#import "HRYQBeiHunViewController.h"//邀请备婚
#import "HRYQDownLoadViewController.h"//邀请下载
#import "HRYQRuleViewController.h"//活动规则
#import "HRYaoWechatView.h"//微信兑换礼物
#import "YPActivityPrizesListData.h"//礼物模型
#import "YPGetActivityInfo.h"//规则模型
#import "HRPresentXQViewController.h"//礼物详情
#import "HRWeChatDuiHuanController.h"//输入微信兑换码
//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
static NSString *const reuse0ID = @"cell";
static NSString *const reuse1ID = @"HRYQPrisentCell";
static NSString *const reuse2ID = @"cell2";
static NSString *const headID = @"headerView";
#define topHeight  150
#define secTopHeight 150
#define wechatHeight 50
@interface YPBHInviteController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    UIView *_navView;
    
    UIView *guizeBGView;
    UILabel *label;
}
@property (nonatomic, weak) UICollectionView *collectionview;
@property(nonatomic,strong)HRYaoHomeTopView *topView;
@property(nonatomic,strong)HRYaoHomeSecTopView *secTopView;
@property (nonatomic, strong) YPGetActivityInfo *rulerInfo;
@property (nonatomic, strong) HRYaoWechatView *weChatView;
@property (nonatomic, strong) NSMutableArray<YPActivityPrizesListData *> *listMarr;
@end

@implementation YPBHInviteController

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (YPGetActivityInfo *)rulerInfo{
    if (!_rulerInfo) {
        _rulerInfo = [[YPGetActivityInfo alloc]init];
    }
    return _rulerInfo;
}
- (NSMutableArray<YPActivityPrizesListData *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}
#pragma mark - UI
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
  
    [self getXQRequest];
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = MainColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回A"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"邀请有礼";
    titleLab.textColor = WhiteColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
     self.view.backgroundColor = MainColor;
}

- (void)setupUI{
   
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT) collectionViewLayout:layout];
    
    [self.view addSubview:collectionview];
    collectionview.backgroundColor = CHJ_bgColor;
    collectionview.dataSource = self;
    collectionview.delegate = self;
    collectionview.showsHorizontalScrollIndicator =NO;
    collectionview.showsVerticalScrollIndicator =NO;
    self.collectionview = collectionview;
    
    [collectionview registerClass:[HRYQPrisentCell class] forCellWithReuseIdentifier:reuse1ID];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse0ID];
        [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse2ID];
    
    // 注册头部
    [collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0||section ==1||section ==2) {
        return 1;
    }else {
        return self.listMarr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse0ID forIndexPath:indexPath];
        if (!_topView) {
            _topView =[HRYaoHomeTopView inviteView];
        }
        _topView.backgroundColor =MainColor;
        _topView.frame =CGRectMake(0, 0, ScreenWidth, topHeight);
        _topView.codeLab.text =self.rulerInfo.YQCode;
        [_topView.guiTuBtn addTarget:self action:@selector(guiZeClick) forControlEvents:UIControlEventTouchUpInside];
         [_topView.guiBtn addTarget:self action:@selector(guiZeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView.phoneTuBtn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView.phoneBtn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView.fenTuBtn addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView.fenBtn addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:_topView];
        
        cell.backgroundColor = WhiteColor;
        
        return cell;
    }else if (indexPath.section ==1){
        
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse0ID forIndexPath:indexPath];
        if (!_secTopView) {
            _secTopView =[HRYaoHomeSecTopView inviteView];
            
        }
        _secTopView.frame =CGRectMake(10, 10, ScreenWidth-20, topHeight-20);
        cell.contentView.backgroundColor =CHJ_bgColor;
        _secTopView.downLoadNum.text =[NSString stringWithFormat:@"%@人",self.rulerInfo.InvitedNumber];
        _secTopView.beihunNum.text = [NSString stringWithFormat:@"%zd人",self.rulerInfo.WeddingNumber];
        if ( [self.rulerInfo.InvitedNumber integerValue] < [self.rulerInfo.Grade[0] integerValue]) {
            [_secTopView.downLingBtn setTitle:@"不可领取" forState:UIControlStateNormal];
            [_secTopView.downLingBtn setBackgroundColor:TextNormalColor];
            _secTopView.downLingBtn.userInteractionEnabled =NO;
        }else{
            [_secTopView.downLingBtn setTitle:@"可领取" forState:UIControlStateNormal];
            [_secTopView.downLingBtn setBackgroundColor:MainColor];
            _secTopView.downLingBtn.userInteractionEnabled =YES;
            [_secTopView.downLingBtn addTarget:self action:@selector(downLoadLingClick) forControlEvents:UIControlEventTouchUpInside];
        }
    
        if (self.rulerInfo.WeddingNumber<1) {
            [_secTopView.beihunLingBtn setTitle:@"不可领取" forState:UIControlStateNormal];
            [_secTopView.beihunLingBtn setBackgroundColor:TextNormalColor];
            _secTopView.beihunLingBtn.userInteractionEnabled =NO;
        }else{
            [_secTopView.beihunLingBtn setTitle:@"可领取" forState:UIControlStateNormal];
            [_secTopView.beihunLingBtn setBackgroundColor:MainColor];
            _secTopView.beihunLingBtn.userInteractionEnabled =YES;
            [_secTopView.beihunLingBtn addTarget:self action:@selector(beiHunLingClick) forControlEvents:UIControlEventTouchUpInside];
        }

        [cell.contentView addSubview:_secTopView];
        cell.backgroundColor =CHJ_bgColor;
        
        return cell;
    }else if(indexPath.section==2){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse0ID forIndexPath:indexPath];
        if (!_weChatView) {
            _weChatView =[HRYaoWechatView inviteView];
            
        }
        _weChatView.frame =CGRectMake(10, 10, ScreenWidth-20, wechatHeight);
        [_weChatView.cleanBtn addTarget:self action:@selector(weChatClick) forControlEvents:UIControlEventTouchUpInside];
        cell.contentView.backgroundColor =CHJ_bgColor;
        [cell.contentView addSubview:_weChatView];
        cell.backgroundColor =CHJ_bgColor;
        
        return cell;
    }else {
        
        
        
        YPActivityPrizesListData *data = self.listMarr[indexPath.row];
      
        HRYQPrisentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse1ID forIndexPath:indexPath];
        cell.backgroundColor = WhiteColor;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.ShowImg] placeholderImage:[UIImage imageNamed:@"头"]];
        if (data.CommodityName.length > 0) {
            cell.nameLab.text = data.CommodityName;
        }else{
            cell.nameLab.text = @"无名称";
        }
        if (data.Country.length > 0) {
            cell.desLab.text = data.Country;
        }else{
            cell.desLab.text = @"无产地";
        }
        if (data.MarketPrice.length > 0) {
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",data.MarketPrice];
        }else{
            cell.priceLabel.text = @"¥0";
        }
        return cell;
    }
    
    
    
}
//机会选中消息
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}
//选中消息处理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
      
        YPActivityPrizesListData *data = self.listMarr[indexPath.row];
        
        NSLog(@"%zd,%zd",(long)indexPath.section, indexPath.item);
        HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
        xqvc.activityPrizesID = data.ActivityPrizesID;
        [self.navigationController pushViewController:xqvc animated:YES];
    }else{
        
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return (CGSize){ScreenWidth, topHeight };
    }else if (indexPath.section ==1){
        return (CGSize){ScreenWidth, secTopHeight };
    }else if (indexPath.section ==2){
        return (CGSize){ScreenWidth, wechatHeight+20 };
    }
    else
    {
        return (CGSize){ScreenWidth/2, ScreenWidth/2+70};
        
    }
}

-  (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   
        return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 3) {
          return CGSizeMake(ScreenWidth, 30);
        
    }else{
      return CGSizeMake(ScreenWidth, 0.1);
    }
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(ScreenWidth, 0.1);
//}

#pragma mark 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头部视图 (因为这里的kind 有头部和尾部所以需要判断  默认是头部,严谨判断比较好)
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID forIndexPath:indexPath];
        headerView.backgroundColor = WhiteColor;
        
        for (UIView *view in headerView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.section == 0||indexPath.section==1||indexPath.section==2) {
            NSLog(@"section  -- %zd",indexPath.section);
        }else{
            
            
            //            if (!label) {
            label = [[UILabel alloc]init];
            
            label.text =@"奖品列表";
            label.textColor = BlackColor;
            [headerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(headerView);
            }];
        }
        return headerView;
        
    }else {
        return nil;
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
-(void)weChatClick{
    HRWeChatDuiHuanController *wechatVC = [HRWeChatDuiHuanController new];
    [self.navigationController pushViewController:wechatVC animated:YES];
}
-(void)guiZeClick{
    HRYQRuleViewController *ruleVC = [HRYQRuleViewController new];
    ruleVC.ActivityIDs =self.rulerInfo.ActivityID;
    [self.navigationController pushViewController:ruleVC  animated:YES];
}
-(void)phoneClick{
  
    HRPhoneYQListViewController *phoneListVC = [HRPhoneYQListViewController new];
    [self.navigationController pushViewController:phoneListVC animated:YES];
}
-(void)fenxiangClick{
    [self showShareSDK];
}
-(void)downLoadLingClick{
    HRYQDownLoadViewController *downVC = [HRYQDownLoadViewController new];
    downVC.InvitedNumber =self.rulerInfo.InvitedNumber;
    downVC.ActivityID =self.rulerInfo.ActivityID;
    downVC.grades =self.rulerInfo.Grade;
    downVC.endTime =self.rulerInfo.EndTime;
    [self.navigationController pushViewController:downVC animated:YES];
}
-(void)beiHunLingClick{
    HRYQBeiHunViewController *beiVC = [HRYQBeiHunViewController new];
    [self.navigationController pushViewController:beiVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------网络请求-------------
//查看活动详情
- (void)getXQRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetActivityInfo";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"ObjectTypes"]   = @1;
    params[@"ObjectID"] =UserId_New;
  
    
    NSLog(@"%@",params);
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"详情%@",object);
            self.rulerInfo.YQCode =[object objectForKey:@"YQCode"];
            self.rulerInfo.InvitedNumber = [object valueForKey:@"InvitedNumber"];
//            self.rulerInfo.InvitedNumber  =@"50";
            self.rulerInfo.WeddingNumber =[[object valueForKey:@"WeddingNumber"]integerValue];
//           self.rulerInfo.WeddingNumber =5;
            self.rulerInfo.ActivityID = [object valueForKey:@"ActivityID"];
            self.rulerInfo.Title = [object valueForKey:@"Title"];
            self.rulerInfo.Content = [object valueForKey:@"Content"];
            self.rulerInfo.StartTime = [object valueForKey:@"StartTime"];
            self.rulerInfo.EndTime = [object valueForKey:@"EndTime"];
            self.rulerInfo.Rule = [object objectForKey:@"Rule"];
            self.rulerInfo.Grade = [object objectForKey:@"Grade"];
            self.rulerInfo.CreateTime = [object valueForKey:@"CreateTime"];
            self.rulerInfo.ObjectTypes = [object valueForKey:@"ObjectTypes"];

            [self getPresetListRequest];
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

//查看活动奖品列表
- (void)getPresetListRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetActivityPrizesList";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"PageIndex"]   = @"1";
    params[@"PageCount"] =@"10000000";
    
    
  
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"奖品列表%@",object);
            self.listMarr = [YPActivityPrizesListData mj_objectArrayWithKeyValuesArray:[object objectForKey:@"Data"]];
            [self setupUI];
            [self.collectionview reloadData];
            
         
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


#pragma mark - shareSDK
- (void)showShareSDK{
    
    //10-30 -- shareSDK
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"分享图标"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSString *str = @"http://www.chenghunji.com/Download/Index";
        //        @"https://itunes.apple.com/cn/app/%E6%88%90%E5%A9%9A%E7%BA%AA-%E5%A9%9A%E7%A4%BC%E5%8A%A9%E6%89%8B/id1289565288?mt=8";
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"邀请码:%@", self.rulerInfo.YQCode]
                                         images:imageArray
                                            url:[NSURL URLWithString:str]
                                          title:@"婚礼桥--婚礼原来如此简单"
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
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
                               
                               [EasyShowTextView showSuccessText:@"分享成功"];
                               
                               break;
                           }
                           case SSDKResponseStateCancel:
                               
                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:@"取消分享"
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"确定"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show] ;

                               [EasyShowTextView showText:@"取消分享"];
                          
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"确定"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show] ;

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

@end
