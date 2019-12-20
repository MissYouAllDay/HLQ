//
//  YPMemberCarTeamCaptainCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMemberCarTeamCaptainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
