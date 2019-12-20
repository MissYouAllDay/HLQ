//
//  YPHYTHDetailSubmitOrderShowPriceCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/2/18.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPHYTHDetailSubmitOrderShowPriceCell.h"

@implementation YPHYTHDetailSubmitOrderShowPriceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHYTHDetailSubmitOrderShowPriceCell";
    YPHYTHDetailSubmitOrderShowPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHYTHDetailSubmitOrderShowPriceCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setBackView1:(UIView *)backView1{
    _backView1 = backView1;
    _backView1.layer.shadowRadius = 4;
    _backView1.layer.shadowColor = BlackColor.CGColor;
    _backView1.layer.shadowOpacity = 0.12;
    _backView1.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)setBackView2:(UIView *)backView2{
    _backView2 = backView2;
    _backView2.layer.shadowRadius = 4;
    _backView2.layer.shadowColor = BlackColor.CGColor;
    _backView2.layer.shadowOpacity = 0.12;
    _backView2.layer.shadowOffset = CGSizeMake(0, 0);
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
