//
//  YPMeTHOrderFootOneBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/2/23.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMeTHOrderFootOneBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
