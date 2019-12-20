//
//  YPKeYuan190320ReAllListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190320ReAllListCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPKeYuan190320ReAllListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPKeYuan190320ReAllListCell";
    YPKeYuan190320ReAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPKeYuan190320ReAllListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setApplyBtn:(UIButton *)applyBtn{
    _applyBtn = applyBtn;
    _applyBtn.layer.cornerRadius = 17.5;
    _applyBtn.clipsToBounds = YES;
    [_applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
    _applyBtn.layer.shadowColor = [UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:0.18].CGColor;
    _applyBtn.layer.shadowOffset = CGSizeMake(0,2);
    _applyBtn.layer.shadowOpacity = 1;
    _applyBtn.layer.shadowRadius = 6;
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
