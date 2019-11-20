//
//  HRDTDetailTopCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRDTDetailTopCell.h"

@implementation HRDTDetailTopCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRDTDetailTopCell";
    HRDTDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRDTDetailTopCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.clipsToBounds =YES;
    self.iconImageView.layer.cornerRadius =20;
//    _guanzhuBtn.hidden =YES;
    
    self.shenfengLab.clipsToBounds = YES;
    self.shenfengLab.layer.cornerRadius = 3;

    self.guanzhuBtn.clipsToBounds = YES;
    self.guanzhuBtn.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
