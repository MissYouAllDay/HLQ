//
//  YPBannerHotelActivityCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/6/1.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetActivityHotelList.h"

@interface YPBannerHotelActivityCell : UITableViewCell

@property (nonatomic, strong) YPGetActivityHotelList *gysModel;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *anliCount;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiCount;
@property (weak, nonatomic) IBOutlet UIImageView *danbaoImgV;
@property (weak, nonatomic) IBOutlet UIImageView *giftImgV;
//@property (weak, nonatomic) IBOutlet UIButton *tagBtn;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImgV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
