//
//  YPActivityListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/5/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPActivityListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
//- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
