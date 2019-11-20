//
//  YPMyNewlywedsInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/30.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetNewPeopleInfo.h"

@interface YPMyNewlywedsInfoCell : UITableViewCell

@property (nonatomic, strong) YPGetNewPeopleInfo *info;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *xingzuo;
@property (weak, nonatomic) IBOutlet UILabel *jiguan;
@property (weak, nonatomic) IBOutlet UILabel *zhiye;
@property (weak, nonatomic) IBOutlet UILabel *borthTime;
@property (weak, nonatomic) IBOutlet UILabel *qqNum;
@property (weak, nonatomic) IBOutlet UILabel *weixin;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
