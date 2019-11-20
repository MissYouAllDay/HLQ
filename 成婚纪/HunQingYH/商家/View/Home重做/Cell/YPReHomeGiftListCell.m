//
//  YPReHomeGiftListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/1/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeGiftListCell.h"

@implementation YPReHomeGiftListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeGiftListCell";
    YPReHomeGiftListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeGiftListCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = WhiteColor;
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
