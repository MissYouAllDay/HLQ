//
//  YPArrangeMarriedHunQingListCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/20.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPArrangeMarriedHunQingListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
