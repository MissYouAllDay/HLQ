//
//  YPKeYuan190521MyPubulishCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/21.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPKeYuan190521MyPubulishCell.h"

@implementation YPKeYuan190521MyPubulishCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPKeYuan190521MyPubulishCell";
    YPKeYuan190521MyPubulishCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPKeYuan190521MyPubulishCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 6;
    _backView.clipsToBounds = YES;
    _backView.layer.shadowColor = RGBS(230).CGColor;//shadowColor阴影颜色
    _backView.layer.shadowOffset = CGSizeMake(-1,1);//shadowOffset阴影偏移,x向右偏移，y向下偏移，默认(0, -3),这个跟shadowRadius配合使用
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
