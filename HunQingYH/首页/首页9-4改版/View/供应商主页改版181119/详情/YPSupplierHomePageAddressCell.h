//
//  YPSupplierHomePageAddressCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPSupplierHomePageAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *address;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
