//
//  YPAssureListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPAssureListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
