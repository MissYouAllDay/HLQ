//
//  YPToBeSentListCell.m
//  hunqing
//
//  Created by Else丶 on 2018/3/15.
//  Copyright © 2018年 DiKai. All rights reserved.
//

#import "YPToBeSentListCell.h"

@implementation YPToBeSentListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPToBeSentListCell";
    YPToBeSentListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPToBeSentListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setManView:(UIView *)manView{
    _manView = manView;
    
    _manView.layer.cornerRadius = 3.5;
    _manView.clipsToBounds = YES;
}

- (void)setWomanView:(UIView *)womanView{
    _womanView = womanView;
    
    _womanView.layer.cornerRadius = 3.5;
    _womanView.clipsToBounds = YES;
}

- (void)setSendBtn:(UIButton *)sendBtn{
    _sendBtn = sendBtn;
    
    _sendBtn.layer.cornerRadius = 5;
    _sendBtn.clipsToBounds = YES;
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
