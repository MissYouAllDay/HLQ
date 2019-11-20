//
//  YPMyEDuOrderGoodCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/4/24.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyEDuOrderGoodCell.h"

@implementation YPMyEDuOrderGoodCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyEDuOrderGoodCell";
    YPMyEDuOrderGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyEDuOrderGoodCell" owner:nil options:nil] lastObject];
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
