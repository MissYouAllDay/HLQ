//
//  YPHotelInfoIconCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/28.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPHotelInfoIconCell.h"

@implementation YPHotelInfoIconCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHotelInfoIconCell";
    YPHotelInfoIconCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHotelInfoIconCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 3;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = CHJ_bgColor.CGColor;
    _iconImgV.layer.borderWidth = 1;
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
