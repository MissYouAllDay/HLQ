//
//  HRHTTopCell.m
//  HunQingYH
//
//  Created by Hiro on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRHTTopCell.h"

@implementation HRHTTopCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRHTTopCell";
    HRHTTopCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRHTTopCell" owner:nil options:nil] lastObject];
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
