//
//  YPFangAnNormalCell.h
//  hunqing
//
//  Created by YanpengLee on 2017/5/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPFangAnNormalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
