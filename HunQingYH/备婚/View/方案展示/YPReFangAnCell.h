//
//  YPReFangAnCell.h
//  hunqing
//
//  Created by YanpengLee on 2017/7/10.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetDemoPlanList.h"
#import "YPGetWebPlanList.h"

@interface YPReFangAnCell : UITableViewCell

@property (nonatomic, strong) YPGetDemoPlanList *planList;
@property (nonatomic, strong) YPGetWebPlanList *webPlanList;


@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenShu;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
//@property (weak, nonatomic) IBOutlet UILabel *tag1;
//@property (weak, nonatomic) IBOutlet UILabel *tag2;
//@property (weak, nonatomic) IBOutlet UILabel *tag3;
//@property (weak, nonatomic) IBOutlet UILabel *tag4;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
