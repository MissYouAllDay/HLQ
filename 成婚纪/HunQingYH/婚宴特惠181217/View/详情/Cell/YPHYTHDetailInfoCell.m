//
//  YPHYTHDetailInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailInfoCell.h"

@implementation YPHYTHDetailInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailInfoCell";
    YPHYTHDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailInfoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 4;
    _iconImgV.clipsToBounds = YES;
}

//- (void)setJianView:(UIView *)jianView{
//    _jianView = jianView;
//    _jianView.layer.cornerRadius = 4;
//    _jianView.clipsToBounds = YES;
//    _jianView.backgroundColor = RGB(255, 82, 86);
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
