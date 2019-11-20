//
//  YPNormalCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/7/3.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPNormalCell.h"

@implementation YPNormalCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNormalCell";
    YPNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNormalCell" owner:nil options:nil] lastObject];
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
