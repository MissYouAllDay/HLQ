//
//  YPHYTHDetailInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/12/17.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPHYTHDetailInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dongtai;
@property (weak, nonatomic) IBOutlet UILabel *anli;
//@property (weak, nonatomic) IBOutlet UILabel *jianCount;
//@property (weak, nonatomic) IBOutlet UIView *jianView;
@property (weak, nonatomic) IBOutlet UIButton *hotelInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
