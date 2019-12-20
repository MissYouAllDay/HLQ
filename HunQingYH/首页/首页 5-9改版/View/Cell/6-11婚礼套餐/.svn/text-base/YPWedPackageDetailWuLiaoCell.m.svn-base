//
//  YPWedPackageDetailWuLiaoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPWedPackageDetailWuLiaoCell.h"

@implementation YPWedPackageDetailWuLiaoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPWedPackageDetailWuLiaoCell";
    YPWedPackageDetailWuLiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPWedPackageDetailWuLiaoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setLookBtn:(UIButton *)lookBtn{
    _lookBtn = lookBtn;
    
    _lookBtn.layer.cornerRadius = 3;
    _lookBtn.clipsToBounds = YES;
    _lookBtn.layer.borderColor = LightGrayColor.CGColor;
    _lookBtn.layer.borderWidth = 1;
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
