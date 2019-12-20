//
//  YPBHProjectTwoBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBHProjectTwoBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
