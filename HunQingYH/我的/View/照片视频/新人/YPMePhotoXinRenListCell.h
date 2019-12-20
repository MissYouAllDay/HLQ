//
//  YPMePhotoXinRenListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPMePhotoXinRenListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
