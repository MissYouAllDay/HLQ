//
//  YPHunJJSuoPiaoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/7/5.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHunJJSuoPiaoCell.h"

@implementation YPHunJJSuoPiaoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHunJJSuoPiaoCell";
    YPHunJJSuoPiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHunJJSuoPiaoCell" owner:nil options:nil] lastObject];
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
