//
//  YPMemberCarTeamInviteCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMemberCarTeamInviteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel        *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *desc;
@property (weak, nonatomic) IBOutlet UIButton       *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton       *acceptBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
