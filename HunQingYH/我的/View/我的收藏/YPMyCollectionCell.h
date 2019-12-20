//
//  YPMyCollectionCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/3.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMyCollectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
