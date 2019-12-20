//
//  CXInvitationFriendInfoVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/17.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXInvitationFriendInfoVC.h"
#import "CXInvitationFriendInfoView.h"  // 推荐人信息

@interface CXInvitationFriendInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CXBaseTableView  *tableView;    // tableView
@property (nonatomic, strong) UIScrollView  *scrollView;    // scrollview

@property (nonatomic, strong) UIView  *tableHeaderView;    // tableViewHeaderView
@property (nonatomic, strong) CXInvitationFriendInfoView  *infoView;    //信息填写
@property (nonatomic, strong) UIView  *shareBgView;         // 分享记录

@property (nonatomic, strong) UIView  *stepView;    // 流程视图
@property (nonatomic, strong) UIImageView  *banner;    // 顶部banner

@property (nonatomic, strong) UILabel  *numberLab;    // 已邀请的好友
@property (nonatomic, strong) UILabel  *moneyLab;    // 实际到账收益

@end

@implementation CXInvitationFriendInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configerUI];
    [self defaSetting];
}

- (void)configerUI {
    
    [self.view addSubview:self.scrollView];
    
//    self.tableView.tableHeaderView = self.tableHeaderView;
    
    [self.scrollView addSubview:self.banner];
    [self.scrollView addSubview:self.stepView];
    [self.scrollView addSubview:self.infoView];
    [self.scrollView addSubview:self.shareBgView];
    
    [self.shareBgView addSubview:self.numberLab];
    [self.shareBgView addSubview:self.moneyLab];
    
    [self addTitle:self.scrollView withFrame: CGRectMake((ScreenWidth - Line375(200))/2, self.banner.bottom - Line375(32)/2, Line375(200), Line375(32)) wtihTitle:@"奖励规则"];
    [self addTitle:self.scrollView withFrame: CGRectMake((ScreenWidth - Line375(200))/2, self.infoView.top , Line375(200), Line375(32)) wtihTitle:@"邀请好友"];
    [self addTitle:self.scrollView withFrame: CGRectMake((ScreenWidth - Line375(200))/2, self.shareBgView.top - Line375(32)/2, Line375(200), Line375(32)) wtihTitle:@"我的收益"];
    self.scrollView.backgroundColor = [CXUtils colorWithHexString:@"#FFBD43"];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.shareBgView.bottom + Line375(30));

}

- (void)defaSetting {
    NSString *numberTitle = @"\n\n已邀请好友";
    NSString *numberValue = @"10";
    
    NSMutableAttributedString *numberAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",numberValue,numberTitle] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:32 weight:UIFontWeightBold],NSForegroundColorAttributeName:[UIColor redColor]}];
    [numberAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#412F14"]} range:NSMakeRange(numberValue.length, numberTitle.length)];
    self.numberLab.attributedText = numberAtt;

    NSString *moneyTitle = @"\n\n实际到账收益";
    NSString *moneyValue = @"50";
       NSMutableAttributedString *moneyAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",moneyValue,moneyTitle] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:32 weight:UIFontWeightBold],NSForegroundColorAttributeName:[UIColor redColor]}];
    [moneyAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#412F14"]} range:NSMakeRange(moneyValue.length, moneyTitle.length)];
    self.moneyLab.attributedText = moneyAtt;
}

- (CXBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.width, self.view.height - Line375(30)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.backgroundColor = [UIColor orangeColor];
    }
    return _scrollView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(400))];
    }
    return _tableHeaderView;
}

- (UIImageView *)banner {
    
    if (!_banner) {
        
        _banner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(232))];
        _banner.backgroundColor = [CXUtils colorWithHexString:@"#FFBD43"];
        
    }
    return _banner;
}


- (UIView *)stepView {
    
    if (!_stepView) {
        _stepView = [[UIView alloc] initWithFrame:CGRectMake(Line375(15), self.banner.bottom, ScreenWidth - Line375(30), Line375(108))];
        _stepView.backgroundColor = [CXUtils colorWithHexString:@"#FFE4C1"];
        
        NSArray *stepImgs = @[@"haoyou-2",@"",@"shenhe-4",@"",@"xianjin-2"];
        NSArray *stepTexts = @[@"推荐身边要结婚的好友",@"等待审核通过",@"领50元现金"];
        
        CGFloat oriX = Line375(20);
        CGFloat imgW = (_stepView.width - Line375(40))/stepImgs.count;
        CGFloat imgH = _stepView.height/2;
        CGFloat labW = (_stepView.width - 6) / stepTexts.count;
        for (int i =0; i < stepImgs.count; i ++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * imgW + oriX, 20, imgW, imgH)];
            img.image = [UIImage imageNamed:stepImgs[i]];
            img.contentMode = UIViewContentModeCenter;
            
            [_stepView addSubview:img];
        }
        
        for (int i =0; i < stepTexts.count; i ++) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * labW + 2, imgH, labW, imgH)];
            lab.numberOfLines = 0;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:12];
            lab.text = stepTexts[i];
            [_stepView addSubview:lab];
        }
        
        _stepView.layer.cornerRadius = 15;
    }
    return _stepView;
}


/// 创建header
/// @param view 父视图
/// @param rect frame
/// @param text 文本
- (void)addTitle:(UIView *)view withFrame:(CGRect)rect wtihTitle:(NSString *)text {
    
    CAGradientLayer *layer = [CXUtils gradientLayerWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) withColors:@[(id)([CXUtils colorWithHexString:@"#FE8408"].CGColor),(id)([CXUtils colorWithHexString:@"#FEC454"].CGColor)] withStartPoint:CGPointMake(0, 1) withEndPoint:CGPointMake(0, 0) withLocations:nil];
    UIView *bg = [[UIView alloc] initWithFrame:rect];
    [bg.layer addSublayer:layer];
    bg.layer.cornerRadius = bg.height/2;
    bg.layer.masksToBounds = YES;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:bg.bounds];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = [NSString stringWithFormat:@"◆    %@    ◆",text];
    titleLab.font = FontW(15, UIFontWeightBold);
    titleLab.textAlignment = NSTextAlignmentCenter;
    
    [bg addSubview:titleLab];
    [view addSubview:bg];
}

// MARK: - 记录
- (UIView *)shareBgView {
    
    if (!_shareBgView) {
        _shareBgView = [[UIView alloc] initWithFrame:CGRectMake(Line375(15), self.infoView.bottom + Line375(31), ScreenWidth - Line375(30), Line375(110))];
        _shareBgView.clipsToBounds = YES;
        _shareBgView.backgroundColor = [UIColor whiteColor];
        _shareBgView.layer.cornerRadius = 15;
        
    }
    return _shareBgView;
}

- (UILabel *)numberLab {
    
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] initWithFrame:CGRectMake(0, Line375(32), self.shareBgView.width/2, self.shareBgView.height - Line375(32))];
        _numberLab.numberOfLines = 0;
        _numberLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLab;
}

- (UILabel *)moneyLab {
    
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(self.numberLab.right, self.numberLab.top, self.numberLab.width, self.numberLab.height)];
        _moneyLab.numberOfLines = 0;
        _moneyLab.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLab;
}

- (CXInvitationFriendInfoView *)infoView {
    
    if (!_infoView) {
        _infoView = [[[NSBundle mainBundle] loadNibNamed:@"CXInvitationFriendInfoView" owner:nil options:nil] lastObject];
        _infoView.frame = CGRectMake(0, self.stepView.bottom + Line375(15), ScreenWidth, 356 + 16);
    }
    return _infoView;
}

@end
