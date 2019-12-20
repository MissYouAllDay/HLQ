//
//  CXMyWalletBackMoneyLogCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletBackMoneyLogCell.h"

@implementation CXMyWalletBackMoneyLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shareBtn.layer.cornerRadius = self.shareBtn.height/2;
self.backgroundColor = [UIColor clearColor];
}

/// 推荐好友
- (void)shareStatus  {
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.moneyLab.textColor =
    self.alertLab.textColor =
    self.timeLab.textColor = [CXUtils colorWithHexString:@"#202020"];
    
    self.shareBtn.backgroundColor = [CXUtils colorWithHexString:@"#E6E5E5"];
    [self.shareBtn setTitle:@"推荐好友" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[CXUtils colorWithHexString:@"#656565"] forState:UIControlStateNormal];
    
}

/// 首年免费
- (void)freeStatus {
    
    self.bgView.backgroundColor = [CXUtils colorWithHexString:@"F65F62"];
    self.moneyLab.textColor =
    self.alertLab.textColor =
    self.timeLab.textColor = [CXUtils colorWithHexString:@"#FDFCFC"];

    self.shareBtn.backgroundColor = [UIColor whiteColor];
    [self.shareBtn setTitle:@"首年免费领" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[CXUtils colorWithHexString:@"F65F62"] forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
