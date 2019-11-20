//
//  YPReMeGuanzhuFensiListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPUserFollowInfoList.h"

@interface YPReMeGuanzhuFensiListCell : UITableViewCell

@property (nonatomic, strong) YPUserFollowInfoList *listModel; 

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shenfenLabel;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
