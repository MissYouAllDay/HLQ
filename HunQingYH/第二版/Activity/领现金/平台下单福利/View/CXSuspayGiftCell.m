//
//  CXSuspayGiftCell.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXSuspayGiftCell.h"

@implementation CXSuspayGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.mainBgView.layer.cornerRadius = 15;
    self.mainBgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
