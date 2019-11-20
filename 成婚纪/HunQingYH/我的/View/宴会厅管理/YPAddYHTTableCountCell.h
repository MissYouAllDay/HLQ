//
//  YPAddYHTTableCountCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPAddYHTTableCountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
