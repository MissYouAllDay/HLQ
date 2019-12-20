//
//  YPGuaranteeHeaderCell.h
//  HunQingYH
//
//  Created by Else丶 on 2017/12/18.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPGuaranteeHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
