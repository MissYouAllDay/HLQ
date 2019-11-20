//
//  YPMyKeYuan190312DetailWedInfoCell.h
//  HunQingYH
//
//  Created by Else丶 on 2019/3/12.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMyKeYuan190312DetailWedInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *wedDate;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuoshu;
@property (weak, nonatomic) IBOutlet UILabel *canbiao;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
