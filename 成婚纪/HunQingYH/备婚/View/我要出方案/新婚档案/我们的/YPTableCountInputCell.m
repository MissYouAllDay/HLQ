//
//  YPTableCountInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/5.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPTableCountInputCell.h"

@implementation YPTableCountInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPTableCountInputCell";
    YPTableCountInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPTableCountInputCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 3;
    _backView.clipsToBounds = YES;
    _backView.backgroundColor = CHJ_bgColor;
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
