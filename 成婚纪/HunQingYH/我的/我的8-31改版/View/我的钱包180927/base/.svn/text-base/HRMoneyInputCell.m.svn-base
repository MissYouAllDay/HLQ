//
//  HRMoneyInputCell.m
//  HunQingYH
//
//  Created by Hiro on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "HRMoneyInputCell.h"

@implementation HRMoneyInputCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"HRMoneyInputCell";
    HRMoneyInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HRMoneyInputCell" owner:nil options:nil] lastObject];
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
