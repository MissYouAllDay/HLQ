//
//  YPSelectNormalCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPSelectNormalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
