//
//  YPNewCarTeamTextViewCell.h
//  HunQingYH
//
//  Created by YanpengLee on 2017/8/15.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+WZB.h"

@interface YPNewCarTeamTextViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTW;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
