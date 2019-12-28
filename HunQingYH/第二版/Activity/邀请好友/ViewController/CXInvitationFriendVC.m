//
//  CXShareToFriendVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/11.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXInvitationFriendVC.h"
#import "CXInvitationFriendLogVC.h" // 领取记录
#import "CXInvitationFriendInfoVC.h"    // 邀请好友填写信息

@interface CXInvitationFriendVC ()

@property (nonatomic, strong) UIScrollView  *scrollView;    // scrollview
@property (nonatomic, strong) UIImageView  *banner;         // 背景图
@property (nonatomic, strong) UIView  *stepBgView;          // 邀请流程
@property (nonatomic, strong) UIView  *shareBgView;         // 分享记录

@property (nonatomic, strong) UIView  *bottomView;          // 底部视图

//@property (nonatomic, strong) UIImageView  *stepImg;        // 邀请流程
@property (nonatomic, strong) UIView    *stepView;          // 邀请流程
@property (nonatomic, strong) UIButton  *invitationBtn;    // 邀请按钮

@property (nonatomic, strong) UIView  *stepTitleView;    // 推荐好友步骤标题
@property (nonatomic, strong) UILabel  *stepAlert;    // 推荐好友提示信息

@property (nonatomic, strong) UIView  *shareTitleView;    // 标题
@property (nonatomic, strong) UILabel  *numberLab;    // 已邀请的好友
@property (nonatomic, strong) UILabel  *moneyLab;    // 实际到账收益
@property (nonatomic, strong) UIButton  *detailBtn;    // 查看详情

@end

@implementation CXInvitationFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐好友";
    [self configerLayout];
    [self configerUI];
    [self defaSetting];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"fenxiang"] highImage:[UIImage imageNamed:@"fenxiang"] target:self action:@selector(pushNavigationBarRightItem)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)configerUI {
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.banner];
    [self.scrollView addSubview:self.bottomView];
    [self.scrollView addSubview:self.stepBgView];
    [self.scrollView addSubview:self.shareBgView];
    
    [self.stepBgView addSubview:self.stepView];
    [self.stepBgView addSubview:self.stepAlert];
    [self.stepBgView addSubview:self.stepTitleView];
    [self.stepBgView addSubview:self.invitationBtn];
    
    
    [self.shareBgView addSubview:self.shareTitleView];
    [self.shareBgView addSubview:self.numberLab];
    [self.shareBgView addSubview:self.moneyLab];
    [self.shareBgView addSubview:self.detailBtn];
}

- (void)configerLayout {
     
    self.banner.frame = CGRectMake(0, 0, ScreenWidth, Line375(233));
    
    self.stepBgView.frame = CGRectMake(Line375(15), self.banner.bottom, ScreenWidth - Line375(30), Line375(233));
    self.shareBgView.frame = CGRectMake(self.stepBgView.left, self.stepBgView.bottom + Line375(15), self.stepBgView.width, Line375(190));
    
    self.invitationBtn.frame = CGRectMake(Line375(30), self.stepBgView.height - Line375(45), self.stepBgView.width - Line375(60), Line375(30));
    self.detailBtn.frame = CGRectMake(self.invitationBtn.left, self.shareBgView.height - Line375(45), self.invitationBtn.width, self.invitationBtn.height);
    
    self.stepAlert.frame = CGRectMake(Line375(68), self.stepTitleView.bottom, self.stepBgView.width - Line375(136), Line375(38));
    //    self.stepImg.frame = CGRectMake(0, self.stepAlert.bottom, self.stepBgView.width, self.invitationBtn.top - self.stepAlert.bottom);
    
    self.numberLab.frame = CGRectMake(0, Line375(37), self.shareBgView.width/2, self.detailBtn.top - self.shareTitleView.bottom);
    self.moneyLab.frame = self.numberLab.frame;
    self.moneyLab.left = self.numberLab.right;
    
    self.bottomView.frame = CGRectMake(0, self.banner.bottom, ScreenWidth,self.shareBgView.bottom - self.banner.bottom + 30 + NAVIGATION_HEIGHT_S);

    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.bottomView.bottom);
}

- (void)defaSetting {
    self.banner.image = [UIImage imageNamed:@"推荐再推荐图"];
    UIColor *startColor = RGB(132, 86, 230);
   CAGradientLayer *layer = [CXUtils gradientLayerWithFrame:self.view.bounds withColors:@[(id)startColor.CGColor,(id)[CXUtils colorWithHexString:@"#AB3FDE"].CGColor] withStartPoint:CGPointMake(0, 0) withEndPoint:CGPointMake(0, 1) withLocations:nil];
   [self.bottomView.layer addSublayer:layer];
    
    self.stepBgView.backgroundColor =
    self.shareBgView.backgroundColor = [UIColor whiteColor];
    
    self.stepBgView.layer.cornerRadius =
    self.shareBgView.layer.cornerRadius = 25;
    
    self.invitationBtn.layer.cornerRadius = self.invitationBtn.height/2;
    self.detailBtn.layer.cornerRadius = self.detailBtn.height/2;
    
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    self.moneyLab.textAlignment = NSTextAlignmentCenter;
    
    self.invitationBtn.backgroundColor = [CXUtils colorWithHexString:@"#F75923"];
    [self.invitationBtn setTitle:@"立即邀请好友" forState:UIControlStateNormal];
    
    self.detailBtn.layer.borderColor = [CXUtils colorWithHexString:@"#F75923"].CGColor;
    self.detailBtn.layer.borderWidth = 1;
    [self.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.detailBtn setTitleColor:[CXUtils colorWithHexString:@"#F75923"] forState:UIControlStateNormal];
    
    self.stepAlert.numberOfLines = 0;
    self.stepAlert.textColor = RGB(255, 168, 11);
    self.stepAlert.font = [UIFont systemFontOfSize:12];
    self.stepAlert.text = @"邀请一位好友成功获得50元现金人数上不封顶，人数越多奖金越多";
    
    NSString *numberTitle = @"已邀请好友\n\n";
    NSString *numberValue = @"10";
    NSString *numberUtil = @" 人";
    NSMutableAttributedString *numberAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",numberTitle,numberValue,numberUtil] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [numberAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#FE4302"]} range:NSMakeRange(numberTitle.length, numberValue.length)];
    [numberAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#FE4302"]} range:NSMakeRange(numberAtt.length - 1, 1)];
    self.numberLab.attributedText = numberAtt;
    
    NSString *moneyTitle = @"实际到账收益\n\n";
    NSString *moneyValue = @"50";
    NSString *moneyUtil = @" 元";
    NSMutableAttributedString *moneyAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",moneyTitle,moneyValue,moneyUtil] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [moneyAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#FE4302"]} range:NSMakeRange(moneyTitle.length, moneyValue.length)];
    [moneyAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#FE4302"]} range:NSMakeRange(moneyAtt.length - 1, 1)];
    self.moneyLab.attributedText = moneyAtt;
}


// MARK: - Lazy
- (UIImageView *)banner {
    
    if (!_banner) {
        _banner = [[UIImageView alloc] init];
    }
    return _banner;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _scrollView;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UIView *)stepBgView {
    
    if (!_stepBgView) {
        _stepBgView = [[UIView alloc] init];
    }
    return _stepBgView;
}

- (UIView *)shareBgView {
    
    if (!_shareBgView) {
        _shareBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - Line375(30), 0)];
        _shareBgView.clipsToBounds = YES;
    }
    return _shareBgView;
}

- (UIView *)stepTitleView {
    
    if (!_stepTitleView) {
        _stepTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - Line375(30), Line375(37))];
        _stepTitleView.clipsToBounds = YES;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, Line375(12), _stepTitleView.width, Line375(25))];
        imgV.image = [UIImage imageNamed:@"invitationTitle"];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(imgV.left, imgV.top, imgV.width, imgV.height)];
        titleLab.text = @"活动规则";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.backgroundColor = [UIColor clearColor];
        
        [_stepTitleView addSubview:imgV];
        [_stepTitleView addSubview:titleLab];
    }
    return _stepTitleView;
}

//- (UIImageView *)stepImg {
//
//    if (!_stepImg) {
//        _stepImg = [[UIImageView alloc] init];
//    }
//    return _stepImg;
//}
- (UILabel *)stepAlert {
    
    if (!_stepAlert) {
        _stepAlert = [[UILabel alloc] init];
    }
    return _stepAlert;
}

- (UIButton *)invitationBtn {
    
    if (!_invitationBtn) {
        _invitationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_invitationBtn addTarget:self action:@selector(pushCXInvitationFriendInfoVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _invitationBtn;
}

- (UIView *)shareTitleView {
    
    if (!_shareTitleView) {
        _shareTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - Line375(30), Line375(37))];
        _shareTitleView.clipsToBounds = YES;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, Line375(12), _shareTitleView.width, Line375(25))];
        imgV.image = [UIImage imageNamed:@"invitationTitle"];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(imgV.left, imgV.top, imgV.width, imgV.height)];
        titleLab.text = @"我的战绩";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor whiteColor];
        [_shareTitleView addSubview:imgV];
        [_shareTitleView addSubview:titleLab];
    }
    return _shareTitleView;
}

- (UILabel *)numberLab {
    
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] init];
        _numberLab.numberOfLines = 0;
    }
    return _numberLab;
}

- (UILabel *)moneyLab {
    
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.numberOfLines = 0;
    }
    return _moneyLab;
}

- (UIButton *)detailBtn {
    
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn addTarget:self action:@selector(pushCXInvitationFriendLogVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}

- (UIView *)stepView {
    
    if (!_stepView) {
        _stepView = [[UIView alloc] initWithFrame:CGRectMake(Line375(15), self.stepAlert.bottom, ScreenWidth - Line375(60), Line375(116))];
        
        NSArray *stepImgs = @[@"haoyou",@"invitationContentLine",@"lipin-2",@"invitationContentLine",@"tubiao11"];
        NSArray *stepTexts = @[@"填写好友手机号",@"推荐好友领取宝马或丽人福利，并线下兑换礼品",@"获得现金奖励"];
        
        CGFloat oriX = Line375(20);
        CGFloat imgW = (_stepView.width - Line375(40))/stepImgs.count;
        CGFloat imgH = _stepView.height/2;
        CGFloat labW = (_stepView.width - 6) / stepTexts.count;
        for (int i =0; i < stepImgs.count; i ++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * imgW + oriX, 0, imgW, imgH)];
            img.image = [UIImage imageNamed:stepImgs[i]];
            img.contentMode = UIViewContentModeCenter;
            
            [_stepView addSubview:img];
        }
        
        for (int i =0; i < stepTexts.count; i ++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * labW + 2, imgH, labW, 20)];
            if (i == 1) { lab.height = 50; }
            lab.numberOfLines = 0;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:12];
            lab.text = stepTexts[i];
            [_stepView addSubview:lab];
        }
    }
    return _stepView;
}

// MARK: - push
// 邀请记录
- (void)pushCXInvitationFriendLogVC {
    
    CXInvitationFriendLogVC *vc = [[CXInvitationFriendLogVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// t邀请好友
- (void)pushCXInvitationFriendInfoVC {
    
    CXInvitationFriendInfoVC *vc = [[CXInvitationFriendInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushNavigationBarRightItem {
    
    NSLog(@"你点击我了");
}
@end
