//
//  CXSmallTestResultView.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/10.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXSmallTestResultView.h"
#import "CXSmallTestResultCell.h"
@interface CXSmallTestResultView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView  *centerView;    // 中间滚动式图
@property (nonatomic, strong) CXBaseTableView  *tableView;    // tableView
@property (nonatomic, strong) UILabel  *alertlab;    // 提示信息
@property (nonatomic, strong) UILabel  *moneyLab;    // 最多可领取的金额
@property (nonatomic, strong) UIView  *bgView;    // bgView

@end

@implementation CXSmallTestResultView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.moneyLab];
        [self.bgView addSubview:self.tableView];
        [self addSubview:self.alertlab];
        
        [self defaSetting];
    }
    return self;
}

- (void)defaSetting {
    
    self.alertlab.text = @"小测试的结果以立返额度最大的商家为准";
    [self round:25 RectCorners:(UIRectCornerTopRight | UIRectCornerTopLeft )];
    self.layer.masksToBounds = YES;
    
    NSString *money = @"2000";
    NSString *alertText = @"最高可领取(元）";
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",money,alertText] attributes:@{NSFontAttributeName:FontW(22, UIFontWeightBold),NSForegroundColorAttributeName:[CXUtils colorWithHexString:@"#C82326"]}];
    
    [att addAttribute:NSFontAttributeName value:FontW(12, UIFontWeightMedium) range:NSMakeRange(money.length + 1, alertText.length)];
    self.moneyLab.attributedText = att;
}

// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXSmallTestResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXSmallTestResultCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CXSmallTestResultCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CXSmallTestResultCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CXSmallTestResultCell" owner:nil options:nil] lastObject];
    return cell;
}

- (CXBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectMake(self.alertlab.left, self.moneyLab.bottom, self.alertlab.width, self.bgView.height - self.moneyLab.bottom )];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UILabel *)alertlab {
    
    if (!_alertlab) {
        _alertlab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 30, self.width - Line375(30), 30)];
        _alertlab.textAlignment = NSTextAlignmentCenter;
        _alertlab.numberOfLines = 0;
        _alertlab.textColor = [CXUtils colorWithHexString:@"#FED349"];
    }
    return _alertlab;
}

- (UILabel *)moneyLab {
    
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, Line375(66))];
        _moneyLab.numberOfLines = 0;
        _moneyLab.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLab;
}

- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(Line375(15), Line375(34), self.alertlab.width, self.alertlab.top - Line375(34))];
        _bgView.layer.cornerRadius = 15;
        _bgView.layer.borderWidth = 5;
        _bgView.layer.borderColor = [UIColor yellowColor].CGColor;
        _bgView.clipsToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end
