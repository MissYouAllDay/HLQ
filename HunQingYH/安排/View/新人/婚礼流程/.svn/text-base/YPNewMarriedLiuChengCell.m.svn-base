//
//  YPNewMarriedLiuChengCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewMarriedLiuChengCell.h"
#import <Chameleon.h>

@implementation YPNewMarriedLiuChengCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNewMarriedLiuChengCell";
    YPNewMarriedLiuChengCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNewMarriedLiuChengCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setTagView:(UIView *)tagView{
    _tagView = tagView;
    
    _tagView.backgroundColor = RandomFlatColor;
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
