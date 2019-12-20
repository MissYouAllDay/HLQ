//
//  YPWeddingOrderListSub2Cell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/12.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPWeddingOrderListSub2Cell.h"

@implementation YPWeddingOrderListSub2Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWeddingOrderListSub2Cell";
    YPWeddingOrderListSub2Cell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWeddingOrderListSub2Cell" owner:nil options:nil] lastObject];
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
