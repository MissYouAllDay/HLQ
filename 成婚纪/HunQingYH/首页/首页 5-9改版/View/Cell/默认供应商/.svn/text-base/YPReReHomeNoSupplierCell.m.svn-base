//
//  YPReReHomeNoSupplierCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/22.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPReReHomeNoSupplierCell.h"

@implementation YPReReHomeNoSupplierCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReReHomeNoSupplierCell";
    YPReReHomeNoSupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReReHomeNoSupplierCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.shadowColor = LightGrayColor.CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移，y向下偏移，默认(0, -3),这个跟shadowRadius配合使用
    _backView.layer.shadowRadius = 2;
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
