//
//  YPSupplierInfoAddBaseYouhuiCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/14.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPSupplierInfoAddBaseYouhuiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
