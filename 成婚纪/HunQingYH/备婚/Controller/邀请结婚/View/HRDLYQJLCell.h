//
//  HRDLYQJLCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/3/6.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRYQJLModel.h"
@interface HRDLYQJLCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**邀请记录模型*/
@property(nonatomic,strong)HRYQJLModel  *model;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *qiandanLab;
@end
