//
//  YPHYTHHeadImgCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHHeadImgCell.h"

@implementation YPHYTHHeadImgCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHHeadImgCell";
    YPHYTHHeadImgCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHHeadImgCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

//- (void)setIconImgV:(UIImageView *)iconImgV{
//    _iconImgV = iconImgV;
//    _iconImgV.layer.cornerRadius = 12;
//    _iconImgV.clipsToBounds = YES;
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
