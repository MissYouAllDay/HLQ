//
//  YPMarriageNoticeCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMarriageNoticeCell.h"

@implementation YPMarriageNoticeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMarriageNoticeCell";
    YPMarriageNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMarriageNoticeCell" owner:nil options:nil] lastObject];
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
