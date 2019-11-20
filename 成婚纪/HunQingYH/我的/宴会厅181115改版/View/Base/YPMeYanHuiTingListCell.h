//
//  YPMeYanHuiTingListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/15.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMeYanHuiTingListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mianji;
@property (weak, nonatomic) IBOutlet UILabel *cenggao;
@property (weak, nonatomic) IBOutlet UILabel *tableCount;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
