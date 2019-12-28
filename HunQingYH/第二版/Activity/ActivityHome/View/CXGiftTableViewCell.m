//
//  CXGiftTableViewCell.m
//  HunQingYH
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXGiftTableViewCell.h"

@implementation CXGiftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainImg.backgroundColor = [CXUtils colorWithHexString:@"#DCDCDC"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
