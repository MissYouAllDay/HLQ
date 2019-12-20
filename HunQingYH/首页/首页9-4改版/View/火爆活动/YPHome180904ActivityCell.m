//
//  YPHome180904ActivityCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHome180904ActivityCell.h"

@implementation YPHome180904ActivityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome180904ActivityCell";
    YPHome180904ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome180904ActivityCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headBtn.layer.cornerRadius = 4;
    _headBtn.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
