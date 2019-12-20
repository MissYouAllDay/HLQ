//
//  YPReHomeSupplierCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReHomeSupplierCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *anliCount;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiCount;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
