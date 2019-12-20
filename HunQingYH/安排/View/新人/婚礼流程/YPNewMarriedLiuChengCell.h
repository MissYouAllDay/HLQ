//
//  YPNewMarriedLiuChengCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/24.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPNewMarriedLiuChengCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *content;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
