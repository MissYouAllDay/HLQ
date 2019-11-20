//
//  YPMe180831HeadCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/31.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMe180831HeadCell.h"

@implementation YPMe180831HeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMe180831HeadCell";
    YPMe180831HeadCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMe180831HeadCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIButton *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 30;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderColor = WhiteColor.CGColor;
    _iconImgV.layer.borderWidth = 1;
}

- (void)setProfessionBtn:(UIButton *)professionBtn{
    _professionBtn = professionBtn;
    _professionBtn.enabled = NO;
    _professionBtn.layer.cornerRadius = 3;
    _professionBtn.clipsToBounds = YES;
}

- (void)setGoHomePageBtn:(UIButton *)goHomePageBtn{
    _goHomePageBtn = goHomePageBtn;
    _goHomePageBtn.layer.cornerRadius = 13;
    _goHomePageBtn.clipsToBounds = YES;
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
