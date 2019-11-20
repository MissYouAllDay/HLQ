//
//  YPMeTingDetailMoreInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/20.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMeTingDetailMoreInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tingName;
@property (weak, nonatomic) IBOutlet UILabel *mianji;
@property (weak, nonatomic) IBOutlet UILabel *cenggao;
@property (weak, nonatomic) IBOutlet UILabel *whLabel;
@property (weak, nonatomic) IBOutlet UILabel *tableCount;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
