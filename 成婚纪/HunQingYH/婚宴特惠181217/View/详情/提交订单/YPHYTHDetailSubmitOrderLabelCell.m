//
//  YPHYTHDetailSubmitOrderLabelCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailSubmitOrderLabelCell.h"

@implementation YPHYTHDetailSubmitOrderLabelCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailSubmitOrderLabelCell";
    YPHYTHDetailSubmitOrderLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailSubmitOrderLabelCell" owner:nil options:nil] lastObject];
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
