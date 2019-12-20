//
//  AnswerCell.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//


#import "AnswerCell.h"

@implementation AnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textViewLabel.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
