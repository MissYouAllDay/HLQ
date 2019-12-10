//
//  CXInviteHotelStayLogCell.m
//  HunQingYH
//
//  Created by canxue on 2019/12/8.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "CXInviteHotelStayLogCell.h"

@implementation CXInviteHotelStayLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.mainBgView.layer.cornerRadius = 10;
    self.mainBgView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
