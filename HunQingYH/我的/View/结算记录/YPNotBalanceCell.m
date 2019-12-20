//
//  YPNotBalanceCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNotBalanceCell.h"

@implementation YPNotBalanceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNotBalanceCell";
    YPNotBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNotBalanceCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setOrderList:(YPGetSupplierrOrderList *)orderList{
    _orderList = orderList;
    
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:_orderList.CorpLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.titleLabel.text = _orderList.CorpName;
    self.nameLabel.text = _orderList.CorpPhone;
    self.phone.hidden = YES;
    self.timeLabel.text = _orderList.WeddingDate;
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 2;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = CHJ_bgColor.CGColor;
    _iconImgV.layer.borderWidth = 1;
    
}

- (void)setJieSuanBtn:(UIButton *)jieSuanBtn{
    _jieSuanBtn = jieSuanBtn;
    
    _jieSuanBtn.layer.cornerRadius = 2;
    _jieSuanBtn.clipsToBounds = YES;
    _jieSuanBtn.layer.borderWidth = 1;
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
