//
//  YPAssureListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAssureListCell.h"

@implementation YPAssureListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPAssureListCell";
    YPAssureListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPAssureListCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.shadowColor = LightGrayColor.CGColor;
    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.3;
    _backView.layer.shadowOffset = CGSizeMake(3, 3);
}

- (void)setCircleView:(UIView *)circleView{
    _circleView = circleView;
    
    _circleView.layer.cornerRadius = 15;
    _circleView.clipsToBounds = YES;
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
