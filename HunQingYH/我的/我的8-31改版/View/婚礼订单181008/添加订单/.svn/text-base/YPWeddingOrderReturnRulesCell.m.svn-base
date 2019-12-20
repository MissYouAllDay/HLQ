//
//  YPWeddingOrderReturnRulesCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderReturnRulesCell.h"

@interface YPWeddingOrderReturnRulesCell ()<LMReportViewDatasource>

@end

@implementation YPWeddingOrderReturnRulesCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWeddingOrderReturnRulesCell";
    YPWeddingOrderReturnRulesCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWeddingOrderReturnRulesCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setRuleMarr:(NSArray<YPGetIntervalAmountParamList *> *)ruleMarr{
    _ruleMarr = ruleMarr;
    
    if (!self.listView) {
        self.listView = [[LMReportView alloc]init];
    }
    self.listView.style.widthOfFirstCol =ScreenWidth/2;
    self.listView.style.widthOfCol =ScreenWidth/2;
    self.listView.style.borderColor =TextNormalColor;
    self.listView.datasource = self;
    self.listView.style.backgroundColorOfHeader = WhiteColor;
    self.listView.style.textColorOfHeader = BlackColor;
    [self.contentView addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(20);
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-20);
        make.height.mas_greaterThanOrEqualTo([self.listView heightOfRow:0] * _ruleMarr.count);
    }];
}

#pragma mark - <LMReportViewDatasource>
- (NSInteger)numberOfRowsInReportView:(LMReportView *)reportView {
    return self.ruleMarr.count+1;
}

- (NSInteger)numberOfColsInReportView:(LMReportView *)reportView {
    return 2;
}

- (LMRGrid *)reportView:(LMReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    
    LMRGrid *grid = [[LMRGrid alloc] init];
    if (indexPath.row == 0 && indexPath.col == 0) {
        grid.text = @"消费金额";
    }else if (indexPath.row == 0 && indexPath.col == 1){
        grid.text = @"返还金额";
    }else{
        YPGetIntervalAmountParamList *listModel = self.ruleMarr[indexPath.row-1];
        if (indexPath.col == 0) {
            grid.text = [NSString stringWithFormat:@"%@ - %@",listModel.StartingPrice,listModel.TerminationPrice];
        }else if (indexPath.col == 1){
            grid.text = [NSString stringWithFormat:@"%@",listModel.Reversion];
        }
    }
    return grid;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
