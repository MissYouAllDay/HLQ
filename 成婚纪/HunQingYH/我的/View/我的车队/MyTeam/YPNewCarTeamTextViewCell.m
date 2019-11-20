//
//  YPNewCarTeamTextViewCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPNewCarTeamTextViewCell.h"

@implementation YPNewCarTeamTextViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPNewCarTeamTextViewCell";
    YPNewCarTeamTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPNewCarTeamTextViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setInputTW:(UITextView *)inputTW{
    _inputTW = inputTW;
    
    _inputTW.wzb_placeholder = @"请输入车队的简要介绍,不超过150个字";
    _inputTW.wzb_placeholderColor = LightGrayColor;
    _inputTW.font = kNormalFont;
    _inputTW.wzb_minHeight = 50;
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
