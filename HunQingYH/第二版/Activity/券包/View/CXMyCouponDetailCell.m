//
//  CXMyCouponDetailCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyCouponDetailCell.h"

@implementation CXMyCouponDetailCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
}

/// 未使用
- (void)notUsed {
    
    self.statuslab.hidden = NO;
    self.statuslab.text = @"去使用";
}

/// 已使用
- (void)alreadyUsed {
    self.statuslab.hidden = NO;
    self.statuslab.text = @"查看";
}

/// 已过期
- (void)expired {
    self.statuslab.hidden = YES;
}


@end
