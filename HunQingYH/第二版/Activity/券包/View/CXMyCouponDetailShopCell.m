//
//  CXMyCouponDetailShopCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/18.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyCouponDetailShopCell.h"

@implementation CXMyCouponDetailShopCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.phoneTel addTarget:self action:@selector(phoneTelAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)phoneTelAction:(UIButton *)sender {
    
    [CXUtils phoneAction:self.viewController withTel:@""];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
