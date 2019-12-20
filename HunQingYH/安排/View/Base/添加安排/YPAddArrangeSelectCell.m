//
//  YPAddArrangeSelectCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/28.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPAddArrangeSelectCell.h"

@implementation YPAddArrangeSelectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPAddArrangeSelectCell";
    YPAddArrangeSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPAddArrangeSelectCell" owner:nil options:nil] lastObject];
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
