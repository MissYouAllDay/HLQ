//
//  YPActivityListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPActivityListCell.h"

@implementation YPActivityListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPActivityListCell";
    YPActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPActivityListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 10;
    _iconImgV.layer.masksToBounds = NO;
    
    _iconImgV.layer.shadowColor = LightGrayColor.CGColor;//shadowColor阴影颜色
    _iconImgV.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _iconImgV.layer.shadowRadius = 2;
    _iconImgV.layer.shadowOpacity = 0.8;//阴影透明度，默认0
}

//- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
//{
//    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
//    
//    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
//    float difference = CGRectGetHeight(self.iconImgV.frame) - CGRectGetHeight(self.frame);
//    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
//    
//    CGRect imageRect = self.iconImgV.frame;
//    imageRect.origin.y = -(difference/2)+move;
//    self.iconImgV.frame = imageRect;
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
