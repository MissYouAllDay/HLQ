//
//  YPMyWalletDailyDetailCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetAPList.h"

@interface YPMyWalletDailyDetailCell : UITableViewCell

@property (nonatomic, strong) YPGetAPList *apModel;

@property (weak, nonatomic) IBOutlet UIImageView *tagImgV;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
