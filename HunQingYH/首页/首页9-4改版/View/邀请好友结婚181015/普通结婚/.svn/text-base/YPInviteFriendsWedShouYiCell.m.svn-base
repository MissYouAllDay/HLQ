//
//  YPInviteFriendsWedShouYiCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedShouYiCell.h"

@implementation YPInviteFriendsWedShouYiCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPInviteFriendsWedShouYiCell";
    YPInviteFriendsWedShouYiCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPInviteFriendsWedShouYiCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setShowBtn:(UIButton *)showBtn{
    _showBtn = showBtn;
    
    _showBtn.layer.cornerRadius = 13;
    _showBtn.clipsToBounds = YES;
    _showBtn.layer.borderColor = RGBS(221).CGColor;
    _showBtn.layer.borderWidth = 1;
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
