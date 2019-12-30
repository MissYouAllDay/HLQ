//
//  YPHYTHBaseListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPBanquetListObj.h"
NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHBaseListCell : UITableViewCell

@property (nonatomic, strong) YPBanquetListObj *list;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIImageView *tagImgV;
@property (weak, nonatomic) IBOutlet UILabel *tingTitle;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *canbiao;
@property (weak, nonatomic) IBOutlet UILabel *lijian;
@property (weak, nonatomic) IBOutlet UILabel *zhuoshu;

@property (weak, nonatomic) IBOutlet UIImageView *allBackImg;   // 全额返现标签

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
