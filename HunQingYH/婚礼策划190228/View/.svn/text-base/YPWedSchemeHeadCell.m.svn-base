//
//  YPWedSchemeHeadCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/4/5.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPWedSchemeHeadCell.h"

@implementation YPWedSchemeHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWedSchemeHeadCell";
    YPWedSchemeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWedSchemeHeadCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 20;
    _iconImgV.clipsToBounds = YES;
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
