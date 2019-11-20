//
//  YPReceiveGiftListCell.h
//  hunqing
//
//  Created by Else丶 on 2017/11/15.
//  Copyright © 2017年 DiKai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YPGetMyPrizesStatusList.h"

@interface YPReceiveGiftListCell : UITableViewCell
//
//@property (nonatomic, strong) YPGetMyPrizesStatusList *giftList;

@property (weak, nonatomic) IBOutlet UIButton *lingjiangBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
