//
//  YPArrangeDangQiSelfEventCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeDangQiSelfEventCell.h"

@implementation YPArrangeDangQiSelfEventCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPArrangeDangQiSelfEventCell";
    YPArrangeDangQiSelfEventCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPArrangeDangQiSelfEventCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 2;
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
