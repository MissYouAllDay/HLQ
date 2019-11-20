//
//  YPFBKYTwoBtnCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/4/1.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPFBKYTwoBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *hotelBtn;
@property (weak, nonatomic) IBOutlet UIButton *hunqingBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
