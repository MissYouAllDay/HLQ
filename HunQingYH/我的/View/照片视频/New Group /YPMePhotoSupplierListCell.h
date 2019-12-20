//
//  YPMePhotoSupplierListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/3/26.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetCustomerInfoBySupplier.h"

@interface YPMePhotoSupplierListCell : UITableViewCell

@property (nonatomic, strong) YPGetCustomerInfoBySupplier *infoModel;

@property (weak, nonatomic) IBOutlet UIView *manView;
@property (weak, nonatomic) IBOutlet UIView *womanView;
@property (weak, nonatomic) IBOutlet UILabel *manName;
@property (weak, nonatomic) IBOutlet UILabel *manPhone;
@property (weak, nonatomic) IBOutlet UILabel *womanName;
@property (weak, nonatomic) IBOutlet UILabel *womanPhone;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
