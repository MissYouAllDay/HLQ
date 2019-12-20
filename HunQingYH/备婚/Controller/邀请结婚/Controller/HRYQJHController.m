//
//  HRYQJHController.m
//  HunQingYH
//
//  Created by Hiro on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRYQJHController.h"
#import "MCFlowLayout.h"
#import "HRYQJHHeaderView.h"
#import "HRYQJHTextCell.h"
#import "YPActivityPrizesListData.h"//礼物模型
#import "HRYQPrisentCell.h"
#import "HRYQJLViewController.h"//邀请记录
#import "HRDLYQJLViewController.h"//邀请记录重做，也代理邀请统一
#import "HRPresentXQViewController.h"
#import "YPYQJLOtherInfoController.h"//填写资料
#import "HRYQJHCodeCell.h"
#import "HRDLZQViewController.h"
static NSString *const reuse0ID = @"cell";
static NSString *const reuse1ID = @"HRYQPrisentCell";
//static NSString *const reuse2ID = @"cell2";
static NSString *const headID = @"headerView";
#define topHeight  300
@interface HRYQJHController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    UIView *_navView;
    
    UIView *guizeBGView;
    UILabel *label;
}

@property (nonatomic, weak) UICollectionView *collectionview;
@property(nonatomic,strong)HRYQJHHeaderView *topView;
@property (nonatomic, strong) NSMutableArray<YPActivityPrizesListData *> *listMarr;
@end

@implementation HRYQJHController
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 菊花不会自动消失，需要自己移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoding];
    });
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUI];
    [self getPresetListRequest];
}
- (NSMutableArray<YPActivityPrizesListData *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}
#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_01"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(_navView.mas_left);
        make.bottom.mas_equalTo(_navView.mas_bottom).offset(-10);
    }];
    
//    UILabel *titleLab  = [[UILabel alloc]init];
//    titleLab.text = @"邀请有礼";
//    titleLab.textColor = WhiteColor;
//    titleLab.font = [UIFont boldSystemFontOfSize:20];
//    [_navView addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(backBtn.mas_centerY);
//        make.centerX.mas_equalTo(_navView.mas_centerX);
//    }];
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
    

    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse0ID];
    [collectionview registerClass:[HRYQPrisentCell class] forCellWithReuseIdentifier:reuse1ID];//礼物cell
    [collectionview registerNib:[UINib nibWithNibName:@"HRYQJHTextCell" bundle:nil] forCellWithReuseIdentifier:@"HRYQJHTextCell"];
    [collectionview registerNib:[UINib nibWithNibName:@"HRYQJHCodeCell" bundle:nil] forCellWithReuseIdentifier:@"HRYQJHCodeCell"];
//    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse2ID];
    
    // 注册头部
    [collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section ==1){
        return 3;
    }
    else {
        return self.listMarr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse0ID forIndexPath:indexPath];
        if (!_topView) {
            _topView =[HRYQJHHeaderView inviteView];
        }
        _topView.backgroundColor =WhiteColor;
        _topView.frame =CGRectMake(0, 0, ScreenWidth, topHeight);
        
        _topView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
        _topView.titleLabel.textColor = [UIColor colorWithRed:71.5/255 green:71.5/255 blue:71.5/255 alpha:1];
        _topView.yaoqingBtn.clipsToBounds =YES;
        _topView.yaoqingBtn.layer.cornerRadius =3;
        [_topView.yaoqingBtn addTarget:self action:@selector(yaoqingClick) forControlEvents:UIControlEventTouchUpInside];
//        _topView.codeLab.text =self.rulerInfo.YQCode;
//        [_topView.guiTuBtn addTarget:self action:@selector(guiZeClick) forControlEvents:UIControlEventTouchUpInside];
//
        _topView.fenxiangBtn.clipsToBounds =YES;
        _topView.fenxiangBtn.layer.cornerRadius =3;
        _topView.fenxiangBtn.layer.borderWidth =1;
        _topView.fenxiangBtn.layer.borderColor =MainColor.CGColor;
        [_topView.fenxiangBtn addTarget:self action:@selector(fenxiangClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:_topView];
        
        cell.backgroundColor = WhiteColor;
        
        return cell;
    }else if (indexPath.section ==1){
        
        if (indexPath.item ==0) {
            
            HRYQJHTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HRYQJHTextCell" forIndexPath:indexPath];
            cell.backgroundColor = WhiteColor;
              cell.titleLab.text =@"邀请记录";
            return cell;
        }else if (indexPath.item ==1){
            HRYQJHTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HRYQJHTextCell" forIndexPath:indexPath];
            cell.backgroundColor = WhiteColor;
                cell.titleLab.text =@"活动规则";
            return cell;
        }else{
            HRYQJHCodeCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HRYQJHCodeCell" forIndexPath:indexPath];
            cell.backgroundColor = WhiteColor;
            return cell;
        }
        
        
        
       
        
 
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
    
    if (indexPath.section ==1) {
        if (indexPath.item ==0) {
//            HRYQJLViewController *jlVC = [HRYQJLViewController new  ];
//            [self.navigationController pushViewController:jlVC animated:YES];
            HRDLYQJLViewController *jlVC = [HRDLYQJLViewController new];
            jlVC.typeFlag =1;
            [self.navigationController presentViewController:jlVC animated:YES completion:nil];
        }else if (indexPath.item ==1){
            
            HRWebViewController *webVC =[HRWebViewController new];
            webVC.webUrl =@"http://www.chenghunji.com/Download/Rules/OtherFreeWedding.html";
            webVC.isShareBtn =NO;
            [self.navigationController pushViewController:webVC animated:YES];
        }else{
            HRDLZQViewController *DLVC = [HRDLZQViewController new];
            [self.navigationController pushViewController:DLVC animated:YES];
        }
    }
    if (indexPath.section == 2) {
        
        YPActivityPrizesListData *data = self.listMarr[indexPath.row];
        
    
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
        return (CGSize){ScreenWidth, 50 };
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
    if (section ==2) {
        return CGSizeMake(ScreenWidth, 50);
        
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
        
        if (indexPath.section == 0||indexPath.section==1) {
            NSLog(@"section  -- %zd",indexPath.section);
        }else{
            
            
            //            if (!label) {
            label = [[UILabel alloc]init];
            
            label.text =@"品牌豪礼";
            label.textColor = [UIColor darkGrayColor];
            [headerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(headerView.mas_top).offset(30);
            }];
            
//            UIButton *lingquBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [lingquBtn setTitle:@"领取奖品" forState:UIControlStateNormal];
//            [lingquBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//            [lingquBtn setBackgroundColor:MainColor];
//            lingquBtn.clipsToBounds =YES;
//            lingquBtn.layer.cornerRadius =3;
//            [headerView addSubview:lingquBtn];
//            [lingquBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(10);
//                make.top.mas_equalTo(label.mas_bottom).offset(20);
//                make.size.mas_equalTo(CGSizeMake(120, 50));
//            }];
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
-(void)yaoqingClick{
    NSLog(@"邀请");
    
    YPYQJLOtherInfoController *otherInfo = [[YPYQJLOtherInfoController alloc]init];
    [self.navigationController pushViewController:otherInfo animated:YES];
}
-(void)fenxiangClick{
    
    
    
    [HRShareView showShareViewWithPublishContent:@{@"title":@"邀好友来婚礼桥办婚礼，可赢取100元现金，可提现！",
                                                   @"text" :@"与好友一起起航，登上“小成梦想号”，赴免费盛宴，掌握赚钱秘籍，赢高额奖励金哦！",
                                                   @"image":@"http://121.42.156.151:93/FileGain.aspx?fi=b73de463-b243-4ac3-bfd2-37f40df12274&it=0",
                                                   @"url"  :@"http://www.chenghunji.com/Redbag/yqoqingjiehun"}
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
