//
//  YPHomeQueryTingCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/5/10.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHomeQueryTingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuoshu;
@property (weak, nonatomic) IBOutlet UIButton *lookDetail;
@property (weak, nonatomic) IBOutlet UILabel *yudingState;
@property (weak, nonatomic) IBOutlet UILabel *payState;
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
