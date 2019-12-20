//
//  HRCarCell.h
//  HunQingYH
//
//  Created by DiKai on 2017/8/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRCarStyleModel.h"
@interface HRCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**车型模型*/
@property(nonatomic,strong)HRCarStyleModel  *carmodel;
@end
