//
//  YPNewMarriedCarCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPNewMarriedCarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
