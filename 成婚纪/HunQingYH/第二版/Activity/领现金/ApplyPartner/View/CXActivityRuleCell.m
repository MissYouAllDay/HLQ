//
//  CXActivityRuleCell.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXActivityRuleCell.h"

@implementation CXActivityRuleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.ruleBgView.layer.cornerRadius = 10;
    self.ruleBgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
