//
//  YPMyKeYuan190312DetailHeadInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/3/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMyKeYuan190312DetailHeadInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yufu;
@property (weak, nonatomic) IBOutlet UILabel *yufuTime;
@property (weak, nonatomic) IBOutlet UILabel *chubu;
@property (weak, nonatomic) IBOutlet UILabel *shiji;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
