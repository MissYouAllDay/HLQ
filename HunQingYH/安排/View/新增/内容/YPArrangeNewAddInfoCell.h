//
//  YPArrangeNewAddInfoCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/17.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPArrangeNewAddInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *manTitle;
@property (weak, nonatomic) IBOutlet UILabel *womanTitle;

@property (weak, nonatomic) IBOutlet UILabel *manName;
@property (weak, nonatomic) IBOutlet UILabel *manPhone;
@property (weak, nonatomic) IBOutlet UILabel *womanName;
@property (weak, nonatomic) IBOutlet UILabel *womanPhone;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
