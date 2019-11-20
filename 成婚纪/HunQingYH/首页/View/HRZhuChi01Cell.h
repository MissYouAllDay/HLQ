//
//  HRZhuChi01Cell.h
//  HunQingYH
//
//  Created by DiKai on 2017/8/22.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRZhuChi01Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
