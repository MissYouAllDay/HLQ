//
//  YPYaoQingHeaderView.h
//  HunQingYH
//
//  Created by Else丶 on 2017/11/17.
//  Copyright © 2017年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPYaoQingHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteCount;

+ (instancetype)inviteHeaderView;

@end
