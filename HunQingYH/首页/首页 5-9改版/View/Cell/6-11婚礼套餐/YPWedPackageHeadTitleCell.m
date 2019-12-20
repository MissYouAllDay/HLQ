//
//  YPWedPackageHeadTitleCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/20.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPackageHeadTitleCell.h"

@implementation YPWedPackageHeadTitleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWedPackageHeadTitleCell";
    YPWedPackageHeadTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWedPackageHeadTitleCell" owner:nil options:nil] lastObject];
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
