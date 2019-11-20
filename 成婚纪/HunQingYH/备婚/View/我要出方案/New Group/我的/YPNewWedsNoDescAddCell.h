//
//  YPNewWedsNoDescAddCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/6.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPNewWedsNoDescAddCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImgV;
//@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIImageView *addImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
