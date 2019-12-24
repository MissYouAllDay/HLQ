//
//  YPKeYuan190320ReAllListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/3/20.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetJSJTableList.h"
NS_ASSUME_NONNULL_BEGIN

@interface YPKeYuan190320ReAllListCell : UITableViewCell

@property (nonatomic, strong) YPGetJSJTableList  *listModel;    // listmodel

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *supplierLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tagImgV;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UILabel *hunqi;
@property (weak, nonatomic) IBOutlet UILabel *zhuoshu;
@property (weak, nonatomic) IBOutlet UILabel *canbiao;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
