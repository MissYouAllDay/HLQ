//
//  HRTitleOneLineCell.h
//  HunQingYH
//
//  Created by Hiro on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTitleOneLineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
