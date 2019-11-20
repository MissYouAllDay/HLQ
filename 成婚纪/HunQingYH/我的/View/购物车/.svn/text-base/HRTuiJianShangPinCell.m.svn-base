//
//  HRTuiJianShangPinCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/4/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "HRTuiJianShangPinCell.h"

@implementation HRTuiJianShangPinCell
+ (instancetype)cellWithColView:(UICollectionView *)colView AndIndexPath:(NSIndexPath *)index{
    static NSString *reusedID = @"HRTuiJianShangPinCell";
    HRTuiJianShangPinCell *cell = [colView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:index];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRTuiJianShangPinCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(YPShoppingCartPieceTogether *)model{
    _model =model;
    [self.fmImageView sd_setImageWithURL:[NSURL URLWithString:model.CoverMap]];
    self.nameLab.text =model.CommodityName;
    self.priceLab.text =[NSString stringWithFormat:@"￥%@",model.Quota];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
