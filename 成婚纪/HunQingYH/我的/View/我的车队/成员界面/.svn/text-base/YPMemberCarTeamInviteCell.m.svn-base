//
//  YPMemberCarTeamInviteCell.m
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import "YPMemberCarTeamInviteCell.h"

@implementation YPMemberCarTeamInviteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPMemberCarTeamInviteCell";
    YPMemberCarTeamInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPMemberCarTeamInviteCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setIconImgV:(UIImageView *)iconImgV{
    _iconImgV = iconImgV;
    
    _iconImgV.layer.cornerRadius = 25;
    _iconImgV.clipsToBounds = YES;
    _iconImgV.layer.borderWidth = 1;
    _iconImgV.layer.borderColor = CHJ_bgColor.CGColor;
}

- (void)setRefuseBtn:(UIButton *)refuseBtn{
    _refuseBtn = refuseBtn;
    
    _refuseBtn.layer.cornerRadius = 3;
    _refuseBtn.clipsToBounds = YES;
    _refuseBtn.layer.borderWidth = 1;
    _refuseBtn.layer.borderColor = GrayColor.CGColor;
}

- (void)setAcceptBtn:(UIButton *)acceptBtn{
    _acceptBtn = acceptBtn;
    
    _acceptBtn.layer.cornerRadius = 3;
    _acceptBtn.clipsToBounds = YES;
    _acceptBtn.layer.borderWidth = 1;
    _acceptBtn.layer.borderColor = [UIColor redColor].CGColor;
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
