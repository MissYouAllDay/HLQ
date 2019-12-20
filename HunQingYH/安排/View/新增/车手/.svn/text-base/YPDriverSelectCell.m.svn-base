//
//  YPDriverSelectCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPDriverSelectCell.h"

@implementation YPDriverSelectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPDriverSelectCell";
    YPDriverSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPDriverSelectCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 3;
    _iconImgV.clipsToBounds = YES;
}

- (void)setTagLabel:(UIButton *)tagLabel{
    _tagLabel = tagLabel;
    [_tagLabel setTitle:@"车手" forState:UIControlStateNormal];
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
