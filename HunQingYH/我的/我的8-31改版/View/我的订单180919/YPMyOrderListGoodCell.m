//
//  YPMyOrderListGoodCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/19.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyOrderListGoodCell.h"

@implementation YPMyOrderListGoodCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyOrderListGoodCell";
    YPMyOrderListGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyOrderListGoodCell" owner:nil options:nil] lastObject];
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
