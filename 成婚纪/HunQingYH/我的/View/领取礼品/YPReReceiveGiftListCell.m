//
//  YPReReceiveGiftListCell.m
//  hunqing
//
//  Created by Else丶 on 2017/11/16.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import "YPReReceiveGiftListCell.h"

@implementation YPReReceiveGiftListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPReReceiveGiftListCell";
    YPReReceiveGiftListCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPReReceiveGiftListCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setLingquBtn:(UIButton *)lingquBtn{
    _lingquBtn = lingquBtn;
    
    _lingquBtn.layer.cornerRadius = 5;
    _lingquBtn.clipsToBounds = YES;
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
