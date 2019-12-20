//
//  YPMyNewWedsManThemeCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMyNewWedsManThemeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
