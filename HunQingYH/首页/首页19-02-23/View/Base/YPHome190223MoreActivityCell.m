//
//  YPHome190223MoreActivityCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHome190223MoreActivityCell.h"

@implementation YPHome190223MoreActivityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome190223MoreActivityCell";
    YPHome190223MoreActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome190223MoreActivityCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBigBtn:(UIButton *)bigBtn{
    _bigBtn = bigBtn;
    _bigBtn.layer.cornerRadius = 6;
    _bigBtn.clipsToBounds = YES;
}

- (void)setBtn1:(UIButton *)btn1{
    _btn1 = btn1;
    _btn1.layer.cornerRadius = 6;
    _btn1.clipsToBounds = YES;
}

- (void)setBtn2:(UIButton *)btn2{
    _btn2 = btn2;
    _btn2.layer.cornerRadius = 6;
    _btn2.clipsToBounds = YES;
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
