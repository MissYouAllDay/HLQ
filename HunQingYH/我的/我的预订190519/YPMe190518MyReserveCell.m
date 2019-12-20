//
//  YPMe190518MyReserveCell.m
//  HunQingYH
//
//  Created by Else丶 on 2019/5/19.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPMe190518MyReserveCell.h"

@implementation YPMe190518MyReserveCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMe190518MyReserveCell";
    YPMe190518MyReserveCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMe190518MyReserveCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setCancleBtn:(UIButton *)cancleBtn{
    _cancleBtn = cancleBtn;
    _cancleBtn.layer.borderColor = GrayColor.CGColor;
    _cancleBtn.layer.borderWidth = 1;
    _cancleBtn.layer.cornerRadius = 3;
    _cancleBtn.clipsToBounds = YES;
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
