//
//  YPHYTHDetailSubmitOrderBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/12/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailSubmitOrderBtnCell.h"

@implementation YPHYTHDetailSubmitOrderBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailSubmitOrderBtnCell";
    YPHYTHDetailSubmitOrderBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailSubmitOrderBtnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBtn:(UIButton *)btn{
    _btn = btn;
    _btn.layer.cornerRadius = 4;
    _btn.clipsToBounds = YES;
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
