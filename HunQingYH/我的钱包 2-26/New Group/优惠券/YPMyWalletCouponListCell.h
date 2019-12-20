//
//  YPMyWalletCouponListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/2/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetUserCouponList.h"

@interface YPMyWalletCouponListCell : UITableViewCell

/**模型*/
@property (nonatomic, strong) YPGetUserCouponList *couponModel;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *topBackView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
