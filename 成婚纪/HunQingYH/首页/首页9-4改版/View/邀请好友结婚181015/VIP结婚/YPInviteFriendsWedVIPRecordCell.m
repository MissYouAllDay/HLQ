//
//  YPInviteFriendsWedVIPRecordCell.m
//  HunQingYH
//
//  Created by Else丶 on 2018/10/16.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "YPInviteFriendsWedVIPRecordCell.h"

@implementation YPInviteFriendsWedVIPRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *reusedID = @"YPInviteFriendsWedVIPRecordCell";
    YPInviteFriendsWedVIPRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YPInviteFriendsWedVIPRecordCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}

- (void)accessoryViewAnimation{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            
            self.arrowImgV.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
            self.arrowImgV.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        
        if (!self.isExpanded)
            [self removeIndicatorView];
    }];
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
