
//
//  YPRegisterInputCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/14.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegisterInputCell.h"

@implementation YPRegisterInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPRegisterInputCell";
    YPRegisterInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPRegisterInputCell" owner:nil options:nil] lastObject];
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
