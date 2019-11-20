//
//  YPHYTHDetailSubmitOrderShowPriceCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/2/18.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailSubmitOrderShowPriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UILabel *dingjin;
@property (weak, nonatomic) IBOutlet UILabel *weikuan;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
