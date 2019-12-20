//
//  YPBHProjectTwoBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPBHProjectTwoBtnCell.h"

@implementation YPBHProjectTwoBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPBHProjectTwoBtnCell";
    YPBHProjectTwoBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPBHProjectTwoBtnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setManBtn:(UIButton *)manBtn{
    _manBtn = manBtn;
    
    _manBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_manBtn setTitleEdgeInsets:UIEdgeInsetsMake(_manBtn.imageView.frame.size.height+30 ,-_manBtn.imageView.frame.size.width+12, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [_manBtn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -_manBtn.titleLabel.bounds.size.width/2.0-35)];//图片距离右边框距离减少图片的宽度，其它不边
}

- (void)setWomanBtn:(UIButton *)womanBtn{
    _womanBtn = womanBtn;
    
    _womanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [_womanBtn setTitleEdgeInsets:UIEdgeInsetsMake(_womanBtn.imageView.frame.size.height+30 ,-_womanBtn.imageView.frame.size.width+12, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [_womanBtn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -_womanBtn.titleLabel.bounds.size.width/2.0-35)];//图片距离右边框距离减少图片的宽度，其它不边
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
