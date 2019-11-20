//
//  YPNewWedsNoDescAddCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewWedsNoDescAddCell.h"

@implementation YPNewWedsNoDescAddCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNewWedsNoDescAddCell";
    YPNewWedsNoDescAddCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNewWedsNoDescAddCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

//- (void)setAddBtn:(UIButton *)addBtn{
//    _addBtn = addBtn;
//    _addBtn.enabled = NO;
//    [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10,0.0, 0.0)];
//    
//    [_addBtn.titleLabel setNumberOfLines:0];
//    [_addBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
