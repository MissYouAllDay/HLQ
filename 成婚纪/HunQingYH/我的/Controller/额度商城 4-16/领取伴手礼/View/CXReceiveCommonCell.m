
//
//  CXReceiveCommonCell.m
//  HunQingYH
//
//  Created by apple on 2019/9/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXReceiveCommonCell.h"

@implementation CXReceiveCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
