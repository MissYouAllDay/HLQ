//
//  YPMyEDuOrderInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyEDuOrderInfoCell.h"

@implementation YPMyEDuOrderInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyEDuOrderInfoCell";
    YPMyEDuOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyEDuOrderInfoCell" owner:nil options:nil] lastObject];
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
