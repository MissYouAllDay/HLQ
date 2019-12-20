//
//  CXMyWalletDetailLogCell.m
//  CXFrameWork
//
//  Created by canxue on 2019/12/19.
//  Copyright © 2019 canxue. All rights reserved.
//

#import "CXMyWalletDetailLogCell.h"

@implementation CXMyWalletDetailLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
