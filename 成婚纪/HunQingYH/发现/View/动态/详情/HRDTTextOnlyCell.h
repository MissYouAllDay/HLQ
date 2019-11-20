//
//  HRDTTextOnlyCell.h
//  HunQingYH
//
//  Created by Hiro on 2018/1/9.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRDTTextOnlyCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@end
