//
//  YPWedPackageDetailInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/11.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWeddingPackageInfo.h"

@interface YPWedPackageDetailInfoCell : UITableViewCell

@property (nonatomic, strong) YPGetWeddingPackageInfo *infoModel; 

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UILabel *tag2;
@property (weak, nonatomic) IBOutlet UILabel *tag3;
@property (weak, nonatomic) IBOutlet UILabel *tag4;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
