//
//  YPRegisterProtocolCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/14.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegisterProtocolCell.h"

@implementation YPRegisterProtocolCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPRegisterProtocolCell";
    YPRegisterProtocolCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPRegisterProtocolCell" owner:nil options:nil] lastObject];
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
