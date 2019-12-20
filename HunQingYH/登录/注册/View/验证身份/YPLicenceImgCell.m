//
//  YPLicenceImgCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPLicenceImgCell.h"

@implementation YPLicenceImgCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPLicenceImgCell";
    YPLicenceImgCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPLicenceImgCell" owner:nil options:nil] lastObject];
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
