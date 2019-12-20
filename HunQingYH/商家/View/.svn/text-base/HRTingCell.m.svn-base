//
//  HRTingCell.m
//  HunQingYH
//
//  Created by DiKai on 2017/9/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRTingCell.h"

@implementation HRTingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRTingCell";
    HRTingCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRTingCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
-(void)setModel:(HRTingModel *)model{
    _model =model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.HotelLogo]placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.nameLab.text =model.BanquetHallName;
    self.numLab.text =[NSString stringWithFormat:@"%zd桌",model.MaxTableCount];
    self.heightLab.text =[NSString stringWithFormat:@"%.2lf￥起",model.CoverPhoto];
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
