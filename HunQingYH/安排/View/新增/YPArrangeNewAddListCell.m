//
//  YPArrangeNewAddListCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPArrangeNewAddListCell.h"

@implementation YPArrangeNewAddListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPArrangeNewAddListCell";
    YPArrangeNewAddListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPArrangeNewAddListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 2;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = bgColor.CGColor;
    _iconImgV.layer.borderWidth = 1;
}

- (void)setAccept:(UIButton *)accept{
    _accept = accept;
    _accept.layer.cornerRadius = 2;
    _accept.clipsToBounds = YES;
    _accept.layer.borderColor = [UIColor redColor].CGColor;
    _accept.layer.borderWidth = 1;
}

- (void)setRefuse:(UIButton *)refuse{
    _refuse = refuse;
    _refuse.layer.cornerRadius = 2;
    _refuse.clipsToBounds = YES;
    _refuse.layer.borderColor = LightGrayColor.CGColor;
    _refuse.layer.borderWidth = 1;
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
