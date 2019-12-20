//
//  YPReHomeFuLiListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/3/1.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReHomeFuLiListCell.h"

@implementation YPReHomeFuLiListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReHomeFuLiListCell";
    YPReHomeFuLiListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReHomeFuLiListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setImgV:(UIImageView *)imgV{
    _imgV = imgV;
    
    _imgV.layer.cornerRadius = 10;
    _imgV.layer.masksToBounds = NO;
    
    _imgV.layer.shadowColor = BlackColor.CGColor;//shadowColor阴影颜色
    _imgV.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _imgV.layer.shadowRadius = 2;
    _imgV.layer.shadowOpacity = 0.8;//阴影透明度，默认0
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
