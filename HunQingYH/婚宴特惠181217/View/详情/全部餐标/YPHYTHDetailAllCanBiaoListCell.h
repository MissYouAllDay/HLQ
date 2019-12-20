//
//  YPHYTHDetailAllCanBiaoListCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/19.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailAllCanBiaoListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//@property (weak, nonatomic) IBOutlet UILabel *dingLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *dingImgV;
@property (weak, nonatomic) IBOutlet UIButton *yudingBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
