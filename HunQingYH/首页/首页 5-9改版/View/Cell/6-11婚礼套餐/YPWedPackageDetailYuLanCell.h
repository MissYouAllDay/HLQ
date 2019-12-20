//
//  YPWedPackageDetailYuLanCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPWedPackageDetailYuLanCell : UITableViewCell

@property (nonatomic, strong) NSArray *imgArr;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *moreImgsView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
