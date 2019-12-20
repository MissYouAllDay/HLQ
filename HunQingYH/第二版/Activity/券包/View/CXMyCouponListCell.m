//
//  CXMyCouponListCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyCouponListCell.h"

@implementation CXMyCouponListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.statuslab.layer.borderColor = [UIColor colorWithHexString:@"6F6E6E"].CGColor;
    self.statuslab.layer.borderWidth = 1;
    self.statuslab.layer.cornerRadius = 5;
    self.statuslab.layer.masksToBounds = YES;
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor clearColor];
}

/// 未使用
- (void)notUsed {
    
    self.statuslab.hidden = NO;
    self.expiredImg.hidden = YES;
    self.statuslab.text = @"去使用";
    self.statusImg.image = [UIImage imageNamed:@""];
}

/// 已使用
- (void)alreadyUsed {
    self.statuslab.hidden = NO;
    self.expiredImg.hidden = YES;
    self.statuslab.text = @"查看";
    self.statusImg.image = [UIImage imageNamed:@""];
}

/// 已过期
- (void)expired {
    self.statuslab.hidden = YES;
    self.expiredImg.hidden = NO;
    self.statusImg.image = [UIImage imageNamed:@""];
    self.expiredImg.image = [UIImage imageNamed:@""];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
