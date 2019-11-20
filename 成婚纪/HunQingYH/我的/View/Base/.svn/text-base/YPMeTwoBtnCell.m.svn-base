//
//  YPMeTwoBtnCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/31.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMeTwoBtnCell.h"

@implementation YPMeTwoBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMeTwoBtnCell";
    YPMeTwoBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMeTwoBtnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setJiesuanBtn:(UIButton *)jiesuanBtn{
    _jiesuanBtn = jiesuanBtn;
    
    [_jiesuanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [_jiesuanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
}

- (void)setAnliBtn:(UIButton *)anliBtn{
    _anliBtn = anliBtn;
    
    [_anliBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [_anliBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
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
