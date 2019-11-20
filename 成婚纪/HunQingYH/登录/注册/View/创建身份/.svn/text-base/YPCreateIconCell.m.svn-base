//
//  YPCreateIconCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPCreateIconCell.h"

@implementation YPCreateIconCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPCreateIconCell";
    YPCreateIconCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPCreateIconCell" owner:nil options:nil] lastObject];
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
