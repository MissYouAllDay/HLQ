//
//  YPHotelPayHeadCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelPayHeadCell.h"

@implementation YPHotelPayHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHotelPayHeadCell";
    YPHotelPayHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHotelPayHeadCell" owner:nil options:nil] lastObject];
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
