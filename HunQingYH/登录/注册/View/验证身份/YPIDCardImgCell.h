//
//  YPIDCardImgCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPIDCardImgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhengBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanBtn;
@property (weak, nonatomic) IBOutlet UIButton *handBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
