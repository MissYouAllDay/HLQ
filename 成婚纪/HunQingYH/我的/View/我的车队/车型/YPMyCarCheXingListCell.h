//
//  YPMyCarCheXingListCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/1.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMyCarCheXingListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
