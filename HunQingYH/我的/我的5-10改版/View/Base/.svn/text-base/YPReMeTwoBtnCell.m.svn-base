//
//  YPReMeTwoBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReMeTwoBtnCell.h"

@implementation YPReMeTwoBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReMeTwoBtnCell";
    YPReMeTwoBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReMeTwoBtnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBtn1:(UIButton *)btn1{
    _btn1 = btn1;
    
    _btn1.layer.cornerRadius = 5;
    _btn1.clipsToBounds = YES;
    [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(0.0, -50, 0.0, 0.0)];
    [_btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -30, 0.0, 0.0)];
}

- (void)setBtn2:(UIButton *)btn2{
    _btn2 = btn2;
    
    _btn2.layer.cornerRadius = 5;
    _btn2.clipsToBounds = YES;
    [_btn2 setImageEdgeInsets:UIEdgeInsetsMake(0.0, -50, 0.0, 0.0)];
    [_btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -30, 0.0, 0.0)];
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
