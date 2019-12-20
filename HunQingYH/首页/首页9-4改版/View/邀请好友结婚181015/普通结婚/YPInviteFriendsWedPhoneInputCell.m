//
//  YPInviteFriendsWedPhoneInputCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/11/12.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedPhoneInputCell.h"

@implementation YPInviteFriendsWedPhoneInputCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPInviteFriendsWedPhoneInputCell";
    YPInviteFriendsWedPhoneInputCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPInviteFriendsWedPhoneInputCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)setAddressBook:(UIButton *)addressBook{
    _addressBook = addressBook;
    _addressBook.layer.cornerRadius = 3;
    _addressBook.layer.borderWidth = 1;
    _addressBook.layer.borderColor = RGB(29,113,254).CGColor;
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
