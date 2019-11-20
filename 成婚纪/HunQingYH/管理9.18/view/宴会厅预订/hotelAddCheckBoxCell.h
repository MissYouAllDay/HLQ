//
//  hotelAddCheckBoxCell.h
//  HunQingYH
//
//  Created by xl on 2019/6/29.
//  Copyright © 2019 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface hotelAddCheckBoxCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *weixuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *yixuanBtn;

@end

NS_ASSUME_NONNULL_END
