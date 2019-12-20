//
//  YPReActivityPersonOrderCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/8/27.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReActivityPersonOrderCell.h"

@implementation YPReActivityPersonOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReActivityPersonOrderCell";
    YPReActivityPersonOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReActivityPersonOrderCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setImgV:(UIImageView *)imgV{
    _imgV = imgV;
    _imgV.layer.cornerRadius = 10;
    _imgV.clipsToBounds = YES;
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
