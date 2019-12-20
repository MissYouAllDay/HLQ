//
//  YPHotelPayYiFuFootCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/10.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHotelPayYiFuFootCell.h"

@implementation YPHotelPayYiFuFootCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHotelPayYiFuFootCell";
    YPHotelPayYiFuFootCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHotelPayYiFuFootCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setDeleteBtn:(UIButton *)deleteBtn{
    _deleteBtn = deleteBtn;
    
    _deleteBtn.layer.cornerRadius = 2;
    _deleteBtn.clipsToBounds = YES;
    _deleteBtn.layer.borderColor = RGBS(221).CGColor;
    _deleteBtn.layer.borderWidth = 1;
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
