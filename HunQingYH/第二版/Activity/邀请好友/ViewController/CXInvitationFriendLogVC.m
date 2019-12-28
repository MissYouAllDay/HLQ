//
//  CXInvitationFriendLogVC.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/17.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXInvitationFriendLogVC.h"
#import "CXInvitationFriendLogCell.h"   // cell

@interface CXInvitationFriendLogVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel  *numberLab;      // 已邀请的好友
@property (nonatomic, strong) UILabel  *moneyLab;       // 实际到账收益
@property (nonatomic, strong) UIView   *topView;        // 顶部视图
@property (nonatomic, strong) UILabel  *bottomLab;      // 底部提示信息
@property (nonatomic, strong) UIView   *centerView;     // 中间试图
@property (nonatomic, strong) CXBaseTableView  *tableView;    // tableView

@end

@implementation CXInvitationFriendLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的战绩";
    self.view.backgroundColor = [CXUtils colorWithHexString:@"#F5DDFF"];
    
    [self configerUI];
    [self defaSetting];
}

- (void)configerUI {
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.bottomLab];
    
    [self.topView addSubview:self.numberLab];
    [self.topView addSubview:self.moneyLab];
    
    [self.centerView addSubview:self.tableView];
}

- (void)defaSetting {
    self.numberLab.frame = CGRectMake(0, 0, ScreenWidth/2, self.topView.height);
    self.moneyLab.frame = self.numberLab.frame;
    self.moneyLab.left = self.numberLab.right;
    
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    self.moneyLab.textAlignment = NSTextAlignmentCenter;
    
    NSString *numberTitle = @"已邀请好友\n\n";
    NSString *numberValue = @"10";
    NSString *numberUtil = @" 人";
    NSMutableAttributedString *numberAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",numberTitle,numberValue,numberUtil] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [numberAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(numberTitle.length, numberValue.length)];
    [numberAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(numberAtt.length - 1, 1)];
    self.numberLab.attributedText = numberAtt;
    
    NSString *moneyTitle = @"实际到账收益\n\n";
    NSString *moneyValue = @"50";
    NSString *moneyUtil = @" 元";
    NSMutableAttributedString *moneyAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",moneyTitle,moneyValue,moneyUtil] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [moneyAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(moneyTitle.length, moneyValue.length)];
    [moneyAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(moneyAtt.length - 1, 1)];
    self.moneyLab.attributedText = moneyAtt;
    
}
// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXInvitationFriendLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXInvitationFriendLogCell"];
    if (!cell) {
        cell = [[CXInvitationFriendLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CXInvitationFriendLogCell"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Line375(60);
}

// MARK: - 懒加载
- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, Line375(125))];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_topView.bounds];
        img.image = [UIImage imageNamed:@"invitationListBannerBg"];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [_topView addSubview:img];
    }
    return _topView;
}

- (UILabel *)numberLab {
    
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] init];
        _numberLab.numberOfLines = 0;
        _numberLab.backgroundColor = [UIColor clearColor];
    }
    return _numberLab;
}

- (UILabel *)moneyLab {
    
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.numberOfLines = 0;
        _moneyLab.backgroundColor = [UIColor clearColor];
    }
    return _moneyLab;
}

- (UILabel *)bottomLab {
    
    if (!_bottomLab) {
        _bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(Line375(15), ScreenHeight - Line375(74) - HOME_INDICATOR_HEIGHT - NAVIGATION_HEIGHT_S, ScreenWidth - Line375(30), Line375(74))];
        _bottomLab.numberOfLines = 0;
        _bottomLab.font = FontW(12,UIFontWeightMedium);
        _bottomLab.textColor = [CXUtils colorWithHexString:@"#B542E5"];
        _bottomLab.text = @"提示：  1.审核失败，该手机号未完成任务。2.待使用，您邀请的好友未在平台推荐新人。3.已入账，推荐成功，钱已自动转到余额。";
    }
    return _bottomLab;
}

- (UIView *)centerView {
    
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(Line375(15), self.topView.bottom, ScreenWidth - Line375(30), self.bottomLab.top - self.topView.bottom)];
        _centerView.backgroundColor = [UIColor redColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _centerView.width, Line375(30))];
        title.text = @"查看结果";
        title.font = FontW(16, UIFontWeightBold);
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        _centerView.layer.borderColor = [UIColor redColor].CGColor;
        _centerView.layer.borderWidth = 4;
        _centerView.layer.cornerRadius = 4;
        
        [_centerView addSubview:title];
    }
    return _centerView;
}

- (CXBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.centerView.width, self.centerView.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
