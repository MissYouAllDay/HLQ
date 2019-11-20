//
//  YPOtherInputTWCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/5.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPOtherInputTWCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *inputTW;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;

@property (nonatomic, assign) NSInteger maxNum;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
