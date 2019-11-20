//
//  YPHYTHOrderListReHeadCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/19.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderListReHeadCell.h"

@implementation YPHYTHOrderListReHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderListReHeadCell";
    YPHYTHOrderListReHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderListReHeadCell" owner:nil options:nil] lastObject];
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
