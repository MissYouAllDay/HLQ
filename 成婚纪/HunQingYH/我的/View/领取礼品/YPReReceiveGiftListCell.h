//
//  YPReReceiveGiftListCell.h
//  hunqing
//
//  Created by Else丶 on 2017/11/16.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReReceiveGiftListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *lingquBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
