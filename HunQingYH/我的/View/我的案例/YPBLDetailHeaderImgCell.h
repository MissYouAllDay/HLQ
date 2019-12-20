//
//  YPBLDetailHeaderImgCell.h
//  MEMCoupon
//
//  Created by YanpengLee on 2016/12/8.
//  Copyright © 2016年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPBLDetailHeaderImgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImgV;
@property (nonatomic, copy) NSString *imgStr;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
