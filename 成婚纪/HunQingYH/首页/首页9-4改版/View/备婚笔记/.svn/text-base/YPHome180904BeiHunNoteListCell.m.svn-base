//
//  YPHome180904BeiHunNoteListCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/9/5.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import "YPHome180904BeiHunNoteListCell.h"

@implementation YPHome180904BeiHunNoteListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPHome180904BeiHunNoteListCell";
    YPHome180904BeiHunNoteListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPHome180904BeiHunNoteListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setImgV:(UIImageView *)imgV{
    _imgV = imgV;
    
    _imgV.layer.cornerRadius = 4;
    _imgV.clipsToBounds = YES;
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
