//
//  YPKeYuan190306AllListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/6.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190306AllListCell.h"
#import "UIImage+YPGradientImage.h"

@implementation YPKeYuan190306AllListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPKeYuan190306AllListCell";
    YPKeYuan190306AllListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPKeYuan190306AllListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setTag1:(UILabel *)tag1{
    _tag1 = tag1;
    _tag1.layer.cornerRadius = 2;
    _tag1.clipsToBounds = YES;
    _tag1.layer.borderColor = RGB(169, 115, 43).CGColor;
    _tag1.layer.borderWidth = 1;
}

- (void)setTag2:(UILabel *)tag2{
    _tag2 = tag2;
    _tag2.layer.cornerRadius = 2;
    _tag2.clipsToBounds = YES;
    _tag2.layer.borderColor = RGB(236, 89, 56).CGColor;
    _tag2.layer.borderWidth = 1;
}

- (void)setTag3:(UILabel *)tag3{
    _tag3 = tag3;
    _tag3.layer.cornerRadius = 2;
    _tag3.clipsToBounds = YES;
    _tag3.layer.borderColor = RGB(113, 152, 247).CGColor;
    _tag3.layer.borderWidth = 1;
}

- (void)setApplyBtn:(UIButton *)applyBtn{
    _applyBtn = applyBtn;
    _applyBtn.layer.cornerRadius = 18;
    _applyBtn.clipsToBounds = YES;
    [_applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_applyBtn setBackgroundImage:[UIImage gradientImageWithBounds:_applyBtn.frame andColors:@[[UIColor colorWithRed:249/255.0 green:35/255.0 blue:123/255.0 alpha:1.0], [UIColor colorWithRed:248/255.0 green:99/255.0 blue:103/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
}

- (void)setGuanfang:(UIButton *)guanfang{
    _guanfang = guanfang;
    _guanfang.enabled = NO;
    _guanfang.layer.cornerRadius = 2;
    _guanfang.clipsToBounds = YES;
    [_guanfang setBackgroundImage:[UIImage gradientImageWithBounds:_guanfang.frame andColors:@[[UIColor colorWithRed:243/255.0 green:200/255.0 blue:20/255.0 alpha:1.0], [UIColor colorWithRed:251/255.0 green:157/255.0 blue:47/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateNormal];
    [_guanfang setBackgroundImage:[UIImage gradientImageWithBounds:_guanfang.frame andColors:@[[UIColor colorWithRed:243/255.0 green:200/255.0 blue:20/255.0 alpha:1.0], [UIColor colorWithRed:251/255.0 green:157/255.0 blue:47/255.0 alpha:1.0]] andGradientType:1] forState:UIControlStateHighlighted];
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
