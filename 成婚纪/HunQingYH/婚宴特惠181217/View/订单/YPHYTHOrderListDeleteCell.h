//
//  YPHYTHOrderListDeleteCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/3.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHOrderListDeleteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *realMoney;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
