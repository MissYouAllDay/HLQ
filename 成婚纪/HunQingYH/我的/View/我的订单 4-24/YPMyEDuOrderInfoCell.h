//
//  YPMyEDuOrderInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/8/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMyEDuOrderInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *address;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
//test 
