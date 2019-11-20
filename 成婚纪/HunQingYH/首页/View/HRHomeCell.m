//
//  HRHomeZhuChiCell.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/17.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHomeCell.h"

@implementation HRHomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRHomeCell";
    HRHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRHomeCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
- (void)setModel:(YPGetFacilitatorList *)model{
    
    _model =model;
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:model.Logo]placeholderImage:[UIImage imageNamed:@"占位图"]];
    _nameLab.text =model.Name;
    _numLab.text =[NSString stringWithFormat:@"案例  %@",model.AnliCount];
    _desLab.text = [NSString stringWithFormat:@"状态  %@",model.StateCount];
}

- (void)setGysModel:(HRGYSModel *)gysModel{
    _gysModel = gysModel;
    
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:gysModel.Headportrait]placeholderImage:[UIImage imageNamed:@"占位图"]];
    _nameLab.text =gysModel.Name;
    _numLab.text =[NSString stringWithFormat:@"案例  %zd",gysModel.TotalCount];
    _desLab.text = [NSString stringWithFormat:@"%@",gysModel.BriefinTroduction];
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
