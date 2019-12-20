//
//  YPHYTHOrderListReInfoCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/19.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderListReInfoCell.h"

@implementation YPHYTHOrderListReInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderListReInfoCell";
    YPHYTHOrderListReInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderListReInfoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    _iconImgV.layer.cornerRadius = 2;
    _iconImgV.clipsToBounds = YES;
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
