//
//  YPPopCornGetHistoryListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/3/29.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPGetPopcornReceiveTableList.h"

@interface YPPopCornGetHistoryListCell : UITableViewCell

@property (nonatomic, strong) YPGetPopcornReceiveTableList *listModel;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *sizeType;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
