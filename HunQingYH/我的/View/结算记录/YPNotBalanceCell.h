//
//  YPNotBalanceCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetSupplierrOrderList.h"

@interface YPNotBalanceCell : UITableViewCell

@property (nonatomic, strong) YPGetSupplierrOrderList *orderList;

@property (weak, nonatomic) IBOutlet UIImageView    *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel        *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *phone;
@property (weak, nonatomic) IBOutlet UIButton       *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel        *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton       *jieSuanBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
