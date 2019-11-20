//
//  YPHotelPayDaiFuFootCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelPayDaiFuFootCell.h"

@implementation YPHotelPayDaiFuFootCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHotelPayDaiFuFootCell";
    YPHotelPayDaiFuFootCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHotelPayDaiFuFootCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setRefuseBtn:(UIButton *)refuseBtn{
    _refuseBtn = refuseBtn;
    
    _refuseBtn.layer.cornerRadius = 2;
    _refuseBtn.clipsToBounds = YES;
    _refuseBtn.layer.borderColor = RGBS(221).CGColor;
    _refuseBtn.layer.borderWidth = 1;
}

- (void)setPayBtn:(UIButton *)payBtn{
    _payBtn = payBtn;
    
    _payBtn.layer.cornerRadius = 2;
    _payBtn.clipsToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
