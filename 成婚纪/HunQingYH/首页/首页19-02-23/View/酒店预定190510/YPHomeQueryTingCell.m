//
//  YPHomeQueryTingCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/10.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHomeQueryTingCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPHomeQueryTingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHomeQueryTingCell";
    YPHomeQueryTingCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHomeQueryTingCell" owner:nil options:nil] lastObject];
        cell.zhuoshu.numberOfLines = 2;
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 7;
    _backView.clipsToBounds = YES;
}

- (void)setReserveBtn:(UIButton *)reserveBtn{
    _reserveBtn = reserveBtn;
    _reserveBtn.layer.cornerRadius = 10.5;
    _reserveBtn.clipsToBounds = YES;
    [_reserveBtn setBackgroundImage:[UIImage gradientImageWithBounds:_reserveBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_reserveBtn setBackgroundImage:[UIImage gradientImageWithBounds:_reserveBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:36/255.0 blue:123/255.0 alpha:1.0],[UIColor colorWithRed:248/255.0 green:109/255.0 blue:113/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
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
