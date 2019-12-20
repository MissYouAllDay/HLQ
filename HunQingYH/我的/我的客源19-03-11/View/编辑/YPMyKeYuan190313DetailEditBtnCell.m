//
//  YPMyKeYuan190313DetailEditBtnCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/3/13.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMyKeYuan190313DetailEditBtnCell.h"

@implementation YPMyKeYuan190313DetailEditBtnCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMyKeYuan190313DetailEditBtnCell";
    YPMyKeYuan190313DetailEditBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMyKeYuan190313DetailEditBtnCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    _backView.layer.cornerRadius = 12;
//    _backView.clipsToBounds = YES;
    _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.08].CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 1;
    _backView.layer.shadowRadius = 6;
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
