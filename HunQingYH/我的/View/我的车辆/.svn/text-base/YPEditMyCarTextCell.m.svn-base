//
//  YPEditMyCarTextCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPEditMyCarTextCell.h"

@implementation YPEditMyCarTextCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPEditMyCarTextCell";
    YPEditMyCarTextCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPEditMyCarTextCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
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
