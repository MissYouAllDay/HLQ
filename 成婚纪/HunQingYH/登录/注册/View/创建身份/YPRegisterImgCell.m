//
//  YPRegisterImgCell.m
//  hunqing
//
//  Created by YanpengLee on 2017/6/14.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPRegisterImgCell.h"

@implementation YPRegisterImgCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPRegisterImgCell";
    YPRegisterImgCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPRegisterImgCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
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
