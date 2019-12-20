//
//  YPWeddingOrderAddGuanlianCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/8.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderAddGuanlianCell.h"

@implementation YPWeddingOrderAddGuanlianCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWeddingOrderAddGuanlianCell";
    YPWeddingOrderAddGuanlianCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWeddingOrderAddGuanlianCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setPingtai:(UIButton *)pingtai{
    _pingtai = pingtai;
    _pingtai.layer.cornerRadius = 3;
    _pingtai.clipsToBounds = YES;
}

- (void)setShangjia:(UIButton *)shangjia{
    _shangjia = shangjia;
    _shangjia.layer.cornerRadius = 3;
    _shangjia.clipsToBounds = YES;
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
