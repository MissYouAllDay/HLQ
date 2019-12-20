//
//  YPNewMarriedCarCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewMarriedCarCell.h"

@implementation YPNewMarriedCarCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNewMarriedCarCell";
    YPNewMarriedCarCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNewMarriedCarCell" owner:nil options:nil] lastObject];
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
