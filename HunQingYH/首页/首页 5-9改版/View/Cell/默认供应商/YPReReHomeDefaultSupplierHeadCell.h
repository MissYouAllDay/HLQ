//
//  YPReReHomeDefaultSupplierHeadCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/22.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReReHomeDefaultSupplierHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
