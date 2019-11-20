//
//  YPHYTHDetailCanBiaoDetailOrderListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailCanBiaoDetailOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
