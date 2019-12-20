//
//  YPFangAnNormalCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/5/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPFangAnNormalCell.h"

@implementation YPFangAnNormalCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPFangAnNormalCell";
    YPFangAnNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPFangAnNormalCell" owner:nil options:nil] lastObject];
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
