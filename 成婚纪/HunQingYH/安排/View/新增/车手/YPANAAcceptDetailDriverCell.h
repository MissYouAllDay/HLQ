//
//  YPANAAcceptDetailDriverCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/21.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPCaptainGetResponseStatus.h"

@interface YPANAAcceptDetailDriverCell : UITableViewCell

@property (nonatomic, strong) YPCaptainGetResponseStatus *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
