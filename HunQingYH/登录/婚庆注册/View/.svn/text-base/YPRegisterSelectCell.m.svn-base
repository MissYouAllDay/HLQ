//
//  YPRegisterSelectCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegisterSelectCell.h"

@implementation YPRegisterSelectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPRegisterSelectCell";
    YPRegisterSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPRegisterSelectCell" owner:nil options:nil] lastObject];
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
