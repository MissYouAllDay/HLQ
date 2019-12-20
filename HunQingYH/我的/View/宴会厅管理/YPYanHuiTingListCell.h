//
//  YPYanHuiTingListCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/3.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPCollectionList.h"
#import "YPGetBanquetHallList.h"

@interface YPYanHuiTingListCell : UITableViewCell

@property (nonatomic, strong) YPCollectionList *listModel;
@property (nonatomic, strong) YPGetBanquetHallList *hallList;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuoCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cengHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
