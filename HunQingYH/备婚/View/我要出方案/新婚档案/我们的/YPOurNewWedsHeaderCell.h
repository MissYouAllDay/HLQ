//
//  YPOurNewWedsHeaderCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/5.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPOurNewWedsHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
