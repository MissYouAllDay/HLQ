//
//  YPChangBuYuSuanCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/4.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPChangBuYuSuanCell.h"

@implementation YPChangBuYuSuanCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPChangBuYuSuanCell";
    YPChangBuYuSuanCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPChangBuYuSuanCell" owner:nil options:nil] lastObject];
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
