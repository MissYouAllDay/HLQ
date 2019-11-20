//
//  YPHome180904BeiHunNoteListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/9/5.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPHome180904BeiHunNoteListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
