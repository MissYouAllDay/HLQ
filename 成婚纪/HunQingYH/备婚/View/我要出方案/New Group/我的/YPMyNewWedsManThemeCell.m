//
//  YPMyNewWedsManThemeCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMyNewWedsManThemeCell.h"

@implementation YPMyNewWedsManThemeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyNewWedsManThemeCell";
    YPMyNewWedsManThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyNewWedsManThemeCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
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
