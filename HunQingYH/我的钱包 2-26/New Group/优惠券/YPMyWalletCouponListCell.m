//
//  YPMyWalletCouponListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPMyWalletCouponListCell.h"

@implementation YPMyWalletCouponListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyWalletCouponListCell";
    YPMyWalletCouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyWalletCouponListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setCouponModel:(YPGetUserCouponList *)couponModel{
    _couponModel = couponModel;
    self.price.text = _couponModel.Money;
    self.limitLabel.text = [NSString stringWithFormat:@"满%@元",_couponModel.ConditionMoney];
    self.timeLabel.text = _couponModel.ExpirTtime;
}

- (void)setTopBackView:(UIView *)topBackView{
    _topBackView = topBackView;

//    //绘制圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth-24*2, 80) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = _topBackView.bounds;
//    maskLayer.frame = CGRectMake(0, 0, ScreenWidth-24*2, 80);
    
    maskLayer.path = maskPath.CGPath;
    _topBackView.layer.masksToBounds =YES;
    _topBackView.layer.mask = maskLayer;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 10;
    _backView.layer.masksToBounds = NO;
    
    _backView.layer.borderColor = [UIColor colorWithRed:1.00 green:0.82 blue:0.00 alpha:1.00].CGColor;
    _backView.layer.borderWidth = 1;
    
    _backView.layer.shadowColor = [UIColor colorWithRed:1.00 green:0.82 blue:0.00 alpha:1.00].CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
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
