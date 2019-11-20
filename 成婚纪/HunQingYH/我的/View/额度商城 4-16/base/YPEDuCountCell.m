//
//  YPEDuCountCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/16.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuCountCell.h"

@implementation YPEDuCountCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPEDuCountCell";
    YPEDuCountCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPEDuCountCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
//    _backView.layer.cornerRadius = 10;
//    _backView.clipsToBounds = YES;
}

- (void)setApplyBtn:(UIButton *)applyBtn{
    _applyBtn = applyBtn;
    
    _applyBtn.layer.cornerRadius = 15;
    _applyBtn.clipsToBounds = YES;
    _applyBtn.layer.borderColor = CHJ_bgColor.CGColor;
    _applyBtn.layer.borderWidth = 1;
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
