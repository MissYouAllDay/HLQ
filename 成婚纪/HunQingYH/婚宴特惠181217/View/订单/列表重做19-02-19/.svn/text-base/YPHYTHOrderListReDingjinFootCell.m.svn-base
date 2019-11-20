//
//  YPHYTHOrderListReDingjinFootCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/19.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHOrderListReDingjinFootCell.h"

@implementation YPHYTHOrderListReDingjinFootCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHOrderListReDingjinFootCell";
    YPHYTHOrderListReDingjinFootCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHOrderListReDingjinFootCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setDingjin:(UILabel *)dingjin{
    _dingjin  = dingjin;
    if ([UIScreen mainScreen].bounds.size.width <= 320) {
        if (_dingjin.text.length > 3) {
            _dingjin.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 13];
        }else{
            _dingjin.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 18];
        }
    }
    
}

- (void)setDeleteBtn:(UIButton *)deleteBtn{
    _deleteBtn = deleteBtn;
    _deleteBtn.layer.cornerRadius = 14;
    _deleteBtn.clipsToBounds = YES;
    _deleteBtn.layer.borderWidth = 1;
    _deleteBtn.layer.borderColor = RGBS(221).CGColor;
}

- (void)setPayBtn:(UIButton *)payBtn{
    _payBtn = payBtn;
    _payBtn.layer.cornerRadius = 14;
    _payBtn.clipsToBounds = YES;
    _payBtn.layer.borderWidth = 1;
    _payBtn.layer.borderColor = CHJ_RedColor.CGColor;
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
