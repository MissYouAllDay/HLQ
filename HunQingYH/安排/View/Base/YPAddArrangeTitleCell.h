//
//  YPAddArrangeTitleCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/28.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPAddArrangeTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
