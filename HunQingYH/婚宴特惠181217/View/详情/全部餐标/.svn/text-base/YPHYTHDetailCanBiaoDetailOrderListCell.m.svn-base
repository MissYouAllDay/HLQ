//
//  YPHYTHDetailCanBiaoDetailOrderListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailCanBiaoDetailOrderListCell.h"

@implementation YPHYTHDetailCanBiaoDetailOrderListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailCanBiaoDetailOrderListCell";
    YPHYTHDetailCanBiaoDetailOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailCanBiaoDetailOrderListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setCircleView:(UIView *)circleView{
    _circleView = circleView;
    _circleView.layer.cornerRadius = 3;
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
