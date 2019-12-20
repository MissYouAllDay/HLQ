//
//  YPEditMyCarImgCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/29.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPEditMyCarImgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
