//
//  YPTextNormalCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/17.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPTextNormalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *content;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
