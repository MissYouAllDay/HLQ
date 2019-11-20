//
//  YPReActivityDingZhiInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityDingZhiInputCell.h"

@implementation YPReActivityDingZhiInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReActivityDingZhiInputCell";
    YPReActivityDingZhiInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReActivityDingZhiInputCell" owner:nil options:nil] lastObject];
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
