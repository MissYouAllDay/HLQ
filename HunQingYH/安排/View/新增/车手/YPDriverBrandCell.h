//
//  YPDriverBrandCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/9/19.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetModelsListBySupplierID.h"

@interface YPDriverBrandCell : UITableViewCell

@property (nonatomic, strong) YPGetModelsListBySupplierID *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *color;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
