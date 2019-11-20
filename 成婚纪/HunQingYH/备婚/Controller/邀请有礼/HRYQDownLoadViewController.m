//
//  HRYQDownLoadViewController.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRYQDownLoadViewController.h"
#import "YPBHInviteController.h"
#import "MCFlowLayout.h"
#import "HRYQPrisentCell.h"
#import "HRDownLoadNumView.h"
#import "YPActivityPrizesList.h"//礼品模型
#import "YPReceiveGiftListController.h"
#import "HRPresentXQViewController.h"
static NSString *const reuse0ID = @"cell";
static NSString *const reuse1ID = @"HRYQPrisentCell";
static NSString *const headID = @"headerView";
#define topHeight  50

@interface HRYQDownLoadViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIView *_navView;
    UITableView *thisTableView;
    UILabel *label;
}
@property (nonatomic, weak) UICollectionView *collectionview;
@property(nonatomic,strong)HRDownLoadNumView *numTopView;
@property (nonatomic, strong) NSMutableArray<YPActivityPrizesList *> *listMarr;
@end

@implementation HRYQDownLoadViewController
#pragma mark - getter
- (NSMutableArray<YPActivityPrizesList *> *)listMarr{
    if (!_listMarr) {
        _listMarr = [NSMutableArray array];
    }
    return _listMarr;
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNav];
    [self setupUI];
    [self getListRequest];
}

#pragma mark - UI
- (void)setupNav{
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = WhiteColor;
    [self.view addSubview:_navView];
    
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
    titleLab.text = @"邀请下载";
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    [_navView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(_navView.mas_centerX);
    }];
       self.view.backgroundColor = CHJ_bgColor;
}

- (void)setupUI{
 
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight-NAVIGATION_BAR_HEIGHT-50) collectionViewLayout:layout];
    
    [self.view addSubview:collectionview];
    collectionview.backgroundColor = CHJ_bgColor;
    collectionview.dataSource = self;
    collectionview.delegate = self;
    collectionview.showsHorizontalScrollIndicator =NO;
    collectionview.showsVerticalScrollIndicator =NO;
    self.collectionview = collectionview;
    
    [collectionview registerClass:[HRYQPrisentCell class] forCellWithReuseIdentifier:reuse1ID];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse0ID];
    
    // 注册头部
    [collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    [self creteBottomView];
}
-(void)creteBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionview.frame), ScreenWidth, 50)];
    bottomView.backgroundColor =WhiteColor;
    [self.view addSubview:bottomView];
    UIButton *LingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LingBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [LingBtn setTitle:@"领取我的奖品" forState:UIControlStateNormal];
    LingBtn.frame =CGRectMake(10, 5, ScreenWidth-20, 40);
    LingBtn.clipsToBounds =YES;
    LingBtn.layer.cornerRadius =5;
    LingBtn.backgroundColor =MainColor;
     [LingBtn addTarget:self action:@selector(lingClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:LingBtn];
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
        if (!_numTopView) {
            _numTopView =[HRDownLoadNumView inviteView];
        }
        _numTopView.backgroundColor =WhiteColor;
        _numTopView.frame =CGRectMake(0, 0, ScreenWidth, topHeight);
        _numTopView.numLab.text =[NSString stringWithFormat:@"已邀请%@人",_InvitedNumber];
        [cell.contentView addSubview:_numTopView];
        
        cell.backgroundColor = WhiteColor;
        
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
        return (CGSize){ScreenWidth, topHeight };
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
-(void)lingClick{
    NSLog(@"领取奖品");
    
    
    YPReceiveGiftListController *receive = [[YPReceiveGiftListController alloc]init];
    receive.yaoQingCount = self.InvitedNumber;
    receive.grades = self.grades;
    receive.endTime = self.endTime;
    receive.ActivityID = self.ActivityID;
    receive.ObjectTypes =1;
    [self.navigationController pushViewController:receive animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 查看活动奖品列表
-(void)getListRequest{
    [EasyShowLodingView showLoding];
    NSString *url = @"/api/Corp/ActivityPrizesList";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ActivityID"]  = self.ActivityID;
    [[NetworkTool shareManager] requestWithUrlStr:url withParams:params Success:^(NSDictionary *object) {
        
        // 菊花不会自动消失，需要自己移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [EasyShowLodingView hidenLoding];
        });
        if ([[[object valueForKey:@"Message"] valueForKey:@"Code"] integerValue] == 200) {
//            
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

@end
