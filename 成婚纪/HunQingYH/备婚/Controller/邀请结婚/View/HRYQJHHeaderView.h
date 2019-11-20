//
//  HRYQJHHeaderView.h
//  HunQingYH
//
//  Created by Hiro on 2018/2/7.
//  Copyright © 2018年 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRYQJHHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *yaoqingBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenxiangBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)inviteView;
@end
