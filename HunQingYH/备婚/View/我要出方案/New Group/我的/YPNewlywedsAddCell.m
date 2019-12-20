//
//  YPNewlywedsAddCell.m
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewlywedsAddCell.h"

@implementation YPNewlywedsAddCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNewlywedsAddCell";
    YPNewlywedsAddCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNewlywedsAddCell" owner:nil options:nil] lastObject];
    }
    cell.backgroundColor = CHJ_bgColor;
    return cell;
    
}

//- (void)setAddBtn:(UIButton *)addBtn{
//    _addBtn = addBtn;
//    _addBtn.enabled = NO;
//    [_addBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15,0.0, 0.0)];
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
