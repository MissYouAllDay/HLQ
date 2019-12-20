//
//  YPFADetailDescCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPFADetailDescCell.h"

@implementation YPFADetailDescCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFADetailDescCell";
    YPFADetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFADetailDescCell" owner:nil options:nil] lastObject];
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
