//
//  HRLikeListCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/15.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRLikeListCell.h"

@implementation HRLikeListCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRLikeListCell";
    HRLikeListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRLikeListCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
-(void)setModel:(HRZanModel *)model{
    _model =model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.GivethumbHeadportrait] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.nameLab.text =model.GivethumbName;
    _shenfenLab.text =  [CXDataManager checkUserProfession:model.OccupationCode];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImageView.clipsToBounds =YES;
    self.iconImageView.layer.cornerRadius =30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
