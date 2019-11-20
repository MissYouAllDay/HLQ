//
//  YPMyWalletTiXianPriceCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletTiXianPriceCell.h"

@implementation YPMyWalletTiXianPriceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyWalletTiXianPriceCell";
    YPMyWalletTiXianPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyWalletTiXianPriceCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setShiBtn:(UIButton *)shiBtn{
    _shiBtn = shiBtn;
    
    _shiBtn.layer.cornerRadius = 3;
    _shiBtn.clipsToBounds = YES;
    _shiBtn.layer.borderColor = LightGrayColor.CGColor;
    _shiBtn.layer.borderWidth = 1;
}

- (void)setErshiBtn:(UIButton *)ershiBtn{
    _ershiBtn = ershiBtn;
    
    _ershiBtn.layer.cornerRadius = 3;
    _ershiBtn.clipsToBounds = YES;
    _ershiBtn.layer.borderColor = LightGrayColor.CGColor;
    _ershiBtn.layer.borderWidth = 1;
}

- (void)setSanshiBtn:(UIButton *)sanshiBtn{
    _sanshiBtn = sanshiBtn;
    
    _sanshiBtn.layer.cornerRadius = 3;
    _sanshiBtn.clipsToBounds = YES;
    _sanshiBtn.layer.borderColor = LightGrayColor.CGColor;
    _sanshiBtn.layer.borderWidth = 1;
}

- (void)setWushiBtn:(UIButton *)wushiBtn{
    _wushiBtn = wushiBtn;
    
    _wushiBtn.layer.cornerRadius = 3;
    _wushiBtn.clipsToBounds = YES;
    _wushiBtn.layer.borderColor = LightGrayColor.CGColor;
    _wushiBtn.layer.borderWidth = 1;
}

- (void)setYibaiBtn:(UIButton *)yibaiBtn{
    _yibaiBtn = yibaiBtn;
    
    _yibaiBtn.layer.cornerRadius = 3;
    _yibaiBtn.clipsToBounds = YES;
    _yibaiBtn.layer.borderColor = LightGrayColor.CGColor;
    _yibaiBtn.layer.borderWidth = 1;
}

- (void)setTiXianBtn:(UIButton *)tiXianBtn{
    _tiXianBtn = tiXianBtn;
    
    _tiXianBtn.layer.cornerRadius = 22.5;
    _tiXianBtn.clipsToBounds = YES;
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
