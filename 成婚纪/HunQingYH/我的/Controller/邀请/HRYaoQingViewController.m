//
//  HRYaoQingViewController.m
//  hunqing
//
//  Created by DiKai on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "HRYaoQingViewController.h"
#import "MCFlowLayout.h"
#import "HRYQPrisentCell.h"
#import "YPDetailRulerController.h"//详细规则
#import "YPReceiveGiftListController.h"//领取礼品

#import "HRPresentXQViewController.h"
#import "YPMyGiftRulerView.h"
#import "YPYaoQingHeaderView.h"

#import "YPGetActivityInfo.h"//规则模型
//#import "YPGetActivityPrizesList.h"
#import "YPActivityPrizesList.h"//礼品模型

//10-31 添加 -- shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

static NSString *const reuse0ID = @"cell";
static NSString *const reuse1ID = @"HRYQPrisentCell";
static NSString *const headID = @"headerView";

@interface HRYaoQingViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    UIView *_navView;
}
@property (nonatomic, weak) UICollectionView *collectionview;

@property (nonatomic, copy) NSString *count;//邀请人数
@property (nonatomic, copy) NSString *inviteCode;//邀请码

//@property (nonatomic, strong) NSMutableArray<YPGetActivityPrizesList *> *listMarr;
@property (nonatomic, strong) NSMutableArray<YPActivityPrizesList *> *listMarr;
@property (nonatomic, strong) YPGetActivityInfo *rulerInfo;

@end

@implementation HRYaoQingViewController{
    UIView *header;
    YPYaoQingHeaderView *inviteView;
    UIView *guizeBGView;
    YPMyGiftRulerView *rulerView;
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self  createUI];
    [self creatBottomView];
}
- (void)createNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = NavBarColor;
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
    
    //规则
    UIButton *guizeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [guizeBtn setTitle:@"详细规则" forState:UIControlStateNormal];
    guizeBtn.titleLabel.font =kFont(15);
    [guizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    guizeBtn.backgroundColor = NavBarColor;
    [guizeBtn addTarget:self action:@selector(xiangxiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:guizeBtn];
    [guizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.right.mas_equalTo(_navView).mas_offset(-15);
         make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
}
-(void)createUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) collectionViewLayout:layout];
    
    [self.view addSubview:collectionview];
    collectionview.backgroundColor = CHJ_bgColor;
    collectionview.dataSource = self;
    collectionview.delegate = self;
    self.collectionview = collectionview;
    
    [collectionview registerClass:[HRYQPrisentCell class] forCellWithReuseIdentifier:reuse1ID];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse0ID];
    
    // 注册头部
    [collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];

}
-(void)creatBottomView{
    UIView *bottomView= [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionview.frame),ScreenWidth, 50)];
    bottomView.backgroundColor =CHJ_bgColor;
    
    UIButton *lingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lingBtn.frame =CGRectMake(0, 0, ScreenWidth, 50);
    lingBtn.backgroundColor = NavBarColor;
    [lingBtn setTitle:@"领取我的奖品" forState:UIControlStateNormal];
    [lingBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [lingBtn addTarget:self action:@selector(lingquClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:lingBtn];
    
    
    [self.view addSubview:bottomView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1+self.listMarr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        YPActivityPrizesList *list = self.listMarr[section-1];
        return list.Data.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse0ID forIndexPath:indexPath];
        if (!header) {
            header = [[UIView alloc]init];
        }
        header.backgroundColor =CHJ_bgColor;
        
        header.frame = CGRectMake(0, 0, ScreenWidth, 50 + [self getHeighWithTitle:self.rulerInfo.Title font:[UIFont systemFontOfSize:17.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:self.rulerInfo.Content font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:@"活动时间:" font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] +25+15+10+10 + 10 + 50 + 10 + 30);
        
//        UIView *topNumView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//        topNumView.backgroundColor =MainColor;
//
//        [header addSubview:topNumView];
//
//        UILabel *BangLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, 20)];
//        BangLab.text =@"成功绑定";
//        BangLab.textColor =WhiteColor;
//        BangLab.textAlignment =NSTextAlignmentCenter;
//        [topNumView addSubview:BangLab];
//
//        UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, 15)];
//        numLab.text = [NSString stringWithFormat:@"%@人",self.count];
//        numLab.textColor =WhiteColor;
//        numLab.textAlignment =NSTextAlignmentCenter;
//        [topNumView addSubview:numLab];

        if (!inviteView) {
            inviteView = [YPYaoQingHeaderView inviteHeaderView];
        }
        inviteView.frame = CGRectMake(0, 0, ScreenWidth, 80);
        inviteView.backgroundColor = NavBarColor;
        [header addSubview:inviteView];
        if (self.inviteCode.length > 0) {
            inviteView.inviteCodeLabel.text = self.inviteCode;
        }else{
            inviteView.inviteCodeLabel.text = @"无";
        }
        if (self.count) {
            inviteView.inviteCount.text = [NSString stringWithFormat:@"%zd人",[self.count integerValue]];
        }else{
            inviteView.inviteCount.text = @"0人";
        }
        
        //规则
        if (!guizeBGView) {
            guizeBGView = [[UIView alloc]init];
        }
        guizeBGView.frame = CGRectMake(10, CGRectGetMaxY(inviteView.frame)+5, ScreenWidth-20, [self getHeighWithTitle:self.rulerInfo.Title font:[UIFont systemFontOfSize:17.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:self.rulerInfo.Content font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:@"活动时间:" font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] +25+15+10+10 + 10+50);
        [header addSubview:guizeBGView];
        
//        UIView *guizeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 150)];
//        guizeBGView.backgroundColor =[UIColor redColor];
//        [guizeBGView addSubview:guizeView];
        
        if (!rulerView) {
            rulerView = [YPMyGiftRulerView mygiftRulerView];
        }
        
        rulerView.frame = CGRectMake(0, 0, ScreenWidth-20, [self getHeighWithTitle:self.rulerInfo.Title font:[UIFont systemFontOfSize:17.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:self.rulerInfo.Content font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:@"活动时间:" font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] +25+15+10+10 + 50+10);
        rulerView.titleLabel.text = self.rulerInfo.Title;
        rulerView.contentLabel.text = self.rulerInfo.Content;
        rulerView.timeLabel.text = [NSString stringWithFormat:@"%@至%@",self.rulerInfo.StartTime,self.rulerInfo.EndTime];
        
        [rulerView.shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [guizeBGView addSubview:rulerView];
        rulerView.layer.cornerRadius = 5;
        rulerView.clipsToBounds = YES;
        rulerView.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00].CGColor;
        rulerView.layer.borderWidth = 1;
        
        
        [cell.contentView addSubview:header];
        
        cell.backgroundColor = CHJ_bgColor;//[UIColor whiteColor];
        //        [cell.layer setBorderWidth:1];
        //        [cell.layer setBorderColor:[UIColor blackColor].CGColor];
        return cell;
    }else {
        
        YPActivityPrizesList *list = self.listMarr[indexPath.section-1];
        YPActivityPrizesListData *data;
        if (list.Data.count == 0) {
             data = nil;
        }else{
            data = list.Data[indexPath.item];
        }
        
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
    if (indexPath.section == 0) {
        
    }else{
        YPActivityPrizesList *list = self.listMarr[indexPath.section-1];
        YPActivityPrizesListData *data = list.Data[indexPath.item];
        
        NSLog(@"%zd,%zd",(long)indexPath.section, indexPath.item);
        HRPresentXQViewController *xqvc  =[HRPresentXQViewController new];
        xqvc.activityPrizesID = data.ActivityPrizesID;
        [self.navigationController pushViewController:xqvc animated:YES];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return (CGSize){ScreenWidth, 50 + [self getHeighWithTitle:self.rulerInfo.Title font:[UIFont systemFontOfSize:17.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:self.rulerInfo.Content font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] + [self getHeighWithTitle:@"活动时间:" font:[UIFont systemFontOfSize:15.0] width:ScreenWidth-20-30] +25+15+10+10 + 10 + 50 + 10 + 30};
    }
   
    else
    {
        return (CGSize){ScreenWidth/2, ScreenWidth/2+70};
        
    }
}

-  (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 20, 0);
    }
   
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
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
    if (section == 0) {
        return CGSizeMake(ScreenWidth, 0.1);
    }else{
        return CGSizeMake(ScreenWidth, 30);
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
        headerView.backgroundColor = CHJ_bgColor;
        
        for (UIView *view in headerView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.section == 0) {
            NSLog(@"section  -- %zd",indexPath.section);
        }else{
            
            YPActivityPrizesList *list = self.listMarr[indexPath.section-1];
            
            NSLog(@"section  -- %zd",indexPath.section);
//            if (!label) {
                label = [[UILabel alloc]init];
//            }
            label.text = [NSString stringWithFormat:@"达标%@ 即可领取品牌礼品",list.Grade];
            label.textColor = GrayColor;
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
-(void)xiangxiBtnClick{
    NSLog(@"详细规则");
    YPDetailRulerController *ruler = [[YPDetailRulerController alloc]init];
    ruler.rulers = self.rulerInfo.Rule;
    [self.navigationController pushViewController:ruler animated:YES];
}
-(void)lingquClick{
    NSLog(@"领取奖品");
    
    YPReceiveGiftListController *receive = [[YPReceiveGiftListController alloc]init];
    receive.yaoQingCount = self.count;
    receive.grades = self.rulerInfo.Grade;
    receive.endTime = self.rulerInfo.EndTime;
    receive.ActivityID = self.rulerInfo.ActivityID;
    [self.navigationController pushViewController:receive animated:YES];
}

- (void)shareBtnClick{
    NSLog(@"shareBtnClick");
    
    [self showShareSDK];
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
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"邀请码:%@",self.inviteCode]
                                         images:imageArray
                                            url:[NSURL URLWithString:str]
                                          title:@"婚礼桥--婚礼原来如此简单"
                                           type:SSDKContentTypeAuto];
   
        
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[
                                         @(SSDKPlatformTypeCopy),
                                         @(SSDKPlatformTypeSMS),
                                         @(SSDKPlatformTypeWechat),
                                         @(SSDKPlatformTypeQQ),
                                         @(SSDKPlatformTypeSinaWeibo),
                                         @(SSDKPlatformTypeMail),
                                         ]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show] ;
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
}

#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self GetYQCount];
}

#pragma mark -------网络请求----------
#pragma mark 获取自己邀请人数量
-(void)GetYQCount{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/HQOAApi/GetYQCount";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"UserID"]  = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.count = [object valueForKey:@"Count"];
            self.inviteCode = [object valueForKey:@"YQCode"];
            
            [self GetActivityInfo];//获取规则详情
            
//            [self GetActivityPrizesList];//获取礼物列表
            
        }else if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 201) {
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = WhiteColor;
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self.view);
                make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
            }];
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = WhiteColor;
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self.view);
                make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
            }];
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
        }];
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];

}

#pragma mark 查看活动详情
-(void)GetActivityInfo{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/GetActivityInfo";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ObjectTypes"]  = @"1";//0公司、1供应商（用户）
    params[@"ObjectID"]     = UserId_New;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            self.rulerInfo.InvitedNumber = [object valueForKey:@"InvitedNumber"];
            self.rulerInfo.ActivityID = [object valueForKey:@"ActivityID"];
            self.rulerInfo.Title = [object valueForKey:@"Title"];
            self.rulerInfo.Content = [object valueForKey:@"Content"];
            self.rulerInfo.StartTime = [object valueForKey:@"StartTime"];
            self.rulerInfo.EndTime = [object valueForKey:@"EndTime"];
            self.rulerInfo.Rule = [object objectForKey:@"Rule"];
            self.rulerInfo.Grade = [object objectForKey:@"Grade"];
            self.rulerInfo.CreateTime = [object valueForKey:@"CreateTime"];
            self.rulerInfo.ObjectTypes = [object valueForKey:@"ObjectTypes"];
            
            [self ActivityPrizesListWithActivityID:[object valueForKey:@"ActivityID"]];//获取礼物列表
            
        }else if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 201) {
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = WhiteColor;
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self.view);
                make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
            }];
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = WhiteColor;
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self.view);
                make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
            }];
            
            [EasyShowTextView showText:[[object valueForKey:@"Message"] valueForKey:@"Inform"] ];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } Failure:^(NSError *error) {
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = WhiteColor;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(_navView.mas_bottom).mas_offset(1);
        }];
        
        [EasyShowTextView showErrorText:@"网络错误，请稍后重试！"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    
}

#pragma mark 查看活动奖品列表
-(void)ActivityPrizesListWithActivityID:(NSString *)activityID{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/ActivityPrizesList";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ActivityID"]  = activityID;
    
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
            
            NSLog(@"   ------  %@",[object objectForKey:@"GradeData"]);
            
            self.listMarr = [YPActivityPrizesList mj_objectArrayWithKeyValuesArray:[object objectForKey:@"GradeData"]];
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

#pragma mark - getter
- (NSMutableArray<YPActivityPrizesList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}

- (YPGetActivityInfo *)rulerInfo{
    if (!_rulerInfo) {
        _rulerInfo = [[YPGetActivityInfo alloc]init];
    }
    return _rulerInfo;
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
