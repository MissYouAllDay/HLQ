//
//  YPPassagerDistribute2Cell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/26.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPassagerDistribute2Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *wedDate;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *upTime;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
