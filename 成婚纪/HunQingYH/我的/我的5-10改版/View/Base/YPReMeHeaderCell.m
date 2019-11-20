//
//  YPReMeHeaderCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeHeaderCell.h"

@implementation YPReMeHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReMeHeaderCell";
    YPReMeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReMeHeaderCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 40;
    _iconImgV.clipsToBounds = YES;
}

- (void)setEditBtn:(UIButton *)editBtn{
    _editBtn = editBtn;
    
    _editBtn.layer.cornerRadius = 3;
    _editBtn.clipsToBounds = YES;
}

- (void)setShenfenLabel:(UILabel *)shenfenLabel{
    _shenfenLabel = shenfenLabel;
    
    _shenfenLabel.layer.cornerRadius = 3;
    _shenfenLabel.clipsToBounds = YES;
    _shenfenLabel.backgroundColor = RGB(250, 80, 120);
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
