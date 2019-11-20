//
//  YPHYTHOrderPayInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/4.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHOrderPayInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
@property (weak, nonatomic) IBOutlet UILabel *descLab1;
@property (weak, nonatomic) IBOutlet UILabel *descLab2;
@property (weak, nonatomic) IBOutlet UILabel *descLab3;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
