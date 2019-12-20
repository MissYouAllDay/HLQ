//
//  YPHome180904TaoCanAllListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/4.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetWeddingPackageList.h"

@interface YPHome180904TaoCanAllListCell : UITableViewCell

@property (nonatomic, strong) YPGetWeddingPackageList *listModel;

@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
//@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
//@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UIView *backView;

//@property (weak, nonatomic) IBOutlet UILabel *bigLab;
//@property (weak, nonatomic) IBOutlet UILabel *label2;
//@property (weak, nonatomic) IBOutlet UILabel *label3;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
