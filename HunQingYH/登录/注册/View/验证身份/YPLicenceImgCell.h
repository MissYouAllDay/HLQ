//
//  YPLicenceImgCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/7/25.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPLicenceImgCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *licenceBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
