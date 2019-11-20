//
//  YPHYTHNoDataCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/15.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHNoDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
