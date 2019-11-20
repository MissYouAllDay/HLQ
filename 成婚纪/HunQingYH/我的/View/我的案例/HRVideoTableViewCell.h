//
//  HRVideoTableViewCell.h
//  HunQingYH
//
//  Created by DiKai on 2017/9/11.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *VideoimageView;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@end
