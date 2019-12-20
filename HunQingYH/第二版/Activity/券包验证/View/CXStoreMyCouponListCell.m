//
//  CXStoreMyCouponListCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXStoreMyCouponListCell.h"

@implementation CXStoreMyCouponListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cancelBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
