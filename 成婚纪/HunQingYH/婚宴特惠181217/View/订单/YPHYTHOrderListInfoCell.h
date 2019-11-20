//
//  YPHYTHOrderListInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/1/3.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHOrderListInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *tingName;
@property (weak, nonatomic) IBOutlet UILabel *payState;
@property (weak, nonatomic) IBOutlet UILabel *tableCount;
@property (weak, nonatomic) IBOutlet UILabel *canbiao;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
