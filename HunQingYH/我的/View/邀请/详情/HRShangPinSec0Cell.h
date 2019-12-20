//
//  HRShangPinSec0Cell.h
//  Vacshaper
//
//  Created by DiKai on 2017/11/1.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRShangPinSec0Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
