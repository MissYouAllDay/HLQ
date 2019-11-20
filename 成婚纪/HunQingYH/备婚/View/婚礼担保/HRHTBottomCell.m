//
//  HRHTBottomCell.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/19.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHTBottomCell.h"

@implementation HRHTBottomCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRHTBottomCell";
    HRHTBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRHTBottomCell" owner:nil options:nil] lastObject];
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
