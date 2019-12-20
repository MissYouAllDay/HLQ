//
//  YPHome190226FindSupplierListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/2/26.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHome190226FindSupplierListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *dongtai;
@property (weak, nonatomic) IBOutlet UILabel *anli;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
