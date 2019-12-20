//
//  YPHome190226FindSupplierListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/26.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190226FindSupplierListCell.h"

@implementation YPHome190226FindSupplierListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome190226FindSupplierListCell";
    YPHome190226FindSupplierListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome190226FindSupplierListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 4;
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
