//
//  YPArrangeNewAddListCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/16.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetSupplierrOrderList.h"
#import "YPGetDriverTimetableListByDriverID.h"

@interface YPArrangeNewAddListCell : UITableViewCell

@property (nonatomic, strong) YPGetSupplierrOrderList *order;
///车手专用
@property (nonatomic, strong) YPGetDriverTimetableListByDriverID *driverModel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *hotel;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *accept;
@property (weak, nonatomic) IBOutlet UIButton *refuse;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
