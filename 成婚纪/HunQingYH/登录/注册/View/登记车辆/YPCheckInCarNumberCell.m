//
//  YPCheckInCarNumberCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/26.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPCheckInCarNumberCell.h"

@implementation YPCheckInCarNumberCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPCheckInCarNumberCell";
    YPCheckInCarNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPCheckInCarNumberCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setTitleBtn:(UIButton *)titleBtn{
    _titleBtn = titleBtn;
    
    _titleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    // 重点位置开始
    _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _titleBtn.titleLabel.width + 30, 0, -_titleBtn.titleLabel.width - 30);
    _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_titleBtn.currentImage.size.width, 0, _titleBtn.currentImage.size.width);
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
