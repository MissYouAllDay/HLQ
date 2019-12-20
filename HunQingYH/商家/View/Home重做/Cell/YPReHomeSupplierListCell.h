//
//  YPReHomeSupplierListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWebSupplierList.h"

@interface YPReHomeSupplierListCell : UITableViewCell

@property (nonatomic, strong) YPGetWebSupplierList *gysModel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *anliCount;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiCount;
@property (weak, nonatomic) IBOutlet UIImageView *danbaoImgV;
@property (weak, nonatomic) IBOutlet UIImageView *giftImgV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
