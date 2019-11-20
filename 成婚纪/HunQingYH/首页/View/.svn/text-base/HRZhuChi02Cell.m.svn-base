//
//  HRZhuChi02Cell.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRZhuChi02Cell.h"

@implementation HRZhuChi02Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRZhuChi02Cell";
    HRZhuChi02Cell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRZhuChi02Cell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
-(void)setModel:(HRAnLiModel *)model{
    _model =model;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.CoverMap]];

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.CoverMap] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    self.desLab.text =model.LogTitle;
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
