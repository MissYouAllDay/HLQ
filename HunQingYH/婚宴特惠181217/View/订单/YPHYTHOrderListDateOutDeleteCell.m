//
//  YPHYTHOrderListDateOutDeleteCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/1/10.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderListDateOutDeleteCell.h"

@implementation YPHYTHOrderListDateOutDeleteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderListDateOutDeleteCell";
    YPHYTHOrderListDateOutDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderListDateOutDeleteCell" owner:nil options:nil] lastObject];
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
