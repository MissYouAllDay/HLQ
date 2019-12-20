//
//  YPEDuAddressListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/5/2.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPEDuAddressListCell.h"

@implementation YPEDuAddressListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPEDuAddressListCell";
    YPEDuAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPEDuAddressListCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    
    _backView.layer.cornerRadius = 10;
    _backView.clipsToBounds = YES;
}

- (void)setDefaultBtn:(UIButton *)defaultBtn{
    _defaultBtn = defaultBtn;
    
    _defaultBtn.enabled = NO;//只是标识 不能点击
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
