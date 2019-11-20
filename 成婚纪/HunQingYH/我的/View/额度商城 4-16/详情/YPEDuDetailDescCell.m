//
//  YPEDuDetailDescCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/17.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuDetailDescCell.h"

@implementation YPEDuDetailDescCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPEDuDetailDescCell";
    YPEDuDetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPEDuDetailDescCell" owner:nil options:nil] lastObject];
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
