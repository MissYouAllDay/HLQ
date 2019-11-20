//
//  YPReHomeNewsCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeNewsCell.h"

@implementation YPReHomeNewsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeNewsCell";
    YPReHomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeNewsCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.contentMode = UIViewContentModeScaleAspectFill;
    _iconImgV.clipsToBounds = YES;
}

- (void)setTagLabel:(UILabel *)tagLabel{
    _tagLabel = tagLabel;
    
//    _tagLabel.layer.borderColor = RGB(250, 80, 120).CGColor;
//    _tagLabel.layer.borderWidth = 1;
//    _tagLabel.layer.cornerRadius = 3;
//    _tagLabel.clipsToBounds = YES;
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
