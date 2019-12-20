//
//  YPReActivityDingZhiTypeCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/3.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPReActivityDingZhiTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *xinrenBtn;
@property (weak, nonatomic) IBOutlet UIButton *benrenBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
