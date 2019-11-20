//
//  YPHYTHDetailSubmitOrderBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailSubmitOrderBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
