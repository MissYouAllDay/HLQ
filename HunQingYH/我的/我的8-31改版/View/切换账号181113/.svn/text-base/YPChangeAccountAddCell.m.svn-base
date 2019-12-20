//
//  YPChangeAccountAddCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/13.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPChangeAccountAddCell.h"

@implementation YPChangeAccountAddCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPChangeAccountAddCell";
    YPChangeAccountAddCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPChangeAccountAddCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = NO;
    _backView.layer.shadowOffset = CGSizeMake(1,1);
    _backView.layer.shadowColor = BlackColor.CGColor;//shadowColor阴影颜色
    _backView.layer.shadowRadius = 2;
    _backView.layer.shadowOpacity = 0.12;//阴影透明度，默认0
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
