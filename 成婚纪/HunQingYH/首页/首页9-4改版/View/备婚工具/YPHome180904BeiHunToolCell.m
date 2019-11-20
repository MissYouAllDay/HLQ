//
//  YPHome180904BeiHunToolCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHome180904BeiHunToolCell.h"

@implementation YPHome180904BeiHunToolCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome180904BeiHunToolCell";
    YPHome180904BeiHunToolCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome180904BeiHunToolCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView1:(UIView *)backView1{
    _backView1 = backView1;
    
    _backView1.layer.cornerRadius = 2;
    _backView1.layer.masksToBounds = NO;
    _backView1.layer.shadowOffset = CGSizeMake(1,1);
    _backView1.layer.shadowColor = BlackColor.CGColor;//shadowColor阴影颜色
    _backView1.layer.shadowRadius = 2;
    _backView1.layer.shadowOpacity = 0.12;//阴影透明度，默认0
}

- (void)setBackView2:(UIView *)backView2{
    _backView2 = backView2;
    
    _backView2.layer.cornerRadius = 2;
    _backView2.layer.masksToBounds = NO;
    _backView2.layer.shadowOffset = CGSizeMake(1,1);
    _backView2.layer.shadowColor = BlackColor.CGColor;//shadowColor阴影颜色
    _backView2.layer.shadowRadius = 2;
    _backView2.layer.shadowOpacity = 0.12;//阴影透明度，默认0
}

- (void)setBackView3:(UIView *)backView3{
    _backView3 = backView3;
    
    _backView3.layer.cornerRadius = 2;
    _backView3.layer.masksToBounds = NO;
    _backView3.layer.shadowOffset = CGSizeMake(1,1);
    _backView3.layer.shadowColor = BlackColor.CGColor;//shadowColor阴影颜色
    _backView3.layer.shadowRadius = 2;
    _backView3.layer.shadowOpacity = 0.12;//阴影透明度，默认0
}

- (void)setBackView4:(UIView *)backView4{
    _backView4 = backView4;
    
    _backView4.layer.cornerRadius = 2;
    _backView4.layer.masksToBounds = NO;
    _backView4.layer.shadowOffset = CGSizeMake(1,1);
    _backView4.layer.shadowColor = BlackColor.CGColor;//shadowColor阴影颜色
    _backView4.layer.shadowRadius = 2;
    _backView4.layer.shadowOpacity = 0.12;//阴影透明度，默认0
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
