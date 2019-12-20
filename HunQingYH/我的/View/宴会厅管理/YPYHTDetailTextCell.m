//
//  YPYHTDetailTextCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/3.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPYHTDetailTextCell.h"

@implementation YPYHTDetailTextCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPYHTDetailTextCell";
    YPYHTDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPYHTDetailTextCell" owner:nil options:nil] lastObject];
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
