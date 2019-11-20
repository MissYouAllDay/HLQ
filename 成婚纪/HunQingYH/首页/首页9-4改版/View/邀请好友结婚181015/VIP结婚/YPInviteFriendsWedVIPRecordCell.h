//
//  YPInviteFriendsWedVIPRecordCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/10/16.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import "WSTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPInviteFriendsWedVIPRecordCell : WSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
