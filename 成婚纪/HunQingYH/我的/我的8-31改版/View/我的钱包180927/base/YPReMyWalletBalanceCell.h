//
//  YPReMyWalletBalanceCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/27.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPReMyWalletBalanceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *balance;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
