//
//  YPOurNewWedsHeaderCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/5.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPOurNewWedsHeaderCell.h"

@implementation YPOurNewWedsHeaderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPOurNewWedsHeaderCell";
    YPOurNewWedsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPOurNewWedsHeaderCell" owner:nil options:nil] lastObject];
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
