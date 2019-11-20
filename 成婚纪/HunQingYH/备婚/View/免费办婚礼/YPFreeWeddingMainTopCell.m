//
//  YPFreeWeddingMainTopCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPFreeWeddingMainTopCell.h"

@implementation YPFreeWeddingMainTopCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFreeWeddingMainTopCell";
    YPFreeWeddingMainTopCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFreeWeddingMainTopCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setTitleLabel:(UILabel *)titleLabel{
    _titleLabel = titleLabel;
    
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
    _titleLabel.textColor = [UIColor colorWithRed:71.5/255 green:71.5/255 blue:71.5/255 alpha:1];
}

- (void)setDescLabel:(UILabel *)descLabel{
    _descLabel = descLabel;
    _descLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    _descLabel.textColor = [UIColor colorWithRed:72/255 green:72/255 blue:72/255 alpha:1];
}

- (void)setApplyBtn:(UIButton *)applyBtn{
    _applyBtn = applyBtn;
    
    _applyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    _applyBtn.layer.cornerRadius = 5;
    _applyBtn.clipsToBounds = YES;
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
