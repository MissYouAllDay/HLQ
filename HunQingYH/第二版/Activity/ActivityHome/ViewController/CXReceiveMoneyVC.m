//
//  CXReceiveMoneyVC.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReceiveMoneyVC.h"
#import "CXReceiveMoneyView.h"
#import "CXWeddingBackItem.h"
#import "CXApplyReceiveMoneyView.h" // 我要报名

#import "CXApplyPartnerVC.h"        // 申请合伙人
#import "CXInviteHotelStayVC.h"     // 酒店入住
#import "CXSySPayGiftVC.h"          // 平台下单福利
#import "CXBackMoneyVC.h"           // 下单立返商家
#import "CXInvitationFriendVC.h"    // 邀请好友

@interface CXReceiveMoneyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView  *collectionView;    // collectionview
@property (nonatomic, strong) CXReceiveMoneyView *mainView;
@property (nonatomic, strong) NSArray  *mainImgArr;    // 其他活动图片

@end

@implementation CXReceiveMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.size = CGSizeMake(ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - Line375(50) - TAB_BAR_HEIGHT);
    self.mainImgArr = @[@"酒店入驻",@"合伙人",@"领福利",@"独有福利"];
    [self.view addSubview:self.collectionView];
}

- (void)defaSetting {
    
    // 查看下单立返商家
    UITapGestureRecognizer *backMoneyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushCXBackMoneyVC)];
    [self.mainView.backCustomerImg addGestureRecognizer:backMoneyTap];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CXReceiveMoneyRow *row = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXReceiveMoneyRow" forIndexPath:indexPath];
    
    row.img.image = [UIImage imageNamed:self.mainImgArr[indexPath.row]];

    return row;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CXReceiveMoneyView" forIndexPath:indexPath];
        if (!_mainView) {
            [header addSubview:self.mainView];
            header.clipsToBounds = YES;
        }
        
        return header;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:[self pushInviteHotelStayVC]; break; //邀请酒店入住
        case 1:[self pushToApplyPartnerVC]; break; //申请合伙人
        case 2:[self pushCXInvitationFriendVC]; break; //推荐好友领福利
        case 3:[self pushCXSySPayGiftVC]; break; //平台下单用户
        default:  break;
    }
}


// MARK: - 懒加载
- (CXReceiveMoneyView *)mainView {
    
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"CXReceiveMoneyView" owner:nil options:nil] lastObject];
        _mainView.frame = CGRectMake(0, 0, ScreenWidth, Line375(552));
        // 我要报名
        [_mainView.reviceMoneyBtn addTarget:self action:@selector(showApplyReceiveMoney) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainView;
}

- (UIView *)listView {
    
    return self.view;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake((ScreenWidth - Line375(15) * 2 - Line375(10))/2, Line375(96));
        flow.headerReferenceSize = CGSizeMake(ScreenWidth, 440);
        flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CXReceiveMoneyRow class] forCellWithReuseIdentifier:@"CXReceiveMoneyRow"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CXReceiveMoneyView"];
    }
    return _collectionView;
}

- (void)showApplyReceiveMoney {
    
    CXApplyReceiveMoneyView *moneyView = [[[NSBundle mainBundle] loadNibNamed:@"CXApplyReceiveMoneyView" owner:nil options:nil] lastObject];
    moneyView.frame = CGRectMake(0, 0, ScreenWidth, self.view.height);
    [moneyView showView];
    [self.view addSubview:moneyView];
}
// MARK: - Push
// 申请合伙人
- (void)pushToApplyPartnerVC {
    
    CXApplyPartnerVC *vc = [[CXApplyPartnerVC alloc] init];
    [self.mainNav pushViewController:vc animated:YES];
}

// 邀请酒店入住
- (void)pushInviteHotelStayVC {
    
    CXInviteHotelStayVC *vc = [[CXInviteHotelStayVC alloc] init];
    [self.mainNav pushViewController:vc animated:YES];
}

// 平台下单福利
- (void)pushCXSySPayGiftVC {
    
    CXSySPayGiftVC *vc = [[CXSySPayGiftVC alloc] init];
    [self.mainNav pushViewController:vc animated:YES];
}


/// 查看下单立返商家
- (void)pushCXBackMoneyVC {
    
    CXBackMoneyVC *vc = [[CXBackMoneyVC alloc] init];
     [self.mainNav pushViewController:vc animated:YES];
}

/// 邀请好友
- (void)pushCXInvitationFriendVC {
    
    CXInvitationFriendVC *vc = [[CXInvitationFriendVC alloc] init];
     [self.mainNav pushViewController:vc animated:YES];
}


@end


@implementation CXReceiveMoneyRow

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.img = [[UIImageView alloc] initWithFrame:self.bounds];
        self.img.layer.cornerRadius = 5;
        [self.contentView addSubview:self.img];
    }
    return self;
}

@end
