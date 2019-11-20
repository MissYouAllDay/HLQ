//
//  HRZhuChi01Cell.m
//  HunQingYH
//
//  Created by DiKai on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "HRZhuChi01Cell.h"

@implementation HRZhuChi01Cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRZhuChi01Cell";
    HRZhuChi01Cell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRZhuChi01Cell" owner:nil options:nil] lastObject];
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
