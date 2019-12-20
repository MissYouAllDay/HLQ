//
//  HRPresentOnlyTextCell.h
//  hunqing
//
//  Created by DiKai on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRPresentOnlyTextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
