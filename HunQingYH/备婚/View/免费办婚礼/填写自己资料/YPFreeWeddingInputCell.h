//
//  YPFreeWeddingInputCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPFreeWeddingInputCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIView *tagView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
