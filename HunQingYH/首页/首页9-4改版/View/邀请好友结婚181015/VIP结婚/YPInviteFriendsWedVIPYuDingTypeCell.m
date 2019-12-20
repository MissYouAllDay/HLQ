//
//  YPInviteFriendsWedVIPYuDingTypeCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedVIPYuDingTypeCell.h"

@implementation YPInviteFriendsWedVIPYuDingTypeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPInviteFriendsWedVIPYuDingTypeCell";
    YPInviteFriendsWedVIPYuDingTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPInviteFriendsWedVIPYuDingTypeCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setBtn1:(UIButton *)btn1{
    _btn1 = btn1;
    [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
}

- (void)setBtn2:(UIButton *)btn2{
    _btn2 = btn2;
    [_btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
}

- (void)setBtn3:(UIButton *)btn3{
    _btn3 = btn3;
    [_btn3 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
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
