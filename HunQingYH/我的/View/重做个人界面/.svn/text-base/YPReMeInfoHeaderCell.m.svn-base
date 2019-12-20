//
//  YPReMeInfoHeaderCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeInfoHeaderCell.h"

@implementation YPReMeInfoHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReMeInfoHeaderCell";
    YPReMeInfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReMeInfoHeaderCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 40;
    _iconImgV.clipsToBounds = YES;
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
